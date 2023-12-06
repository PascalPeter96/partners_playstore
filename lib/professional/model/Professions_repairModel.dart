
import 'dart:convert';

ProfessionsModel professionsModelFromJson(String str) => ProfessionsModel.fromJson(json.decode(str));

String professionsModelToJson(ProfessionsModel data) => json.encode(data.toJson());

class ProfessionsModel {
  ProfessionsModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<Repair>? data;

  factory ProfessionsModel.fromJson(Map<String, dynamic> json) => ProfessionsModel(
    code: json["code"],
    msg: json["msg"],
    data: List<Repair>.from(json["data"].map((x) => Repair.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Repair {
  Repair({
    this.intGlcode,
    this.varTitle,
  });

  String? intGlcode;
  String? varTitle;

  factory Repair.fromJson(Map<String, dynamic> json) => Repair(
    intGlcode: json["int_glcode"],
    varTitle: json["var_title"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "var_title": varTitle,
  };
}
