// To parse this JSON data, do
//
//     final depositWalletModel = depositWalletModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VendorDepositWalletModel depositWalletModelFromJson(String str) => VendorDepositWalletModel.fromJson(json.decode(str));

String depositWalletModelToJson(VendorDepositWalletModel data) => json.encode(data.toJson());

class VendorDepositWalletModel {
  String walletId;
  String amount;

  VendorDepositWalletModel({
    required this.walletId,
    required this.amount,
  });

  factory VendorDepositWalletModel.fromJson(Map<String, dynamic> json) => VendorDepositWalletModel(
    walletId: json["wallet_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "amount": amount,
  };
}
