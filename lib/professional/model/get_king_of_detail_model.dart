
import 'dart:convert';

GetKingDetail getKingDetailFromJson(String str) => GetKingDetail.fromJson(json.decode(str));

String getKingDetailToJson(GetKingDetail data) => json.encode(data.toJson());

class GetKingDetail {
  GetKingDetail({
    this.code,
    this.msg,
    this.data,
  });

  int? code;
  String? msg;
  Data? data;

  factory GetKingDetail.fromJson(Map<String, dynamic> json) => GetKingDetail(
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
    this.varKinFname,
    this.varKinLname,
    this.varKinCountryCode,
    this.varKinMobileNo,
    this.varKinNationalIdFront,
    this.varKinNationalIdBack,
  });

  String? varKinFname;
  String? varKinLname;
  String? varKinCountryCode;
  String? varKinMobileNo;
  String? varKinNationalIdFront;
  String? varKinNationalIdBack;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    varKinFname: json["var_kin_fname"],
    varKinLname: json["var_kin_lname"],
    varKinCountryCode: json["var_kin_country_code"],
    varKinMobileNo: json["var_kin_mobile_no"],
    varKinNationalIdFront: json["var_kin_national_id_front"],
    varKinNationalIdBack: json["var_kin_national_id_back"],
  );

  Map<String, dynamic> toJson() => {
    "var_kin_fname": varKinFname,
    "var_kin_lname": varKinLname,
    "var_kin_country_code": varKinCountryCode,
    "var_kin_mobile_no": varKinMobileNo,
    "var_kin_national_id_front": varKinNationalIdFront,
    "var_kin_national_id_back": varKinNationalIdBack,
  };
}
