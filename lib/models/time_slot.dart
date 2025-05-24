class TimeSlot {
  final String id;
  final String startTime;
  final String endTime;
  final String displayName;
  final String day;

  TimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.displayName,
    required this.day,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      displayName: json['displayName'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
      'displayName': displayName,
      'day': day,
    };
  }
}
