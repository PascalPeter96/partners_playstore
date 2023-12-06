
class BranchModel {
  String? intGlcode;
  String? varName;
  String? varSurname;
  String? varMobileNo;
  String? varCountryCode;
  String? varEmail;
  String? varPassword;
  String? varNationalIdFront;
  String? varNationalIdBack;
  String? nationalIdFrontUrl;
  String? nationalIdBackUrl;
  String? chrPublish;
  List<BranchAddressModel> addressModel;
  BranchModel(
      {this.intGlcode,
      this.varName,
      this.varSurname,
      this.varMobileNo,
      this.varCountryCode,
      this.varEmail,
      this.varNationalIdFront,
      this.varNationalIdBack,
      this.nationalIdFrontUrl,
      this.nationalIdBackUrl,
      this.chrPublish,
      required this.addressModel});
  factory BranchModel.fromJson(Map<String, dynamic> jsonData) {
    return BranchModel(
        intGlcode: jsonData["int_glcode"] ?? "",
        varName: jsonData["var_name"] ?? "",
        varSurname: jsonData["var_surname"] ?? "",
        varMobileNo: jsonData["var_mobile_no"] ?? "",
        varCountryCode: jsonData["var_country_code"] ?? "",
        varEmail: jsonData["var_email"] ?? "",
        chrPublish: jsonData["chr_publish"] ?? "Y",
        varNationalIdFront: jsonData["var_national_id_front"] ?? "",
        varNationalIdBack: jsonData["var_national_id_back"] ?? "",
        nationalIdFrontUrl: jsonData["national_id_front_url"] ?? "",
        nationalIdBackUrl: jsonData["national_id_back_url"] ?? "",
        addressModel: jsonData["address"]
                .map<BranchAddressModel>(
                    (json) => BranchAddressModel.fromJson(json))
                .toList() ??
            []);
  }
}

class BranchAddressModel {
  String? intGlcode;
  String? fkVendor;
  String? varAddress;
  String? varLandmark;
  String? varLatitude;
  String? varLongitude;
  String? varState;
  String? varCountry;
  String? varPincode;
  String? cityId;
  String? varCity;
  BranchAddressModel(
      {this.intGlcode,
      this.fkVendor,
      this.varAddress,
      this.varLandmark,
      this.varLatitude,
      this.varLongitude,
      this.varState,
      this.varCountry,
      this.varPincode,
      this.cityId,
      this.varCity});
  factory BranchAddressModel.fromJson(Map<String, dynamic> jsonData) {
    return BranchAddressModel(
        intGlcode: jsonData["int_glcode"] ?? "",
        fkVendor: jsonData["fk_vendor"] ?? "",
        varAddress: jsonData["var_address"] ?? "",
        varLandmark: jsonData["var_landmark"] ?? "",
        varLatitude: jsonData["var_latitude"] ?? "",
        varLongitude: jsonData["var_longitude"] ?? "",
        varState: jsonData["var_state"] ?? "",
        varCountry: jsonData["var_country"] ?? "",
        varPincode: jsonData["var_pincode"] ?? "",
        cityId: jsonData["city_id"] ?? "",
        varCity: jsonData["var_city"] ?? "");
  }
}
