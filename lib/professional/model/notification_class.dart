// To parse this JSON data, do
//
//     final notificationClass = notificationClassFromJson(jsonString);

import 'dart:convert';

NotificationClass notificationClassFromJson(String str) => NotificationClass.fromJson(json.decode(str));

String notificationClassToJson(NotificationClass data) => json.encode(data.toJson());

class NotificationClass {
  NotificationClass({
    this.code,
    this.msg,
    this.notificationDetail,
  });

  int? code;
  String? msg;
  List<NotificationDetail>? notificationDetail;

  factory NotificationClass.fromJson(Map<String, dynamic> json) => NotificationClass(
    code: json["code"],
    msg: json["msg"],
    notificationDetail: List<NotificationDetail>.from(json["data"].map((x) => NotificationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(notificationDetail!.map((x) => x.toJson())),
  };
}

class NotificationDetail {
  NotificationDetail({
    this.intGlcode,
    this.fkBooking,
    this.fkProfessionalId,
    this.varMessage,
    this.dtCreateddate,
    this.varImage,
    this.varImageLink,
  });

  String? intGlcode;
  String? fkBooking;
  String? fkProfessionalId;
  String? varMessage;
  DateTime? dtCreateddate;
  String? varImage;
  String? varImageLink;

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    intGlcode: json["int_glcode"],
    fkBooking: json["fk_booking"],
    fkProfessionalId: json["fk_professional_id"],
    varMessage: json["var_message"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
    varImage: json["var_image"],
    varImageLink: json["var_image_link"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_booking": fkBooking,
    "fk_professional_id": fkProfessionalId,
    "var_message": varMessage,
    "dt_createddate": dtCreateddate!.toIso8601String(),
    "var_image": varImage,
    "var_image_link": varImageLink,
  };
}
