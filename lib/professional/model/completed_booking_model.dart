
import 'dart:convert';

CompleteBookingIdModel completeBookingIdModelFromJson(String str) => CompleteBookingIdModel.fromJson(json.decode(str));

String completeBookingIdModelToJson(CompleteBookingIdModel data) => json.encode(data.toJson());

class CompleteBookingIdModel {
  CompleteBookingIdModel({
    this.code,
    this.msg,
  });

  int? code;
  String? msg;

  factory CompleteBookingIdModel.fromJson(Map<String, dynamic> json) => CompleteBookingIdModel(
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
  };
}
