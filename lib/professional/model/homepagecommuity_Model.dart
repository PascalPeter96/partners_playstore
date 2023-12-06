
import 'dart:convert';

HomePageCommuityModel homePageCommuityModelFromJson(String str) => HomePageCommuityModel.fromJson(json.decode(str));

String homePageCommuityModelToJson(HomePageCommuityModel data) => json.encode(data.toJson());

class HomePageCommuityModel {

  HomePageCommuityModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<HomePageCommuity>? data;

  factory HomePageCommuityModel.fromJson(Map<String, dynamic> json) => HomePageCommuityModel(
    code: json["code"],
    msg: json["msg"],
    data: List<HomePageCommuity>.from(json["data"].map((x) => HomePageCommuity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HomePageCommuity {
  HomePageCommuity({
    this.intGlcode,
    this.varTitle,
    this.varIcon,
  });

  String? intGlcode;
  String? varTitle;
  String? varIcon;

  factory HomePageCommuity.fromJson(Map<String, dynamic> json) => HomePageCommuity(
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
