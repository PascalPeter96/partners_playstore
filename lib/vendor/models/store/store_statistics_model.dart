// To parse this JSON data, do
//
//     final storeStatisticsModel = storeStatisticsModelFromJson(jsonString);

import 'dart:convert';

StoreStatisticsModel storeStatisticsModelFromJson(String str) => StoreStatisticsModel.fromJson(json.decode(str));

String storeStatisticsModelToJson(StoreStatisticsModel data) => json.encode(data.toJson());

class StoreStatisticsModel {
  String? status;
  StoreStatistics? data;

  StoreStatisticsModel({
    this.status,
    this.data,
  });

  factory StoreStatisticsModel.fromJson(Map<String, dynamic> json) => StoreStatisticsModel(
    status: json["status"],
    data: json["data"] == null ? null : StoreStatistics.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class StoreStatistics {
  int? totalOrders;
  int? dailyOrders;
  int? totalProducts;
  int? revenue;

  StoreStatistics({
    this.totalOrders,
    this.dailyOrders,
    this.totalProducts,
    this.revenue,
  });

  factory StoreStatistics.fromJson(Map<String, dynamic> json) => StoreStatistics(
    totalOrders: json["total_orders"],
    dailyOrders: json["daily_orders"],
    totalProducts: json["total_products"],
    revenue: json["revenue"],
  );

  Map<String, dynamic> toJson() => {
    "total_orders": totalOrders,
    "daily_orders": dailyOrders,
    "total_products": totalProducts,
    "revenue": revenue,
  };
}
