// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

BookingModel bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) => json.encode(data.toJson());

class BookingModel {
  BookingModel({
    this.code,
    this.msg,
    required this.data,
  });

  int? code;
  String? msg;
  List<Booking> data ;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    code: json["code"],
    msg: json["msg"],
    data: List<Booking>.from(json["data"].map((x) => Booking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Booking {
  Booking({
    this.intGlcode,
    this.bookingId,
    this.dtCreateddate,
    this.dDate,
    this.tTime,
    this.varStatus,
    this.varImage,
    this.varFname,
    this.varLname,
    this.varAddress,
    this.varMobileno
  });

  String? intGlcode;
  String? bookingId;
  DateTime? dtCreateddate;
  DateTime? dDate;
  String? tTime;
  String? varStatus;
  String? varImage;
  String? varFname;
  String? varLname;
  String? varAddress;
  String? varMobileno;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    intGlcode: json["int_glcode"],
    bookingId: json["booking_id"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
    dDate: DateTime.parse(json["d_date"]),
    tTime: json["t_time"],
    varStatus: json["var_status"],
    varImage: json['var_image'],
    varFname: json['var_fname'],
    varLname: json['var_lname'],
    varAddress: json['var_address'],
    varMobileno: json['var_mobile_no']
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "booking_id": bookingId,
    "dt_createddate": dtCreateddate!.toIso8601String(),
    "d_date": "${dDate!.year.toString().padLeft(4, '0')}-${dDate!.month.toString().padLeft(2, '0')}-${dDate!.day.toString().padLeft(2, '0')}",
    "t_time": tTime,
    "var_status": varStatus,
    "var_image": varImage,
    "var_fname": varFname,
    "var_lname": varLname,
    "var_address": varAddress,
    "var_mobile_no": varMobileno
  };
}
