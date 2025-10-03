// lib/app/data/model/business_hour.dart
import 'dart:convert';

BusinessHour businessHourFromJson(String str) =>
    BusinessHour.fromJson(json.decode(str));

String businessHourToJson(BusinessHour data) => json.encode(data.toJson());

class BusinessHour {
  final int userId;
  final String userEmail;
  final List<Schedule> schedule;

  BusinessHour({
    required this.userId,
    required this.userEmail,
    required this.schedule,
  });

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    userId: json["user_id"] as int,
    userEmail: json["user_email"] as String,
    schedule: (json["schedule"] as List)
        .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_email": userEmail,
    "schedule": schedule.map((x) => x.toJson()).toList(),
  };
}

// In lib/app/data/model/business_hour.dart

class Schedule {
  String day;          // <-- UI reads this; must be a weekday name ("Monday")
  String dayDisplay;   // keep if you use it elsewhere
  String? openTime;
  String? closeTime;
  bool isClosed;

  Schedule({
    required this.day,
    required this.dayDisplay,
    this.openTime,
    this.closeTime,
    required this.isClosed,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final idx = _asInt(json['day']);
    // Prefer server's day_display; if missing/short, fall back to index mapping
    String label = (json['day_display'] ?? '').toString().trim();
    if (label.length < 3) {
      label = _weekdayFromIndex(idx); // "Monday", "Tuesday", ...
    }

    return Schedule(
      day: label,                     // ✅ UI-safe
      dayDisplay: label,
      openTime: _asNullableString(json['open_time']),
      closeTime: _asNullableString(json['close_time']),
      isClosed: _asBool(json['is_closed']),
    );
  }

  Map<String, dynamic> toJson() => {
    "day": _indexFromWeekday(day),    // optional if your PATCH needs index
    "day_display": dayDisplay,
    "open_time": openTime,
    "close_time": closeTime,
    "is_closed": isClosed,
  };
}

// ------ helpers (same file) ------
int _asInt(dynamic v) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

String? _asNullableString(dynamic v) => v == null ? null : v.toString();

bool _asBool(dynamic v) {
  if (v is bool) return v;
  if (v is String) return v.toLowerCase() == 'true';
  if (v is num) return v != 0;
  return false;
}

String _weekdayFromIndex(int i) {
  const names = [
    'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
  ];
  return (i >= 0 && i < names.length) ? names[i] : 'Monday';
}

// If you need to serialize back the numeric day for PATCH (optional)
int _indexFromWeekday(String name) {
  switch (name.toLowerCase()) {
    case 'monday': return 0;
    case 'tuesday': return 1;
    case 'wednesday': return 2;
    case 'thursday': return 3;
    case 'friday': return 4;
    case 'saturday': return 5;
    case 'sunday': return 6;
    default: return 0;
  }
}
