// To parse this JSON data, do
//
//     final timeSlotListClass = timeSlotListClassFromJson(jsonString);

import 'dart:convert';

TimeSlotListClass timeSlotListClassFromJson(String str) => TimeSlotListClass.fromJson(json.decode(str));

String timeSlotListClassToJson(TimeSlotListClass data) => json.encode(data.toJson());

class TimeSlotListClass {
  TimeSlotListClass({
    this.code,
    this.msg,
    this.timeSlotDetailClass,
  });

  int? code;
  String? msg;
  List<TimeSlotDetailClass>? timeSlotDetailClass;

  factory TimeSlotListClass.fromJson(Map<String, dynamic> json) => TimeSlotListClass(
    code: json["code"],
    msg: json["msg"],
    timeSlotDetailClass: List<TimeSlotDetailClass>.from(json["data"].map((x) => TimeSlotDetailClass.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(timeSlotDetailClass!.map((x) => x.toJson())),
  };
}

class TimeSlotDetailClass {
  TimeSlotDetailClass({
    this.intGlcode,
    this.fkProfessional,
    this.startTime,
    this.endTime,
  });

  String? intGlcode;
  String? fkProfessional;
  String? startTime;
  String? endTime;

  factory TimeSlotDetailClass.fromJson(Map<String, dynamic> json) => TimeSlotDetailClass(
    intGlcode: json["int_glcode"],
    fkProfessional: json["fk_professional"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_professional": fkProfessional,
    "start_time": startTime,
    "end_time": endTime,
  };
}
