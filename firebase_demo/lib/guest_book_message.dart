class GuestBookMessage {
  GuestBookMessage({
    required this.name,
    required this.message,
    required this.color,
  });

  final String name;
  final String message;
  final int color;

  factory GuestBookMessage.fromMap(Map<String, dynamic> data) {
    return GuestBookMessage(
      name: data['name'] as String,
      message: data['text'] as String,
      color: data['color'] as int? ??
          0xFF000000, // Default to black if no color is set
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': message,
      'color': color,
    };
  }
}
