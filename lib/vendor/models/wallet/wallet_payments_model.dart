// To parse this JSON data, do
//
//     final walletPaymentModel = walletPaymentModelFromJson(jsonString);

import 'dart:convert';

VendorWalletPaymentModel walletPaymentModelFromJson(String str) => VendorWalletPaymentModel.fromJson(json.decode(str));

String walletPaymentModelToJson(VendorWalletPaymentModel data) => json.encode(data.toJson());

class VendorWalletPaymentModel {
  String? status;
  List<VendorWalletPayment>? payments;

  VendorWalletPaymentModel({
    this.status,
    this.payments,
  });

  factory VendorWalletPaymentModel.fromJson(Map<String, dynamic> json) => VendorWalletPaymentModel(
    status: json["status"],
    payments: json["payments"] == null ? [] : List<VendorWalletPayment>.from(json["payments"]!.map((x) => VendorWalletPayment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
  };
}

class VendorWalletPayment {
  String? walletPaymentId;
  String? walletId;
  int? amount;
  String? currency;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? reason;

  VendorWalletPayment({
    this.walletPaymentId,
    this.walletId,
    this.amount,
    this.currency,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.reason,
  });

  factory VendorWalletPayment.fromJson(Map<String, dynamic> json) => VendorWalletPayment(
    walletPaymentId: json["wallet_payment_id"],
    walletId: json["wallet_id"],
    amount: json["amount"],
    currency: json["currency"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "wallet_payment_id": walletPaymentId,
    "wallet_id": walletId,
    "amount": amount,
    "currency": currency,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "reason": reason,
  };
}
