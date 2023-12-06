
import 'dart:convert';

CityData cityDataFromJson(String str) => CityData.fromJson(json.decode(str));

String cityDataToJson(CityData data) => json.encode(data.toJson());

class CityData {
  CityData({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<City>? data;

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
    code: json["code"],
    msg: json["msg"],
    data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class   City {
  City({
    this.intGlcode,
    this.title,
  });

  String? intGlcode;
  String? title;

  factory City.fromJson(Map<String, dynamic> json) => City(
    intGlcode: json["int_glcode"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "title": title,
  };
}
