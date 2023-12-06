// To parse this JSON data, do
//
//     final createWallet = createWalletFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VendorCreateWallet createWalletFromJson(String str) => VendorCreateWallet.fromJson(json.decode(str));

String createWalletToJson(VendorCreateWallet data) => json.encode(data.toJson());

class VendorCreateWallet {
  String userId;

  VendorCreateWallet({
    required this.userId,
  });

  factory VendorCreateWallet.fromJson(Map<String, dynamic> json) => VendorCreateWallet(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
