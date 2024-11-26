class Reminder {
  final String id;
  String title;
  String description;
  DateTime dateTime;
  bool isNotified;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isNotified = false,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      isNotified: json['isNotified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isNotified': isNotified,
    };
  }
}
