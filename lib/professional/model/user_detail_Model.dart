// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) => UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) => json.encode(data.toJson());

class UserDetailModel {
  UserDetailModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  Data? data;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
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
    this.varImage,
    this.varFname,
    this.varLname,
    this.varEmail,
    this.varCountryCode,
    this.varMobileNo,
    this.varPassword,
    this.varNationalIdFront,
    this.varNationalIdBack,
    this.varAddress,
    this.fkServiceIds,
    this.varLatitude,
    this.varLongitude,
    this.varCity,
    this.paymentMode,
    this.varBankAccount,
    this.varAccountName,
    this.varBankName,
    this.varBankCode,
    this.varBankBranchName,
    this.varKinFname,
    this.varKinLname,
    this.varKinMobileNo,
    this.varKinNationalIdFront,
    this.varKinNationalIdBack,
    this.fkNetworkId,
    this.varMobileMoneyMobileNo,
    this.varRegMobileMoneyMobileNo,
    this.varImageLink,
    this.varNationalIdFrontLink,
    this.varNationalIdBackLink,
    this.certificateData,
  });

  String? intGlcode;
  String? varImage;
  String? varFname;
  String? varLname;
  String? varEmail;
  String? varCountryCode;
  String? varMobileNo;
  String? varPassword;
  String? varNationalIdFront;
  String? varNationalIdBack;
  String? varAddress;
  String? fkServiceIds;
  String? varLatitude;
  String? varLongitude;
  String? varCity;
  String? paymentMode;
  String? varBankAccount;
  String? varAccountName;
  String? varBankName;
  String? varBankCode;
  String? varBankBranchName;
  String? varKinFname;
  String? varKinLname;
  String? varKinMobileNo;
  String? varKinNationalIdFront;
  String? varKinNationalIdBack;
  String? fkNetworkId;
  String? varMobileMoneyMobileNo;
  String? varRegMobileMoneyMobileNo;
  String? varImageLink;
  String? varNationalIdFrontLink;
  String? varNationalIdBackLink;
  List<CertificateDatum>? certificateData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    intGlcode: json["int_glcode"],
    varImage: json["var_image"],
    varFname: json["var_fname"],
    varLname: json["var_lname"],
    varEmail: json["var_email"],
    varCountryCode: json["var_country_code"],
    varMobileNo: json["var_mobile_no"],
    varPassword: json["var_password"],
    varNationalIdFront: json["var_national_id_front"],
    varNationalIdBack: json["var_national_id_back"],
    varAddress: json["var_address"],
    fkServiceIds: json["fk_service_ids"],
    varLatitude: json["var_latitude"],
    varLongitude: json["var_longitude"],
    varCity: json["var_city"],
    paymentMode: json["payment_mode"],
    varBankAccount: json["var_bank_account"],
    varAccountName: json["var_account_name"],
    varBankName: json["var_bank_name"],
    varBankCode: json["var_bank_code"],
    varBankBranchName: json["var_bank_branch_name"],
    varKinFname: json["var_kin_fname"],
    varKinLname: json["var_kin_lname"],
    varKinMobileNo: json["var_kin_mobile_no"],
    varKinNationalIdFront: json["var_kin_national_id_front"],
    varKinNationalIdBack: json["var_kin_national_id_back"],
    fkNetworkId: json["fk_network_id"],
    varMobileMoneyMobileNo: json["var_mobile_money_mobile_no"],
    varRegMobileMoneyMobileNo: json["var_reg_mobile_money_mobile_no"],
    varImageLink: json["var_image_link"],
    varNationalIdFrontLink: json["var_national_id_front_link"],
    varNationalIdBackLink: json["var_national_id_back_link"],
    certificateData: List<CertificateDatum>.from(json["certificate_data"].map((x) => CertificateDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "var_image": varImage,
    "var_fname": varFname,
    "var_lname": varLname,
    "var_email": varEmail,
    "var_country_code": varCountryCode,
    "var_mobile_no": varMobileNo,
    "var_password": varPassword,
    "var_national_id_front": varNationalIdFront,
    "var_national_id_back": varNationalIdBack,
    "var_address": varAddress,
    "fk_service_ids": fkServiceIds,
    "var_latitude": varLatitude,
    "var_longitude": varLongitude,
    "var_city": varCity,
    "payment_mode": paymentMode,
    "var_bank_account": varBankAccount,
    "var_account_name": varAccountName,
    "var_bank_name": varBankName,
    "var_bank_code": varBankCode,
    "var_bank_branch_name": varBankBranchName,
    "var_kin_fname": varKinFname,
    "var_kin_lname": varKinLname,
    "var_kin_mobile_no": varKinMobileNo,
    "var_kin_national_id_front": varKinNationalIdFront,
    "var_kin_national_id_back": varKinNationalIdBack,
    "fk_network_id": fkNetworkId,
    "var_mobile_money_mobile_no": varMobileMoneyMobileNo,
    "var_reg_mobile_money_mobile_no": varRegMobileMoneyMobileNo,
    "var_image_link": varImageLink,
    "var_national_id_front_link": varNationalIdFrontLink,
    "var_national_id_back_link": varNationalIdBackLink,
    "certificate_data": List<dynamic>.from(certificateData!.map((x) => x.toJson())),
  };
}

class CertificateDatum {
  CertificateDatum({
    this.intGlcode,
    this.fkProfessional,
    this.fkServiceId,
    this.fkUnit,
    this.varPrice,
    this.varCertificate,
    this.varCertificateLink,
  });

  String? intGlcode;
  String? fkProfessional;
  String? fkServiceId;
  String? fkUnit;
  String? varPrice;
  String? varCertificate;
  String? varCertificateLink;

  factory CertificateDatum.fromJson(Map<String, dynamic> json) => CertificateDatum(
    intGlcode: json["int_glcode"],
    fkProfessional: json["fk_professional"],
    fkServiceId: json["fk_service_id"],
    fkUnit: json["fk_unit"],
    varPrice: json["var_price"],
    varCertificate: json["var_certificate"],
    varCertificateLink: json["var_certificate_link"],
  );

  Map<String, dynamic> toJson() => {
    "int_glcode": intGlcode,
    "fk_professional": fkProfessional,
    "fk_service_id": fkServiceId,
    "fk_unit": fkUnit,
    "var_price": varPrice,
    "var_certificate": varCertificate,
    "var_certificate_link": varCertificateLink,
  };
}
