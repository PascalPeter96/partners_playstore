// // To parse this JSON data, do
// //
// //     final storeProductsModel = storeProductsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// StoreProductsModel storeProductsModelFromJson(String str) => StoreProductsModel.fromJson(json.decode(str));
//
// String storeProductsModelToJson(StoreProductsModel data) => json.encode(data.toJson());
//
// class StoreProductsModel {
//   StoreProductsModel({
//     this.status,
//     this.storeProducts,
//   });
//
//   String? status;
//   List<StoreProduct>? storeProducts;
//
//   factory StoreProductsModel.fromJson(Map<String, dynamic> json) => StoreProductsModel(
//     status: json["status"],
//     storeProducts: json["store_products"] == null ? [] : List<StoreProduct>.from(json["store_products"]!.map((x) => StoreProduct.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "store_products": storeProducts == null ? [] : List<dynamic>.from(storeProducts!.map((x) => x.toJson())),
//   };
// }
//
// class StoreProduct {
//   StoreProduct({
//     this.storeProductId,
//     this.storeBranchId,
//     this.productVariantId,
//     this.price,
//     this.orderUnit,
//     this.productVariant,
//     this.storeBranch,
//   });
//
//   String? storeProductId;
//   String? storeBranchId;
//   String? productVariantId;
//   String? price;
//   String? orderUnit;
//   ProductVariant? productVariant;
//   StoreBranch? storeBranch;
//
//   factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
//     storeProductId: json["store_product_id"],
//     storeBranchId: json["store_branch_id"],
//     productVariantId: json["product_variant_id"],
//     price: json["price"],
//     orderUnit: json["order_unit"],
//     productVariant: json["product_variant"] == null ? null : ProductVariant.fromJson(json["product_variant"]),
//     storeBranch: json["store_branch"] == null ? null : StoreBranch.fromJson(json["store_branch"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "store_product_id": storeProductId,
//     "store_branch_id": storeBranchId,
//     "product_variant_id": productVariantId,
//     "price": price,
//     "order_unit": orderUnit,
//     "product_variant": productVariant?.toJson(),
//     "store_branch": storeBranch?.toJson(),
//   };
// }
//
// class ProductVariant {
//   ProductVariant({
//     this.productVariantId,
//     this.productId,
//     this.size,
//     this.manufacturer,
//     this.model,
//     this.countryOfOrigin,
//     this.weight,
//     this.product,
//     this.images,
//     this.videos,
//   });
//
//   String? productVariantId;
//   String? productId;
//   String? size;
//   String? manufacturer;
//   String? model;
//   String? countryOfOrigin;
//   int? weight;
//   Product? product;
//   List<StoreProductImage>? images;
//   List<Video>? videos;
//
//   factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
//     productVariantId: json["product_variant_id"],
//     productId: json["product_id"],
//     size: json["size"],
//     manufacturer: json["manufacturer"],
//     model: json["model"],
//     countryOfOrigin: json["country_of_origin"],
//     weight: json["weight"],
//     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//     images: json["images"] == null ? [] : List<StoreProductImage>.from(json["images"]!.map((x) => StoreProductImage.fromJson(x))),
//     videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product_variant_id": productVariantId,
//     "product_id": productId,
//     "size": size,
//     "manufacturer": manufacturer,
//     "model": model,
//     "country_of_origin": countryOfOrigin,
//     "weight": weight,
//     "product": product?.toJson(),
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
//   };
// }
//
// class StoreProductImage {
//   StoreProductImage({
//     this.productVariantImageId,
//     this.productVariantId,
//     this.productVariantImg,
//     this.color,
//     this.productVariantImgUrl,
//   });
//
//   String? productVariantImageId;
//   String? productVariantId;
//   String? productVariantImg;
//   String? color;
//   String? productVariantImgUrl;
//
//   factory StoreProductImage.fromJson(Map<String, dynamic> json) => StoreProductImage(
//     productVariantImageId: json["product_variant_image_id"],
//     productVariantId: json["product_variant_id"],
//     productVariantImg: json["product_variant_img"],
//     color: json["color"],
//     productVariantImgUrl: json["product_variant_img_url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product_variant_image_id": productVariantImageId,
//     "product_variant_id": productVariantId,
//     "product_variant_img": productVariantImg,
//     "color": color,
//     "product_variant_img_url": productVariantImgUrl,
//   };
// }
//
// class Product {
//   Product({
//     this.productId,
//     this.name,
//     this.description,
//     this.storeKeepingUnit,
//     this.categoryId,
//     this.subCategoryId,
//     this.category,
//     this.subCategory,
//   });
//
//   String? productId;
//   String? name;
//   String? description;
//   String? storeKeepingUnit;
//   String? categoryId;
//   String? subCategoryId;
//   Category? category;
//   SubCategory? subCategory;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     productId: json["product_id"],
//     name: json["name"],
//     description: json["description"],
//     storeKeepingUnit: json["store_keeping_unit"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     category: json["category"] == null ? null : Category.fromJson(json["category"]),
//     subCategory: json["sub_category"] == null ? null : SubCategory.fromJson(json["sub_category"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product_id": productId,
//     "name": name,
//     "description": description,
//     "store_keeping_unit": storeKeepingUnit,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "category": category?.toJson(),
//     "sub_category": subCategory?.toJson(),
//   };
// }
//
// class Category {
//   Category({
//     this.categoryId,
//     this.name,
//     this.categoryImgUrl,
//   });
//
//   String? categoryId;
//   String? name;
//   String? categoryImgUrl;
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     categoryId: json["category_id"],
//     name: json["name"],
//     categoryImgUrl: json["category_img_url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category_id": categoryId,
//     "name": name,
//     "category_img_url": categoryImgUrl,
//   };
// }
//
// class SubCategory {
//   SubCategory({
//     this.subCategoryId,
//     this.name,
//     this.subCategoryImgUrl,
//   });
//
//   String? subCategoryId;
//   String? name;
//   String? subCategoryImgUrl;
//
//   factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//     subCategoryId: json["sub_category_id"],
//     name: json["name"],
//     subCategoryImgUrl: json["sub_category_img_url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sub_category_id": subCategoryId,
//     "name": name,
//     "sub_category_img_url": subCategoryImgUrl,
//   };
// }
//
// class Video {
//   Video({
//     this.productVariantVideoId,
//     this.productVariantId,
//     this.productVariantVideo,
//     this.productVariantVideoUrl,
//   });
//
//   String? productVariantVideoId;
//   String? productVariantId;
//   String? productVariantVideo;
//   String? productVariantVideoUrl;
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     productVariantVideoId: json["product_variant_video_id"],
//     productVariantId: json["product_variant_id"],
//     productVariantVideo: json["product_variant_video"],
//     productVariantVideoUrl: json["product_variant_video_url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product_variant_video_id": productVariantVideoId,
//     "product_variant_id": productVariantId,
//     "product_variant_video": productVariantVideo,
//     "product_variant_video_url": productVariantVideoUrl,
//   };
// }
//
// class StoreBranch {
//   StoreBranch({
//     this.storeBranchId,
//     this.longitude,
//     this.latitude,
//     this.address,
//     this.shareablePin,
//     this.storeId,
//     this.store,
//   });
//
//   String? storeBranchId;
//   String? longitude;
//   String? latitude;
//   String? address;
//   String? shareablePin;
//   String? storeId;
//   Store? store;
//
//   factory StoreBranch.fromJson(Map<String, dynamic> json) => StoreBranch(
//     storeBranchId: json["store_branch_id"],
//     longitude: json["longitude"],
//     latitude: json["latitude"],
//     address: json["address"],
//     shareablePin: json["shareable_pin"],
//     storeId: json["store_id"],
//     store: json["store"] == null ? null : Store.fromJson(json["store"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "store_branch_id": storeBranchId,
//     "longitude": longitude,
//     "latitude": latitude,
//     "address": address,
//     "shareable_pin": shareablePin,
//     "store_id": storeId,
//     "store": store?.toJson(),
//   };
// }
//
// class Store {
//   Store({
//     this.storeId,
//     this.businessName,
//     this.storeImgUrl,
//   });
//
//   String? storeId;
//   String? businessName;
//   String? storeImgUrl;
//
//   factory Store.fromJson(Map<String, dynamic> json) => Store(
//     storeId: json["store_id"],
//     businessName: json["business_name"],
//     storeImgUrl: json["store_img_url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "store_id": storeId,
//     "business_name": businessName,
//     "store_img_url": storeImgUrl,
//   };
// }
