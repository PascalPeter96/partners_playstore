// To parse this JSON data, do
//
//     final joinCommuityModel = joinCommuityModelFromJson(jsonString);

import 'dart:convert';

JoinCommuityModel joinCommuityModelFromJson(String str) => JoinCommuityModel.fromJson(json.decode(str));

String joinCommuityModelToJson(JoinCommuityModel data) => json.encode(data.toJson());

class JoinCommuityModel {
  JoinCommuityModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<JoinCommuity>? data;

  factory JoinCommuityModel.fromJson(Map<String, dynamic> json) => JoinCommuityModel(
    code: json["code"],
    msg: json["msg"],
    data: List<JoinCommuity>.from(json["data"].map((x) => JoinCommuity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class JoinCommuity {
  JoinCommuity({
    this.intGlcode,
    this.varTitle,
    this.varIcon,
  });

  String? intGlcode;
  String? varTitle;
  String? varIcon;

  factory JoinCommuity.fromJson(Map<String, dynamic> json) => JoinCommuity(
    intGlcode: json["int_glcode"],
    varTitle: json["var_title"],
    varIcon: json["var_icon"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "var_title": varTitle,
    "var_icon": varIcon,
  };
}
