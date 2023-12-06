
class CategoryModel {
  CategoryModel({
    this.intGlcode,
    this.varTitle,
    this.varIcon,
  });

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
        intGlcode: json['int_glcode'] ?? "",
        varTitle: json['var_title'] ?? "",
        varIcon: json['var_icon'] ?? "");
  }
  String? intGlcode;
  String? varTitle;
  String? varIcon;
}
