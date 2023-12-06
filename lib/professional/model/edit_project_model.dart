
import 'dart:convert';

EditProjectModel editProjectModelFromJson(String str) => EditProjectModel.fromJson(json.decode(str));

String editProjectModelToJson(EditProjectModel data) => json.encode(data.toJson());

class EditProjectModel {
  EditProjectModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  List<Edit>? data;

  factory EditProjectModel.fromJson(Map<String, dynamic> json) => EditProjectModel(
    code: json["code"],
    msg: json["msg"],
    data: List<Edit>.from(json["data"].map((x) => Edit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Edit {
  Edit({
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
  String? varImage;
  String? varImageLink;

  factory Edit.fromJson(Map<String, dynamic> json) => Edit(
    intGlcode: json["int_glcode"],
    fkProfessional: json["fk_professional"],
    varTitle: json["var_title"],
    fkService: json["fk_service"],
    txtDescription: json["txt_description"],
    varImage: json["var_image"],
    varImageLink: json["var_image_link"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_professional": fkProfessional,
    "var_title": varTitle,
    "fk_service": fkService,
    "txt_description": txtDescription,
    "var_image": varImage,
    "var_image_link": varImageLink,
  };
}
