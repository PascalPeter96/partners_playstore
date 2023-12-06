// To parse this JSON data, do
//
//     final feedClass = feedClassFromJson(jsonString);

import 'dart:convert';

FeedClass feedClassFromJson(String str) => FeedClass.fromJson(json.decode(str));

String feedClassToJson(FeedClass data) => json.encode(data.toJson());

class FeedClass {
  FeedClass({
    this.code,
    this.msg,
    this.feedDetailClass,
  });

  int? code;
  String? msg;
  List<FeedDetailClass>? feedDetailClass;

  factory FeedClass.fromJson(Map<String, dynamic> json) => FeedClass(
    code: json["code"],
    msg: json["msg"],
    feedDetailClass: List<FeedDetailClass>.from(json["data"].map((x) => FeedDetailClass.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(feedDetailClass!.map((x) => x.toJson())),
  };
}

class FeedDetailClass {
  FeedDetailClass({
    this.intGlcode,
    this.fkUser,
    this.fkCoumminty,
    this.txtDescription,
    this.feedImg,
    this.dtCreateddate,
    this.varFname,
    this.varLname,
    this.userImg,
    this.userId,
    this.feedImgLink,
    this.userImgLink,
    this.isLiked,
    this.commentCount,
  });

  String? intGlcode;
  String? fkUser;
  String? fkCoumminty;
  String? txtDescription;
  String? feedImg;
  DateTime? dtCreateddate;
  String? varFname;
  String? varLname;
  String? userImg;
  String? userId;
  String? feedImgLink;
  String? userImgLink;
  String? isLiked;
  int? commentCount;

  factory FeedDetailClass.fromJson(Map<String, dynamic> json) => FeedDetailClass(
    intGlcode: json["int_glcode"],
    fkUser: json["fk_user"],
    fkCoumminty: json["fk_coumminty"],
    txtDescription: json["txt_description"],
    feedImg: json["feed_img"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
    varFname: json["var_fname"],
    varLname: json["var_lname"],
    userImg: json["user_img"],
    userId: json["user_id"],
    feedImgLink: json["feed_img_link"],
    userImgLink: json["user_img_link"],
    isLiked: json["is_liked"],
    commentCount: json["comment_count"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_user": fkUser,
    "fk_coumminty": fkCoumminty,
    "txt_description": txtDescription,
    "feed_img": feedImg,
    "dt_createddate": dtCreateddate!.toIso8601String(),
    "var_fname": varFname,
    "var_lname": varLname,
    "user_img": userImg,
    "user_id": userId,
    "feed_img_link": feedImgLink,
    "user_img_link": userImgLink,
    "is_liked": isLiked,
    "comment_count": commentCount,
  };
}
