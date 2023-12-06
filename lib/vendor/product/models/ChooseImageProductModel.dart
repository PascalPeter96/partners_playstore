
class ChooseImageProductModel {
  ChooseImageProductModel({
    this.intGlcode,
    this.varTitle,
    this.varCategory,
    this.varImageUrl,
    this.chrPublish,
    this.chrDelete,
    this.dtCreateddate,
    this.dtModifydate,
    this.varIpaddress,
  });

  factory ChooseImageProductModel.fromJson(dynamic json) {
    return ChooseImageProductModel(
        intGlcode: json['int_glcode'] ?? "",
        varTitle: json['var_title'] ?? "",
        varCategory: json['var_category'] ?? "",
        varImageUrl: json['var_image_url'] ?? "",
        chrPublish: json['chr_publish'] ?? "",
        chrDelete: json['chr_delete'] ?? "",
        dtCreateddate: json['dt_createddate'] ?? "",
        dtModifydate: json['dt_modifydate'] ?? "",
        varIpaddress: json['var_ipaddress'] ?? "");
  }
  String? intGlcode;
  String? varTitle;
  String? varCategory;
  String? varImageUrl;
  String? chrPublish;
  String? chrDelete;
  String? dtCreateddate;
  String? dtModifydate;
  String? varIpaddress;
}
