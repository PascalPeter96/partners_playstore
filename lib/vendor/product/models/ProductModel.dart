import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.status,
    this.message,
    this.data,
  });

  ProductModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductData.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  List<ProductData>? data;
  ProductModel copyWith({
    num? status,
    String? message,
    List<ProductData>? data,
  }) =>
      ProductModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ProductData dataFromJson(String str) => ProductData.fromJson(json.decode(str));
String dataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  ProductData({
    this.intGlcode,
    this.varTitle,
    this.oldPrice,
    this.newPrice,
    this.varOffer,
    this.txtDescription,
    this.varVideoLinks,
    this.productVariations,
    this.images,
  });

  ProductData.fromJson(dynamic json) {
    intGlcode = json['int_glcode'] ?? "";
    varTitle = json['var_title'] ?? "";
    oldPrice = json['old_price'] ?? "";
    newPrice = json['new_price'] ?? "";
    varOffer = json['var_offer'] ?? "";
    fk_category = json['fk_category'] ?? "";
    txtDescription = json['txt_description'] ?? "";
    varVideoLinks = json['var_video_links'] ?? "";
    if (json['product_variations'] != null) {
      productVariations = [];
      json['product_variations'].forEach((v) {
        productVariations?.add(ProductVariations.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
  }
  String? intGlcode;
  String? varTitle;
  String? oldPrice;
  String? newPrice;
  String? varOffer;
  String? txtDescription;
  String? fk_category;
  String? varVideoLinks;
  List<ProductVariations>? productVariations;
  List<Images>? images;
  ProductData copyWith({
    String? intGlcode,
    String? varTitle,
    String? oldPrice,
    String? newPrice,
    String? varOffer,
    String? txtDescription,
    String? varVideoLinks,
    List<ProductVariations>? productVariations,
    List<Images>? images,
  }) =>
      ProductData(
        intGlcode: intGlcode ?? this.intGlcode,
        varTitle: varTitle ?? this.varTitle,
        oldPrice: oldPrice ?? this.oldPrice,
        newPrice: newPrice ?? this.newPrice,
        varOffer: varOffer ?? this.varOffer,
        txtDescription: txtDescription ?? this.txtDescription,
        varVideoLinks: varVideoLinks ?? this.varVideoLinks,
        productVariations: productVariations ?? this.productVariations,
        images: images ?? this.images,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['int_glcode'] = intGlcode;
    map['var_title'] = varTitle;
    map['old_price'] = oldPrice;
    map['new_price'] = newPrice;
    map['var_offer'] = varOffer;
    map['txt_description'] = txtDescription;
    map['var_video_links'] = varVideoLinks;
    if (productVariations != null) {
      map['product_variations'] =
          productVariations?.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    this.varImageUrl,
  });

  Images.fromJson(dynamic json) {
    varImageUrl = json['var_image_url'];
  }
  String? varImageUrl;
  Images copyWith({
    String? varImageUrl,
  }) =>
      Images(
        varImageUrl: varImageUrl ?? this.varImageUrl,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['var_image_url'] = varImageUrl;
    return map;
  }
}

ProductVariations productVariationsFromJson(String str) =>
    ProductVariations.fromJson(json.decode(str));
String productVariationsToJson(ProductVariations data) =>
    json.encode(data.toJson());

class ProductVariations {
  ProductVariations({
    this.varSize,
    this.fkUnit,
    this.fkColor,
    this.varPrice,
  });

  ProductVariations.fromJson(dynamic json) {
    varSize = json['var_size'];
    fkUnit = json['fk_unit'];
    fkColor = json['fk_color'];
    varPrice = json['var_price'];
  }
  String? varSize;
  String? fkUnit;
  String? fkColor;
  String? varPrice;
  ProductVariations copyWith({
    String? varSize,
    String? fkUnit,
    String? fkColor,
    String? varPrice,
  }) =>
      ProductVariations(
        varSize: varSize ?? this.varSize,
        fkUnit: fkUnit ?? this.fkUnit,
        fkColor: fkColor ?? this.fkColor,
        varPrice: varPrice ?? this.varPrice,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['var_size'] = varSize;
    map['fk_unit'] = fkUnit;
    map['fk_color'] = fkColor;
    map['var_price'] = varPrice;
    return map;
  }
}
