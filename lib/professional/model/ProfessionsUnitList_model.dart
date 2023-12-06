
import 'dart:convert';

ProfessionsUnitListModel professionsUnitListModelFromJson(String str) => ProfessionsUnitListModel.fromJson(json.decode(str));

String professionsUnitListModelToJson(ProfessionsUnitListModel data) => json.encode(data.toJson());

class ProfessionsUnitListModel {
  ProfessionsUnitListModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<UnitList>? data;

  factory ProfessionsUnitListModel.fromJson(Map<String, dynamic> json) => ProfessionsUnitListModel(
    code: json["code"],
    msg: json["msg"],
    data: List<UnitList>.from(json["data"].map((x) => UnitList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UnitList {
  UnitList({
    this.intGlcode,
    this.title,
  });

  String? intGlcode;
  String? title;

  factory UnitList.fromJson(Map<String, dynamic> json) => UnitList(
    intGlcode: json["int_glcode"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "title": title,
  };
}
