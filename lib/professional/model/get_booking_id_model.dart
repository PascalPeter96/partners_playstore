// To parse this JSON data, do
//
//     final getBookingModel = getBookingModelFromJson(jsonString);

import 'dart:convert';

GetBookingModel getBookingModelFromJson(String str) => GetBookingModel.fromJson(json.decode(str));

String getBookingModelToJson(GetBookingModel data) => json.encode(data.toJson());

class GetBookingModel {
  GetBookingModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  Data? data;

  factory GetBookingModel.fromJson(Map<String, dynamic> json) => GetBookingModel(
    code: json["code"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.intGlcode,
    this.fkUser,
    this.bookingId,
    this.fkProfessionalId,
    this.varServiceArr,
    this.varAddress,
    this.varLate,
    this.varLong,
    this.varTotalPrice,
    this.varPayablePrice,
    this.dDate,
    this.tTime,
    this.varStatus,
    this.varPaymentStatus,
    this.chrPublish,
    this.chrDelete,
    this.dtCreateddate,
    this.dtModifydate,
    this.varIpaddress,
    this.userFname,
    this.userSurname,
    this.userMobileNo,
    this.userImage,
  });

  String? intGlcode;
  String? fkUser;
  String? bookingId;
  String? fkProfessionalId;
  List<VarServiceArr>? varServiceArr;
  String? varAddress;
  String? varLate;
  String? varLong;
  String? varTotalPrice;
  String? varPayablePrice;
  DateTime? dDate;
  String? tTime;
  String? varStatus;
  String? varPaymentStatus;
  String? chrPublish;
  String? chrDelete;
  DateTime? dtCreateddate;
  DateTime? dtModifydate;
  String? varIpaddress;
  dynamic userFname;
  String? userSurname;
  String? userMobileNo;
  String? userImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    intGlcode: json["int_glcode"],
    fkUser: json["fk_user"],
    bookingId: json["booking_id"],
    fkProfessionalId: json["fk_professional_id"],
    varServiceArr: List<VarServiceArr>.from(json["var_service_arr"].map((x) => VarServiceArr.fromJson(x))),
    varAddress: json["var_address"],
    varLate: json["var_late"],
    varLong: json["var_long"],
    varTotalPrice: json["var_total_price"],
    varPayablePrice: json["var_payable_price"],
    dDate: DateTime.parse(json["d_date"]),
    tTime: json["t_time"],
    varStatus: json["var_status"],
    varPaymentStatus: json["var_payment_status"],
    chrPublish: json["chr_publish"],
    chrDelete: json["chr_delete"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
    dtModifydate: DateTime.parse(json["dt_modifydate"]),
    varIpaddress: json["var_ipaddress"],
    userFname: json["user_fname"],
    userSurname: json["user_surname"],
    userMobileNo: json["user_mobileNo"],
    userImage: json["user_image"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_user": fkUser,
    "booking_id": bookingId,
    "fk_professional_id": fkProfessionalId,
    "var_service_arr": List<dynamic>.from(varServiceArr!.map((x) => x.toJson())),
    "var_address": varAddress,
    "var_late": varLate,
    "var_long": varLong,
    "var_total_price": varTotalPrice,
    "var_payable_price": varPayablePrice,
    "d_date": "${dDate!.year.toString().padLeft(4, '0')}-${dDate!.month.toString().padLeft(2, '0')}-${dDate!.day.toString().padLeft(2, '0')}",
    "t_time": tTime,
    "var_status": varStatus,
    "var_payment_status": varPaymentStatus,
    "chr_publish": chrPublish,
    "chr_delete": chrDelete,
    "dt_createddate": dtCreateddate!.toIso8601String(),
    "dt_modifydate": dtModifydate!.toIso8601String(),
    "var_ipaddress": varIpaddress,
    "user_fname": userFname,
    "user_surname": userSurname,
    "user_mobileNo": userMobileNo,
    "user_image": userImage,
  };
}

class VarServiceArr {
  VarServiceArr({
    this.serviceTitle,
    this.unitTitle,
    this.varPrice,
  });

  String? serviceTitle;
  String? unitTitle;
  int? varPrice;

  factory VarServiceArr.fromJson(Map<String, dynamic> json) => VarServiceArr(
    serviceTitle: json["service_title"],
    unitTitle: json["unit_title"],
    varPrice: json["var_price"],
  );

  Map<String, dynamic> toJson() => {
    "service_title": serviceTitle,
    "unit_title": unitTitle,
    "var_price": varPrice,
  };
}
