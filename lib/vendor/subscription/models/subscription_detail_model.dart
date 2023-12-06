
class SubscriptionDetailsModel {
  String? intGlcode;
  String? fkUser;
  String? userType;
  String? startDate;
  String? endDate;
  String? fkSubscription;
  String? stripeSubscriptionId;
  String? stripeCustomerId;
  String? isDelete;
  String? dtCreateddate;
  String? varIpaddress;
  SubscriptionDetailsModel(
      {this.intGlcode,
      this.fkUser,
      this.userType,
      this.startDate,
      this.endDate,
      this.fkSubscription,
      this.stripeSubscriptionId,
      this.stripeCustomerId,
      this.isDelete,
      this.dtCreateddate,
      this.varIpaddress});

  factory SubscriptionDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return SubscriptionDetailsModel(
      intGlcode: jsonData["int_glcode"] ?? "",
      fkUser: jsonData["fk_user"] ?? "",
      userType: jsonData["user_type"] ?? "",
      startDate: jsonData["start_date"] ?? "",
      endDate: jsonData["end_date"] ?? "",
      fkSubscription: jsonData["fk_subscription"] ?? "",
      stripeSubscriptionId: jsonData["stripe_subscription_id"] ?? "",
      stripeCustomerId: jsonData["stripe_customer_id"] ?? "",
      isDelete: jsonData["is_delete"] ?? "",
      dtCreateddate: jsonData["dt_createddate"] ?? "",
      varIpaddress: jsonData["var_ipaddress"] ?? "",
    );
  }
}
