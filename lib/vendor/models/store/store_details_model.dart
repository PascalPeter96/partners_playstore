// To parse this JSON data, do
//
//     final storeDetailsModel = storeDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:wena_partners/vendor/models/general/wena_models.dart';



// To parse this JSON data, do
//
//     final storeDetailsModel = storeDetailsModelFromJson(jsonString);

import 'dart:convert';

StoreDetailsModel storeDetailsModelFromJson(String str) => StoreDetailsModel.fromJson(json.decode(str));

String storeDetailsModelToJson(StoreDetailsModel data) => json.encode(data.toJson());

class StoreDetailsModel {
  String? status;
  StoreDetails? data;

  StoreDetailsModel({
    this.status,
    this.data,
  });

  factory StoreDetailsModel.fromJson(Map<String, dynamic> json) => StoreDetailsModel(
    status: json["status"],
    data: json["data"] == null ? null : StoreDetails.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class StoreDetails {
  String? storeId;
  String? userId;
  String? businessName;
  String? tradingLicense;
  String? businessTel;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? storeImg;
  String? nationalIdFront;
  String? nationalIdBack;
  String? firstname;
  String? surname;
  String? storeImgUrl;
  List<StoreBranch>? branches;
  List<StoreAccountDetail>? storeAccountDetails;

  StoreDetails({
    this.storeId,
    this.userId,
    this.businessName,
    this.tradingLicense,
    this.businessTel,
    this.createdAt,
    this.updatedAt,
    this.storeImg,
    this.nationalIdFront,
    this.nationalIdBack,
    this.firstname,
    this.surname,
    this.storeImgUrl,
    this.branches,
    this.storeAccountDetails,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
    storeId: json["store_id"],
    userId: json["user_id"],
    businessName: json["business_name"],
    tradingLicense: json["trading_license"],
    businessTel: json["business_tel"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    storeImg: json["store_img"],
    nationalIdFront: json["national_id_front"],
    nationalIdBack: json["national_id_back"],
    firstname: json["firstname"],
    surname: json["surname"],
    storeImgUrl: json["store_img_url"],
    branches: json["branches"] == null ? [] : List<StoreBranch>.from(json["branches"]!.map((x) => StoreBranch.fromJson(x))),
    storeAccountDetails: json["store_account_details"] == null ? [] : List<StoreAccountDetail>.from(json["store_account_details"]!.map((x) => StoreAccountDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "store_id": storeId,
    "user_id": userId,
    "business_name": businessName,
    "trading_license": tradingLicense,
    "business_tel": businessTel,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "store_img": storeImg,
    "national_id_front": nationalIdFront,
    "national_id_back": nationalIdBack,
    "firstname": firstname,
    "surname": surname,
    "store_img_url": storeImgUrl,
    "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
    "store_account_details": storeAccountDetails == null ? [] : List<dynamic>.from(storeAccountDetails!.map((x) => x.toJson())),
  };
}

class StoreBranch extends WenaModel{
  String? storeBranchId;
  String? storeId;
  String? storeBranchTel;
  int? isMainBranch;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? longitude;
  String? latitude;
  dynamic deletedAt;
  dynamic shareablePin;
  String? address;

  StoreBranch({
    this.storeBranchId,
    this.storeId,
    this.storeBranchTel,
    this.isMainBranch,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.longitude,
    this.latitude,
    this.deletedAt,
    this.shareablePin,
    this.address,
  });

  factory StoreBranch.fromJson(Map<String, dynamic> json) => StoreBranch(
    storeBranchId: json["store_branch_id"],
    storeId: json["store_id"],
    storeBranchTel: json["store_branch_tel"],
    isMainBranch: json["is_main_branch"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    deletedAt: json["deleted_at"],
    shareablePin: json["shareable_pin"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "store_branch_id": storeBranchId,
    "store_id": storeId,
    "store_branch_tel": storeBranchTel,
    "is_main_branch": isMainBranch,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user_id": userId,
    "longitude": longitude,
    "latitude": latitude,
    "deleted_at": deletedAt,
    "shareable_pin": shareablePin,
    "address": address,
  };

  @override
  String getId() { return storeBranchId!;
  }

  @override
  String getName() { return address!;
  }
}

class StoreAccountDetail {
  String? storeAccountId;
  String? storeId;
  String? accountNames;
  String? accountNumber;
  String? accountType;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bankName;
  dynamic bankCode;

  StoreAccountDetail({
    this.storeAccountId,
    this.storeId,
    this.accountNames,
    this.accountNumber,
    this.accountType,
    this.createdAt,
    this.updatedAt,
    this.bankName,
    this.bankCode,
  });

  factory StoreAccountDetail.fromJson(Map<String, dynamic> json) => StoreAccountDetail(
    storeAccountId: json["store_account_id"],
    storeId: json["store_id"],
    accountNames: json["account_names"],
    accountNumber: json["account_number"],
    accountType: json["account_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    bankName: json["bank_name"],
    bankCode: json["bank_code"],
  );

  Map<String, dynamic> toJson() => {
    "store_account_id": storeAccountId,
    "store_id": storeId,
    "account_names": accountNames,
    "account_number": accountNumber,
    "account_type": accountType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "bank_name": bankName,
    "bank_code": bankCode,
  };
}



//
// StoreDetailsModel storeDetailsModelFromJson(String str) => StoreDetailsModel.fromJson(json.decode(str));
//
// String storeDetailsModelToJson(StoreDetailsModel data) => json.encode(data.toJson());
//
// class StoreDetailsModel {
//   String? status;
//   StoreDetails? data;
//
//   StoreDetailsModel({
//     this.status,
//     this.data,
//   });
//
//   factory StoreDetailsModel.fromJson(Map<String, dynamic> json) => StoreDetailsModel(
//     status: json["status"],
//     data: json["data"] == null ? null : StoreDetails.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": data?.toJson(),
//   };
// }
//
// class StoreDetails {
//   String? storeId;
//   String? userId;
//   String? businessName;
//   String? tradingLicense;
//   String? businessTel;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? storeImg;
//   dynamic nationalIdFront;
//   dynamic nationalIdBack;
//   dynamic firstname;
//   dynamic surname;
//   String? storeImgUrl;
//   List<StoreBranch>? branches;
//   List<StoreAccountDetail>? storeAccountDetails;
//
//   StoreDetails({
//     this.storeId,
//     this.userId,
//     this.businessName,
//     this.tradingLicense,
//     this.businessTel,
//     this.createdAt,
//     this.updatedAt,
//     this.storeImg,
//     this.nationalIdFront,
//     this.nationalIdBack,
//     this.firstname,
//     this.surname,
//     this.storeImgUrl,
//     this.branches,
//     this.storeAccountDetails,
//   });
//
//   factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
//     storeId: json["store_id"],
//     userId: json["user_id"],
//     businessName: json["business_name"],
//     tradingLicense: json["trading_license"],
//     businessTel: json["business_tel"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     storeImg: json["store_img"],
//     nationalIdFront: json["national_id_front"],
//     nationalIdBack: json["national_id_back"],
//     firstname: json["firstname"],
//     surname: json["surname"],
//     storeImgUrl: json["store_img_url"],
//     branches: json["branches"] == null ? [] : List<StoreBranch>.from(json["branches"]!.map((x) => StoreBranch.fromJson(x))),
//     storeAccountDetails: json["store_account_details"] == null ? [] : List<StoreAccountDetail>.from(json["store_account_details"]!.map((x) => StoreAccountDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "store_id": storeId,
//     "user_id": userId,
//     "business_name": businessName,
//     "trading_license": tradingLicense,
//     "business_tel": businessTel,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "store_img": storeImg,
//     "national_id_front": nationalIdFront,
//     "national_id_back": nationalIdBack,
//     "firstname": firstname,
//     "surname": surname,
//     "store_img_url": storeImgUrl,
//     "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
//     "store_account_details": storeAccountDetails == null ? [] : List<dynamic>.from(storeAccountDetails!.map((x) => x.toJson())),
//   };
// }
//
// class StoreBranch extends WenaModel {
//   String? storeBranchId;
//   String? storeId;
//   String? storeBranchTel;
//   int? isMainBranch;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? userId;
//   String? longitude;
//   String? latitude;
//   dynamic deletedAt;
//   dynamic shareablePin;
//   String? address;
//
//   StoreBranch({
//     this.storeBranchId,
//     this.storeId,
//     this.storeBranchTel,
//     this.isMainBranch,
//     this.createdAt,
//     this.updatedAt,
//     this.userId,
//     this.longitude,
//     this.latitude,
//     this.deletedAt,
//     this.shareablePin,
//     this.address,
//   });
//
//   factory StoreBranch.fromJson(Map<String, dynamic> json) => StoreBranch(
//     storeBranchId: json["store_branch_id"],
//     storeId: json["store_id"],
//     storeBranchTel: json["store_branch_tel"],
//     isMainBranch: json["is_main_branch"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     userId: json["user_id"],
//     longitude: json["longitude"],
//     latitude: json["latitude"],
//     deletedAt: json["deleted_at"],
//     shareablePin: json["shareable_pin"],
//     address: json["address"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "store_branch_id": storeBranchId,
//     "store_id": storeId,
//     "store_branch_tel": storeBranchTel,
//     "is_main_branch": isMainBranch,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "user_id": userId,
//     "longitude": longitude,
//     "latitude": latitude,
//     "deleted_at": deletedAt,
//     "shareable_pin": shareablePin,
//     "address": address,
//   };
//
//   @override
//   String getId() { return storeBranchId.toString();
//   }
//
//   @override
//   String getName() { return address.toString();
//   }
// }
//
// class StoreAccountDetail {
//   String? storeAccountId;
//   String? storeId;
//   String? accountNames;
//   String? accountNumber;
//   String? accountType;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? bankName;
//   dynamic bankCode;
//
//   StoreAccountDetail({
//     this.storeAccountId,
//     this.storeId,
//     this.accountNames,
//     this.accountNumber,
//     this.accountType,
//     this.createdAt,
//     this.updatedAt,
//     this.bankName,
//     this.bankCode,
//   });
//
//   factory StoreAccountDetail.fromJson(Map<String, dynamic> json) => StoreAccountDetail(
//     storeAccountId: json["store_account_id"],
//     storeId: json["store_id"],
//     accountNames: json["account_names"],
//     accountNumber: json["account_number"],
//     accountType: json["account_type"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     bankName: json["bank_name"],
//     bankCode: json["bank_code"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "store_account_id": storeAccountId,
//     "store_id": storeId,
//     "account_names": accountNames,
//     "account_number": accountNumber,
//     "account_type": accountType,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "bank_name": bankName,
//     "bank_code": bankCode,
//   };
// }
