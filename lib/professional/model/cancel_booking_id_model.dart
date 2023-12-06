
import 'dart:convert';

CancelBookingIdModel cancelBookingIdModelFromJson(String str) => CancelBookingIdModel.fromJson(json.decode(str));

String cancelBookingIdModelToJson(CancelBookingIdModel data) => json.encode(data.toJson());

class CancelBookingIdModel {
  CancelBookingIdModel({
    this.code,
    this.msg,
  });

  int? code;
  String? msg;

  factory CancelBookingIdModel.fromJson(Map<String, dynamic> json) => CancelBookingIdModel(
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
  };
}
