// To parse this JSON data, do
//
//     final branchProductsModel = branchProductsModelFromJson(jsonString);

import 'dart:convert';

BranchProductsModel branchProductsModelFromJson(String str) => BranchProductsModel.fromJson(json.decode(str));

String branchProductsModelToJson(BranchProductsModel data) => json.encode(data.toJson());

class BranchProductsModel {
  String? status;
  List<StoreBranchProduct>? data;

  BranchProductsModel({
    this.status,
    this.data,
  });

  factory BranchProductsModel.fromJson(Map<String, dynamic> json) => BranchProductsModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<StoreBranchProduct>.from(json["data"]!.map((x) => StoreBranchProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StoreBranchProduct {
  String? storeProductId;
  String? storeId;
  String? storeBranchId;
  String? productId;
  String? price;
  String? metricUnit;
  DateTime? createdAt;
  DateTime? updatedAt;
  BranchProduct? product;

  StoreBranchProduct({
    this.storeProductId,
    this.storeId,
    this.storeBranchId,
    this.productId,
    this.price,
    this.metricUnit,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory StoreBranchProduct.fromJson(Map<String, dynamic> json) => StoreBranchProduct(
    storeProductId: json["store_product_id"],
    storeId: json["store_id"],
    storeBranchId: json["store_branch_id"],
    productId: json["product_id"],
    price: json["price"],
    metricUnit: json["metric_unit"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : BranchProduct.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "store_product_id": storeProductId,
    "store_id": storeId,
    "store_branch_id": storeBranchId,
    "product_id": productId,
    "price": price,
    "metric_unit": metricUnit,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class BranchProduct {
  String? productId;
  String? categoryId;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  BranchProduct({
    this.productId,
    this.categoryId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory BranchProduct.fromJson(Map<String, dynamic> json) => BranchProduct(
    productId: json["product_id"],
    categoryId: json["category_id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category_id": categoryId,
    "name": name,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
