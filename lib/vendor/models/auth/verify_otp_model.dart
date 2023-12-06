// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  String userId;
  String otp;

  VerifyOtpModel({
    required this.userId,
    required this.otp,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
    userId: json["user_id"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "otp": otp,
  };
}
