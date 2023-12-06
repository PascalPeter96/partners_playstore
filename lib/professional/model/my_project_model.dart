// To parse this JSON data, do
//
//     final getMyProjectModel = getMyProjectModelFromJson(jsonString);

import 'dart:convert';

GetMyProjectModel getMyProjectModelFromJson(String str) => GetMyProjectModel.fromJson(json.decode(str));

String getMyProjectModelToJson(GetMyProjectModel data) => json.encode(data.toJson());

class GetMyProjectModel {
  GetMyProjectModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<Project>? data;

  factory GetMyProjectModel.fromJson(Map<String, dynamic> json) => GetMyProjectModel(
    code: json["code"],
    msg: json["msg"],
    data: List<Project>.from(json["data"].map((x) => Project.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Project {
  Project({
    this.intGlcode,
    this.fkProfessional,
    this.varTitle,
    this.fkService,
    this.txtDescription,
    this.varImage,
    this.varImageLink,
  });

  String? intGlcode;
  String? fkProfessional;
  String? varTitle;
  String? fkService;
  String? txtDescription;
  VarImage? varImage;
  String? varImageLink;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    intGlcode: json["int_glcode"],
    fkProfessional: json["fk_professional"],
    varTitle: json["var_title"],
    fkService: json["fk_service"],
    txtDescription: json["txt_description"],
    varImage: varImageValues.map[json["var_image"]],
    varImageLink: json["var_image_link"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_professional": fkProfessional,
    "var_title": varTitle,
    "fk_service": fkService,
    "txt_description": txtDescription,
    "var_image": varImageValues.reverse![varImage],
    "var_image_link": varImageLink,
  };
}

enum VarImage { NULL }

final varImageValues = EnumValues({
  "null": VarImage.NULL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) =>  MapEntry(v, k));
    return reverseMap;
  }
}
