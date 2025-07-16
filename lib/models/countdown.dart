class Countdown {
  final String id; // A unique ID (e.g., UUID or timestamp)
  final String title; // What is the countdown for?
  final DateTime targetDate; // When it ends
  final String? imagePath; // Optional background or icon

  Countdown({
    required this.id,
    required this.title,
    required this.targetDate,
    this.imagePath,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'targetDate': targetDate.toIso8601String(),
    'imagePath': imagePath,
  };

  // Create from JSON
  factory Countdown.fromJson(Map<String, dynamic> json) {
    final targetDate = DateTime.tryParse(json['targetDate']);
    if (targetDate == null) {
      throw FormatException('Invalid target date');
    }
    return Countdown(
      id: json['id'],
      title: json['title'],
      targetDate: targetDate,
      imagePath: json['imagePath'],
    );
  }

  @override
  String toString() => 'Countdown(id: $id, title: $title, targetDate: $targetDate, imagePath: $imagePath)';

  @override
  int get hashCode => Object.hash(id, title, targetDate, imagePath);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Countdown &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          targetDate == other.targetDate &&
          imagePath == other.imagePath;
}
