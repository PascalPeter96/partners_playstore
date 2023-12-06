// To parse this JSON data, do
//
//     final storeProductVariantsModel = storeProductVariantsModelFromJson(jsonString);

import 'dart:convert';

import 'package:wena_partners/vendor/models/general/wena_models.dart';

StoreProductVariantsModel storeProductVariantsModelFromJson(String str) => StoreProductVariantsModel.fromJson(json.decode(str));

String storeProductVariantsModelToJson(StoreProductVariantsModel data) => json.encode(data.toJson());

class StoreProductVariantsModel {
  String? status;
  List<StoreProductVariants>? data;

  StoreProductVariantsModel({
    this.status,
    this.data,
  });

  factory StoreProductVariantsModel.fromJson(Map<String, dynamic> json) => StoreProductVariantsModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<StoreProductVariants>.from(json["data"]!.map((x) => StoreProductVariants.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StoreProductVariants extends WenaStoreProductVariants{
  String? productVariantId;
  String? productId;
  String? size;
  String? manufacturer;
  String? model;
  String? countryOfOrigin;
  int? weight;
  dynamic gauge;
  Product? product;

  StoreProductVariants({
    this.productVariantId,
    this.productId,
    this.size,
    this.manufacturer,
    this.model,
    this.countryOfOrigin,
    this.weight,
    this.gauge,
    this.product,
  });

  factory StoreProductVariants.fromJson(Map<String, dynamic> json) => StoreProductVariants(
    productVariantId: json["product_variant_id"],
    productId: json["product_id"],
    size: json["size"],
    manufacturer: json["manufacturer"],
    model: json["model"],
    countryOfOrigin: json["country_of_origin"],
    weight: json["weight"],
    gauge: json["gauge"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product_variant_id": productVariantId,
    "product_id": productId,
    "size": size,
    "manufacturer": manufacturer,
    "model": model,
    "country_of_origin": countryOfOrigin,
    "weight": weight,
    "gauge": gauge,
    "product": product?.toJson(),
  };

  @override
  String getId() { return productVariantId!;
  }

  @override
  String getName() { return product!.name!;
  }
}

class Product {
  String? productId;
  CategoryId? categoryId;
  String? name;
  String? description;
  SubCategoryId? subCategoryId;
  UserId? userId;
  StoreKeepingUnit? storeKeepingUnit;

  Product({
    this.productId,
    this.categoryId,
    this.name,
    this.description,
    this.subCategoryId,
    this.userId,
    this.storeKeepingUnit,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    categoryId: categoryIdValues.map[json["category_id"]]!,
    name: json["name"],
    description: json["description"],
    subCategoryId: subCategoryIdValues.map[json["sub_category_id"]]!,
    userId: userIdValues.map[json["user_id"]]!,
    storeKeepingUnit: storeKeepingUnitValues.map[json["store_keeping_unit"]]!,
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category_id": categoryIdValues.reverse[categoryId],
    "name": name,
    "description": description,
    "sub_category_id": subCategoryIdValues.reverse[subCategoryId],
    "user_id": userIdValues.reverse[userId],
    "store_keeping_unit": storeKeepingUnitValues.reverse[storeKeepingUnit],
  };
}

enum CategoryId {
  THE_336_A
}

final categoryIdValues = EnumValues({
  "336a": CategoryId.THE_336_A
});

enum StoreKeepingUnit {
  BAGS
}

final storeKeepingUnitValues = EnumValues({
  "bags": StoreKeepingUnit.BAGS
});

enum SubCategoryId {
  THE_685_A
}

final subCategoryIdValues = EnumValues({
  "685a": SubCategoryId.THE_685_A
});

enum UserId {
  C81_F66_DF,
  CC4_F313_C,
  THE_847_D8408
}

final userIdValues = EnumValues({
  "c81f66df": UserId.C81_F66_DF,
  "cc4f313c": UserId.CC4_F313_C,
  "847d8408": UserId.THE_847_D8408
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
