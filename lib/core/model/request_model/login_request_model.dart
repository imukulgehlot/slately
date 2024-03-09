// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);
import 'dart:convert';

// Request Model Made From Quick Type
LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  final String? countryCode;
  final String? phoneNumber;
  final String? fcmToken;
  final String? plateform;
  final String? name;
  final dynamic cityId;

  LoginRequestModel({
    this.countryCode,
    this.phoneNumber,
    this.fcmToken,
    this.plateform,
    this.name,
    this.cityId,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        fcmToken: json["fcm_token"],
        plateform: json["plateform"],
        name: json["name"],
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "fcm_token": fcmToken,
        "plateform": plateform,
        "name": name,
        "city_id": cityId,
      };
}
