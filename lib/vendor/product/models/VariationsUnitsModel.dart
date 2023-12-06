
class VariationsUnitModel {
  VariationsUnitModel({
    this.intGlcode,
    this.varTitle,
    this.chrPublish,
    this.chrDelete,
  });

  factory VariationsUnitModel.fromJson(dynamic json) {
    return VariationsUnitModel(
        intGlcode: json['int_glcode'] ?? "",
        varTitle: json['var_title'] ?? "",
        chrPublish: json['chr_publish'] ?? "",
        chrDelete: json['chr_delete'] ?? "");
  }
  String? intGlcode;
  String? varTitle;
  String? chrPublish;
  String? chrDelete;
}
