
class SubscriptionModel {
  String? intGlcode;
  String? varTitle;
  String? price;
  String? month;
  String? varDetails;
  SubscriptionModel(
      {this.intGlcode, this.varTitle, this.month, this.price, this.varDetails});
  factory SubscriptionModel.fromJson(Map<String, dynamic> jsonData) {
    return SubscriptionModel(
        intGlcode: jsonData["int_glcode"] ?? "",
        varTitle: jsonData["var_title"] ?? "",
        price: jsonData["var_price"] ?? "",
        month: jsonData["month"] ?? "",
        varDetails: jsonData["var_details"] ?? "");
  }
}
