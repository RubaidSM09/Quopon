// To parse this JSON data, do
//
//     final businessHour = businessHourFromJson(jsonString);

import 'dart:convert';

BusinessHour businessHourFromJson(String str) => BusinessHour.fromJson(json.decode(str));

String businessHourToJson(BusinessHour data) => json.encode(data.toJson());

class BusinessHour {
  int userId;
  String userEmail;
  List<Schedule> schedule;

  BusinessHour({
    required this.userId,
    required this.userEmail,
    required this.schedule,
  });

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    userId: json["user_id"],
    userEmail: json["user_email"],
    schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_email": userEmail,
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
  };
}

class Schedule {
  int day;
  String dayDisplay;
  String openTime;
  String closeTime;
  bool isClosed;

  Schedule({
    required this.day,
    required this.dayDisplay,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    day: json["day"],
    dayDisplay: json["day_display"],
    openTime: json["open_time"] ?? '00:00:00',
    closeTime: json["close_time"] ?? '23:59:00',
    isClosed: json["is_closed"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "day_display": dayDisplay,
    "open_time": openTime,
    "close_time": closeTime,
    "is_closed": isClosed,
  };
}
