// To parse this JSON data, do
//
//     final reviewAndRatingClass = reviewAndRatingClassFromJson(jsonString);

import 'dart:convert';

ReviewAndRatingClass reviewAndRatingClassFromJson(String str) => ReviewAndRatingClass.fromJson(json.decode(str));

String reviewAndRatingClassToJson(ReviewAndRatingClass data) => json.encode(data.toJson());

class ReviewAndRatingClass {
  ReviewAndRatingClass({
    this.code,
    this.msg,
    this.reviewDetail,
  });

  int? code;
  String? msg;
  List<ReviewDetail>? reviewDetail;

  factory ReviewAndRatingClass.fromJson(Map<String, dynamic> json) => ReviewAndRatingClass(
    code: json["code"],
    msg: json["msg"],
    reviewDetail: List<ReviewDetail>.from(json["data"].map((x) => ReviewDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(reviewDetail!.map((x) => x.toJson())),
  };
}

class ReviewDetail {
  ReviewDetail({
    this.intGlcode,
    this.fkUser,
    this.intRating,
    this.txtReview,
    this.dtCreateddate,
  });

  String? intGlcode;
  String? fkUser;
  String? intRating;
  String? txtReview;
  DateTime? dtCreateddate;

  factory ReviewDetail.fromJson(Map<String, dynamic> json) => ReviewDetail(
    intGlcode: json["int_glcode"],
    fkUser: json["fk_user"],
    intRating: json["int_rating"],
    txtReview: json["txt_review"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_user": fkUser,
    "int_rating": intRating,
    "txt_review": txtReview,
    "dt_createddate": dtCreateddate!.toIso8601String(),
  };
}
