class AnalyticModel {
  String? totalOrders;
  String? todayTotalOrders;
  String? totalProduct;
  String? totalRevenue;
  AnalyticModel(
      {this.totalOrders,
      this.todayTotalOrders,
      this.totalProduct,
      this.totalRevenue});
  factory AnalyticModel.fromJson(Map<String, dynamic> jsonDat) {
    return AnalyticModel(
        totalOrders: jsonDat["total_orders"].toString(),
        todayTotalOrders: jsonDat["today_total_orders"].toString(),
        totalProduct: jsonDat["total_product"].toString(),
        totalRevenue: jsonDat["total_revenue"].toString());
  }
}
