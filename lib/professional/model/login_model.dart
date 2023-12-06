
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.fkAdmin,
    this.fkNetworkId,
    this.varMobileMoneyMobileNo,
    this.varRegMobileMoneyMobileNo,
    this.verifyStatus,
    this.varOtp,
    this.varDeviceToken,
    this.varAuthToken,
    this.chrPublish,
    this.chrDelete,
    this.dtCreateddate,
    this.dtModifydate,
    this.varIpaddress,
    this.userType,
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
  String? fkAdmin;
  String? fkNetworkId;
  String? varMobileMoneyMobileNo;
  String? varRegMobileMoneyMobileNo;
  String? verifyStatus;
  String? varOtp;
  String? varDeviceToken;
  String? varAuthToken;
  String? chrPublish;
  String? chrDelete;
  DateTime? dtCreateddate;
  DateTime? dtModifydate;
  String? varIpaddress;
  String? userType;

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
    fkAdmin: json["fk_admin"],
    fkNetworkId: json["fk_network_id"],
    varMobileMoneyMobileNo: json["var_mobile_money_mobile_no"],
    varRegMobileMoneyMobileNo: json["var_reg_mobile_money_mobile_no"],
    verifyStatus: json["verify_status"],
    varOtp: json["var_otp"],
    varDeviceToken: json["var_device_token"],
    varAuthToken: json["var_auth_token"],
    chrPublish: json["chr_publish"],
    chrDelete: json["chr_delete"],
    dtCreateddate: DateTime.parse(json["dt_createddate"]),
    dtModifydate: DateTime.parse(json["dt_modifydate"]),
    varIpaddress: json["var_ipaddress"],
    userType: json["user_type"],
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
    "fk_admin": fkAdmin,
    "fk_network_id": fkNetworkId,
    "var_mobile_money_mobile_no": varMobileMoneyMobileNo,
    "var_reg_mobile_money_mobile_no": varRegMobileMoneyMobileNo,
    "verify_status": verifyStatus,
    "var_otp": varOtp,
    "var_device_token": varDeviceToken,
    "var_auth_token": varAuthToken,
    "chr_publish": chrPublish,
    "chr_delete": chrDelete,
    "dt_createddate": dtCreateddate!.toIso8601String(),
    "dt_modifydate": dtModifydate!.toIso8601String(),
    "var_ipaddress": varIpaddress,
    "user_type": userType,
  };
}
