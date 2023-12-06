// To parse this JSON data, do
//
//     final commentClass = commentClassFromJson(jsonString);

import 'dart:convert';

CommentClass commentClassFromJson(String str) => CommentClass.fromJson(json.decode(str));

String commentClassToJson(CommentClass data) => json.encode(data.toJson());

class CommentClass {
  CommentClass({
    this.code,
    this.msg,
    this.commentDetail,
  });

  int? code;
  String? msg;
  List<CommentDetail>? commentDetail;

  factory CommentClass.fromJson(Map<String, dynamic> json) => CommentClass(
    code: json["code"],
    msg: json["msg"],
    commentDetail: List<CommentDetail>.from(json["data"].map((x) => CommentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(commentDetail!.map((x) => x.toJson())),
  };
}

class CommentDetail {
  CommentDetail({
    this.intGlcode,
    this.fkUser,
    this.fkFeed,
    this.txtDescription,
    this.dtCreateddate,
    this.userImg,
    this.isMyComment,
    this.userImgLink,
  });

  String? intGlcode;
  String? fkUser;
  String? fkFeed;
  String? txtDescription;
  DateTime? dtCreateddate;
  String? userImg;
  String? isMyComment;
  String? userImgLink;

  factory CommentDetail.fromJson(Map<String, dynamic> json) => CommentDetail(
    intGlcode: json["int_glcode"],
    fkUser: json["fk_user"],
    fkFeed: json["fk_feed"],
    txtDescription: json["txt_description"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
    userImg: json["user_img"],
    isMyComment: json["is_my_comment"],
    userImgLink: json["user_img_link"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_user": fkUser,
    "fk_feed": fkFeed,
    "txt_description": txtDescription,
    "dt_createddate": dtCreateddate!.toIso8601String(),
    "user_img": userImg,
    "is_my_comment": isMyComment,
    "user_img_link": userImgLink,
  };
}
