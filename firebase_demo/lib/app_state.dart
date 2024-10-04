import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'guest_book_message.dart';

enum Attending { yes, no, unknown }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  int _attendees = 0;
  int get attendees => _attendees;

  Attending _attending = Attending.unknown;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;
  Attending get attending => _attending;
  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set(<String, dynamic>{'attending': true});
    } else {
      userDoc.set(<String, dynamic>{'attending': false});
    }
  }

  int _userColor = 0xFF000000; // Default color (black)
  int get userColor => _userColor;

  set userColor(int color) {
    _userColor = color;
    _updateUserColor();
    notifyListeners();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _fetchUserColor(user.uid);
        _subscribeToGuestBook();
        _subscribeToAttendees(user.uid);
      } else {
        _loggedIn = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  void _fetchUserColor(String uid) {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((doc) {
      if (doc.exists && doc.data()?['color'] != null) {
        _userColor = doc.data()!['color'] as int;
        notifyListeners();
      }
    }).catchError((error) {
      if (error is FirebaseException && error.code == 'permission-denied') {
        print(
            "Permission denied when fetching user color. Ensure Firestore rules are set correctly.");
        // Handle the permission denied error (e.g., use default color, show a message to the user)
      } else {
        print("Error fetching user color: $error");
      }
    });
  }

  void _subscribeToGuestBook() {
    _guestBookSubscription = FirebaseFirestore.instance
        .collection('guestbook')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _guestBookMessages = [];
      for (final document in snapshot.docs) {
        _guestBookMessages.add(GuestBookMessage.fromMap(document.data()));
      }
      notifyListeners();
    }, onError: (error) {
      print("Error subscribing to guestbook: $error");
      // Handle the error appropriately
    });
  }

  void _subscribeToAttendees(String uid) {
    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    }, onError: (error) {
      print("Error subscribing to attendees: $error");
      // Handle the error appropriately
    });

    _attendingSubscription = FirebaseFirestore.instance
        .collection('attendees')
        .doc(uid)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.data() != null) {
        _attending = snapshot.data()!['attending'] as bool
            ? Attending.yes
            : Attending.no;
      } else {
        _attending = Attending.unknown;
      }
      notifyListeners();
    }, onError: (error) {
      print("Error subscribing to user attendance: $error");
      // Handle the error appropriately
    });
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'color': _userColor,
    });
  }

  Future<void> _updateUserColor() async {
    if (!_loggedIn) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'color': _userColor}, SetOptions(merge: true));
    } catch (e) {
      print("Error updating user color: $e");
      // Handle the error appropriately
    }
  }
}
