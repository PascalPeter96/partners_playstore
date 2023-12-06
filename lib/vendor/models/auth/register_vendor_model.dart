// To parse this JSON data, do
//
//     final registerVendorModel = registerVendorModelFromJson(jsonString);

import 'dart:convert';

RegisterVendorModel registerVendorModelFromJson(String str) => RegisterVendorModel.fromJson(json.decode(str));

String registerVendorModelToJson(RegisterVendorModel data) => json.encode(data.toJson());

class RegisterVendorModel {
  String email;
  dynamic avator;
  String businessName;
  dynamic nationalIdFront;
  dynamic nationalIdBack;
  dynamic tradingLicense;
  String phoneNo;
  String address;
  String firstname;
  String surname;
  dynamic accountName;
  dynamic accountNumber;
  dynamic bankName;
  dynamic mobileMoneyNumber;
  dynamic mobileMoneyNames;
  dynamic mobileMoneyProvider;
  String nextOfKinFirstname;
  String nextOfKinSurname;
  String nextOfKinPhoneNo;
  dynamic nextOfKinNationalIdFront;
  dynamic nextOfKinNationalIdBack;

  RegisterVendorModel({
    required this.email,
    required this.avator,
    required this.businessName,
    required this.nationalIdFront,
    required this.nationalIdBack,
    required this.tradingLicense,
    required this.phoneNo,
    required this.address,
    required this.firstname,
    required this.surname,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.mobileMoneyNumber,
    required this.mobileMoneyNames,
    required this.mobileMoneyProvider,
    required this.nextOfKinFirstname,
    required this.nextOfKinSurname,
    required this.nextOfKinPhoneNo,
    required this.nextOfKinNationalIdFront,
    required this.nextOfKinNationalIdBack,
  });

  factory RegisterVendorModel.fromJson(Map<String, dynamic> json) => RegisterVendorModel(
    email: json["email"],
    avator: json["avator"],
    businessName: json["business_name"],
    nationalIdFront: json["national_id_front"],
    nationalIdBack: json["national_id_back"],
    tradingLicense: json["trading_license"],
    phoneNo: json["phone_no"],
    address: json["address"],
    firstname: json["firstname"],
    surname: json["surname"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    bankName: json["bank_name"],
    mobileMoneyNumber: json["mobile_money_number"],
    mobileMoneyNames: json["mobile_money_names"],
    mobileMoneyProvider: json["mobile_money_provider"],
    nextOfKinFirstname: json["next_of_kin_firstname"],
    nextOfKinSurname: json["next_of_kin_surname"],
    nextOfKinPhoneNo: json["next_of_kin_phone_no"],
    nextOfKinNationalIdFront: json["next_of_kin_national_id_front"],
    nextOfKinNationalIdBack: json["next_of_kin_national_id_back"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "avator": avator,
    "business_name": businessName,
    "national_id_front": nationalIdFront,
    "national_id_back": nationalIdBack,
    "trading_license": tradingLicense,
    "phone_no": phoneNo,
    "address": address,
    "firstname": firstname,
    "surname": surname,
    "account_name": accountName,
    "account_number": accountNumber,
    "bank_name": bankName,
    "mobile_money_number": mobileMoneyNumber,
    "mobile_money_names": mobileMoneyNames,
    "mobile_money_provider": mobileMoneyProvider,
    "next_of_kin_firstname": nextOfKinFirstname,
    "next_of_kin_surname": nextOfKinSurname,
    "next_of_kin_phone_no": nextOfKinPhoneNo,
    "next_of_kin_national_id_front": nextOfKinNationalIdFront,
    "next_of_kin_national_id_back": nextOfKinNationalIdBack,
  };
}
