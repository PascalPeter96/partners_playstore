// To parse this JSON data, do
//
//     final addRetailProductModel = addRetailProductModelFromJson(jsonString);

import 'dart:convert';

AddRetailProductModel addRetailProductModelFromJson(String str) => AddRetailProductModel.fromJson(json.decode(str));

String addRetailProductModelToJson(AddRetailProductModel data) => json.encode(data.toJson());

class AddRetailProductModel {
  String? storeBranchId;
  String? productVariantId;
  String? price;
  String? orderUnit;
  String? prepTime;
  String? prepTimeUnit;

  AddRetailProductModel({
    this.storeBranchId,
    this.productVariantId,
    this.price,
    this.orderUnit,
    this.prepTime,
    this.prepTimeUnit,
  });

  factory AddRetailProductModel.fromJson(Map<String, dynamic> json) => AddRetailProductModel(
    storeBranchId: json["store_branch_id"],
    productVariantId: json["product_variant_id"],
    price: json["price"],
    orderUnit: json["order_unit"],
    prepTime: json["prep_time"],
    prepTimeUnit: json["prep_time_unit"],
  );

  Map<String, dynamic> toJson() => {
    "store_branch_id": storeBranchId,
    "product_variant_id": productVariantId,
    "price": price,
    "order_unit": orderUnit,
    "prep_time": prepTime,
    "prep_time_unit": prepTimeUnit,
  };
}
