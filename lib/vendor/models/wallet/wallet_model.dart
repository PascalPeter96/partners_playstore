// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

VendorWalletModel walletModelFromJson(String str) => VendorWalletModel.fromJson(json.decode(str));

String walletModelToJson(VendorWalletModel data) => json.encode(data.toJson());

class VendorWalletModel {
  String? status;
  VendorWallet? wallet;

  VendorWalletModel({
    this.status,
    this.wallet,
  });

  factory VendorWalletModel.fromJson(Map<String, dynamic> json) => VendorWalletModel(
    status: json["status"],
    wallet: json["wallet"] == null ? null : VendorWallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "wallet": wallet?.toJson(),
  };
}

class VendorWallet {
  String? walletId;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? balance;
  int? interest;

  VendorWallet({
    this.walletId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.interest,
  });

  factory VendorWallet.fromJson(Map<String, dynamic> json) => VendorWallet(
    walletId: json["wallet_id"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    balance: json["balance"],
    interest: json["interest"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "balance": balance,
    "interest": interest,
  };
}
