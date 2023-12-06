
class VariationsColorModel {
  VariationsColorModel({
    this.intGlcode,
    this.varTitle,
    this.chrPublish,
    this.chrDelete,
    this.varIpaddress,
  });

  factory VariationsColorModel.fromJson(dynamic json) {
    return VariationsColorModel(
        intGlcode: json['int_glcode'] ?? "",
        varTitle: json['var_title'] ?? "",
        chrPublish: json['chr_publish'] ?? "",
        chrDelete: json['chr_delete'] ?? "",
        varIpaddress: json['var_ipaddress'] ?? "");
  }
  String? intGlcode;
  String? varTitle;
  String? chrPublish;
  String? chrDelete;
  String? varIpaddress;
}
