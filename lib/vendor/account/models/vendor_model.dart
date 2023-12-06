class VendorModel {
  String? intGlcode;
  String? varBusinessName;
  String? varName;
  String? varSurname;
  VendorModel(
      {this.intGlcode, this.varBusinessName, this.varName, this.varSurname});

  factory VendorModel.fromJson(Map<String, dynamic> jsonData) {
    return VendorModel(
      intGlcode: jsonData["int_glcode"] ?? "",
      varBusinessName: jsonData["var_business_name"] ?? "",
      varName: jsonData["var_name"] ?? "",
      varSurname: jsonData["var_surname"] ?? "",
    );
  }
}
