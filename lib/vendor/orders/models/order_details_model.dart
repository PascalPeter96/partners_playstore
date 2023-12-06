

import 'package:wena_partners/vendor/orders/models/order_model.dart';

class OrderDetailsModel {
  String? intGlcode;
  String? orderId;
  String? fkUser;
  String? fkVendor;
  String? fkDelivery;
  String? varDeliveryMode;
  String? vendorDeliveryTime;
  String? varPaymentMode;
  String? chrStatus;
  String? reason;
  String? varUserAddress;
  String? dtTimeslot;
  String? vdTimeslot;
  String? chrDeliveryStatus;
  String? dtDeliveryDate;
  String? varMobileNo;
  String? varAddressType;
  String? varDeliveryCharge;
  String? varWalletAmount;
  String? varDiscountAmount;
  String? varTotalAmount;
  String? varPayableAmount;
  String? varCashback;
  String? varPromocode;
  String? varTransactionId;
  String? canceledBy;
  String? chrDelete;
  String? dtDreateddate;
  String? varIpaddress;
  String? deliveryCharge;
  String? userAddress;
  String? varBusinessName;
  String? varName;
  String? varSurname;
  String? varCountryCode;
  List<OrderProductModel>? fkProductArr;
  OrderDetailsModel(
      {this.intGlcode,
      this.orderId,
      this.fkUser,
      this.fkVendor,
      this.fkDelivery,
      this.varDeliveryMode,
      this.vendorDeliveryTime,
      this.varPaymentMode,
      this.chrStatus,
      this.reason,
      this.varUserAddress,
      this.dtTimeslot,
      this.vdTimeslot,
      this.chrDeliveryStatus,
      this.dtDeliveryDate,
      this.varMobileNo,
      this.varAddressType,
      this.varDeliveryCharge,
      this.varWalletAmount,
      this.varDiscountAmount,
      this.varTotalAmount,
      this.varPayableAmount,
      this.varCashback,
      this.varPromocode,
      this.varTransactionId,
      this.canceledBy,
      this.chrDelete,
      this.dtDreateddate,
      this.varIpaddress,
      this.deliveryCharge,
      this.userAddress,
      this.varBusinessName,
      this.varName,
      this.varSurname,
      this.varCountryCode,
      this.fkProductArr});
  factory OrderDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderDetailsModel(
        intGlcode: jsonData["int_glcode"] ?? "",
        orderId: jsonData["order_id"] ?? "",
        fkUser: jsonData["fk_user"] ?? "",
        fkVendor: jsonData["fk_vendor"] ?? "",
        fkDelivery: jsonData["fk_delivery"] ?? "",
        varDeliveryMode: jsonData["var_delivery_mode"] ?? "",
        vendorDeliveryTime: jsonData["vendor_delivery_time"] ?? "",
        varPaymentMode: jsonData["var_payment_mode"] ?? "",
        chrStatus: jsonData["chr_status"] ?? "",
        reason: jsonData["reason"] ?? "",
        varUserAddress: jsonData["var_user_address"] ?? "",
        dtTimeslot: jsonData["dt_timeslot"] ?? "",
        vdTimeslot: jsonData["vd_timeslot"] ?? "",
        chrDeliveryStatus: jsonData["chr_delivery_status"] ?? "",
        dtDeliveryDate: jsonData["dt_delivery_date"] ?? "",
        varMobileNo: jsonData["var_mobile_no"] ?? "",
        varAddressType: jsonData["var_address_type"] ?? "",
        varDeliveryCharge: jsonData["var_delivery_charge"] ?? "",
        varWalletAmount: jsonData["var_wallet_amount"] ?? "",
        varDiscountAmount: jsonData["var_discount_amount"] ?? "",
        varTotalAmount: jsonData["var_total_amount"] ?? "",
        varPayableAmount: jsonData["var_payable_amount"] ?? "",
        varCashback: jsonData["var_cashback"] ?? "",
        varPromocode: jsonData["var_promocode"] ?? "",
        varTransactionId: jsonData["var_transaction_id"] ?? "",
        canceledBy: jsonData["canceled_by"] ?? "",
        chrDelete: jsonData["chr_delete"] ?? "",
        dtDreateddate: jsonData["dt_createddate"] ?? "",
        varIpaddress: jsonData["var_ipaddress"] ?? "",
        deliveryCharge: jsonData["delivery_charge"] ?? "",
        userAddress: jsonData["user_address"] ?? "",
        varBusinessName: jsonData["var_business_name"] ?? "",
        varName: jsonData["var_name"] ?? "",
        varSurname: jsonData["var_surname"] ?? "",
        varCountryCode: jsonData["var_country_code"] ?? "",
        fkProductArr: jsonData["fk_product_arr"]
                .map<OrderProductModel>(
                    (json) => OrderProductModel.fromJson(json))
                .toList() ??
            []);
  }
}
