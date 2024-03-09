// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) =>
    NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) =>
    json.encode(data.toJson());

class NotificationResponseModel {
  final int? id;
  final int? type;
  final String? text;
  final int? senderId;
  final dynamic redirectOn;
  final DateTime? createdAt;

  NotificationResponseModel({
    this.id,
    this.type,
    this.text,
    this.senderId,
    this.redirectOn,
    this.createdAt,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationResponseModel(
        id: json["id"],
        type: json["type"],
        text: json["text"],
        senderId: json["sender_id"],
        redirectOn: json["redirect_on"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "text": text,
        "sender_id": senderId,
        "redirect_on": redirectOn,
        "created_at": createdAt?.toIso8601String(),
      };
}
