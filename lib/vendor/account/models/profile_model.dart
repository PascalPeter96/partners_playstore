class ProfileModel {
  String? intGlcode;
  String? varBusiness_name;
  String? varName;
  String? varSurname;
  String? varMobileNo;
  String? varCountryCode;
  String? varEmail;
  String? varImage;
  String? varBankAccount;
  String? varAccountName;
  String? varBankName;
  String? varBankCode;
  String? intCity;
  String? varBankBranchName;
  String? varAuthToken;
  String? varCountry;
  String? varNationalIdFront;
  String? varNationalIdBack;

  ProfileModel(
      {this.intGlcode,
      this.varBusiness_name,
      this.varName,
      this.varSurname,
      this.varMobileNo,
      this.varCountryCode,
      this.varEmail,
      this.varImage,
      this.varBankAccount,
      this.varAccountName,
      this.varBankName,
      this.varBankCode,
      this.varBankBranchName,
      this.varAuthToken,
      this.varCountry,
      this.intCity,
      this.varNationalIdFront,
      this.varNationalIdBack});

  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
        intGlcode: jsonData["int_glcode"] ?? "",
        varBusiness_name: jsonData["var_business_name"] ?? "",
        varName: jsonData["var_name"] ?? "",
        varSurname: jsonData["var_surname"] ?? "",
        varMobileNo: jsonData["var_mobile_no"] ?? "",
        varCountryCode: jsonData["var_country_code"] ?? "",
        varEmail: jsonData["var_email"] ?? "",
        varImage: jsonData["var_image"] ?? "",
        varBankAccount: jsonData["var_bank_account"] ?? "",
        varAccountName: jsonData["var_account_name"] ?? "",
        varBankName: jsonData["var_bank_name"] ?? "",
        varBankCode: jsonData["var_bank_code"] ?? "",
        varBankBranchName: jsonData["var_bank_branch_name"] ?? "",
        varAuthToken: jsonData["var_auth_token"] ?? "",
        varCountry: jsonData["var_country"] ?? "",
        varNationalIdFront: jsonData["var_national_id_front"] ?? "",
        intCity: jsonData["int_city"] ?? "",
        varNationalIdBack: jsonData["var_national_id_back"] ?? "");
  }
}
