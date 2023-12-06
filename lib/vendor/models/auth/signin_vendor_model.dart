// To parse this JSON data, do
//
//     final signInVendorModel = signInVendorModelFromJson(jsonString);

import 'dart:convert';

SignInVendorModel signInVendorModelFromJson(String str) => SignInVendorModel.fromJson(json.decode(str));

String signInVendorModelToJson(SignInVendorModel data) => json.encode(data.toJson());

class SignInVendorModel {
  String phoneNo;

  SignInVendorModel({
    required this.phoneNo,
  });

  factory SignInVendorModel.fromJson(Map<String, dynamic> json) => SignInVendorModel(
    phoneNo: json["phone_no"],
  );

  Map<String, dynamic> toJson() => {
    "phone_no": phoneNo,
  };
}
