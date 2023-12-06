class CityModel {
  String? intGlCode;
  String? title;
  CityModel({this.intGlCode, this.title});
  factory CityModel.fromJson(Map<String, dynamic> jsonData) {
    return CityModel(
        intGlCode: jsonData["int_glcode"] ?? "",
        title: jsonData["title"] ?? "");
  }
}
