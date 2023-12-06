// To parse this JSON data, do
//
//     final addBulkStoreProductModel = addBulkStoreProductModelFromJson(jsonString);

import 'dart:convert';

AddBulkStoreProductModel addBulkStoreProductModelFromJson(String str) => AddBulkStoreProductModel.fromJson(json.decode(str));

String addBulkStoreProductModelToJson(AddBulkStoreProductModel data) => json.encode(data.toJson());

class AddBulkStoreProductModel {
  String? storeBranchId;
  String? productVariantId;
  int? price;
  String? orderUnit;
  int? prepTime;
  String? prepTimeUnit;
  int? minimumOrderQuantity;

  AddBulkStoreProductModel({
    this.storeBranchId,
    this.productVariantId,
    this.price,
    this.orderUnit,
    this.prepTime,
    this.prepTimeUnit,
    this.minimumOrderQuantity,
  });

  factory AddBulkStoreProductModel.fromJson(Map<String, dynamic> json) => AddBulkStoreProductModel(
    storeBranchId: json["store_branch_id"],
    productVariantId: json["product_variant_id"],
    price: json["price"],
    orderUnit: json["order_unit"],
    prepTime: json["prep_time"],
    prepTimeUnit: json["prep_time_unit"],
    minimumOrderQuantity: json["minimum_order_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "store_branch_id": storeBranchId,
    "product_variant_id": productVariantId,
    "price": price,
    "order_unit": orderUnit,
    "prep_time": prepTime,
    "prep_time_unit": prepTimeUnit,
    "minimum_order_quantity": minimumOrderQuantity,
  };
}
