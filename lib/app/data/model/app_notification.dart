// lib/app/data/model/app_notification.dart
import 'dart:convert';

class AppNotification {
  final int id;
  final String title;
  final String body;
  final String type; // "promotion" | "system" | ...
  final Map<String, dynamic> data;
  final bool read;
  final DateTime createdAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.data,
    required this.read,
    required this.createdAt,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      data: (json['data'] is Map)
          ? Map<String, dynamic>.from(json['data'])
          : (json['data'] is String && json['data'].toString().isNotEmpty)
          ? Map<String, dynamic>.from(jsonDecode(json['data']))
          : <String, dynamic>{},
      read: json['read'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  static List<AppNotification> listFromJson(dynamic decoded) {
    if (decoded is List) {
      return decoded.map((e) => AppNotification.fromJson(e)).toList();
    }
    return <AppNotification>[];
  }

  // 👇 add this
  AppNotification copyWith({
    int? id,
    String? title,
    String? body,
    String? type,
    Map<String, dynamic>? data,
    bool? read,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      data: data ?? this.data,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
