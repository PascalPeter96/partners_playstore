class OrderModel {
  String? fkOrder;
  String? orderId;
  String? fkUser;
  String? varPaymentMode;
  String? chrStatus;
  String? dtCreateddate;
  String? varFname;
  String? varLname;
  String? varEmail;
  String? varMobileNo;
  String? deliveryboyName;
  String? deliveryboyMumber;
  String? deliveryboyEmail;
  String? txtReason;
  bool isCheck = false;
  List<OrderProductModel>? fkProductArr;
  OrderModel(
      {this.fkOrder,
      this.orderId,
      this.fkUser,
      this.varPaymentMode,
      this.chrStatus,
      this.dtCreateddate,
      this.varFname,
      this.varLname,
      this.varEmail,
      this.varMobileNo,
      this.deliveryboyName,
      this.deliveryboyMumber,
      this.deliveryboyEmail,
      this.txtReason,
      this.fkProductArr});
  factory OrderModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderModel(
        fkOrder: jsonData["fk_order"] ?? "",
        orderId: jsonData["order_id"] ?? "",
        fkUser: jsonData["fk_user"] ?? "",
        varPaymentMode: jsonData["var_payment_mode"] ?? "",
        chrStatus: jsonData["chr_status"] ?? "",
        dtCreateddate: jsonData["dt_createddate"] ?? "",
        varFname: jsonData["var_fname"] ?? "",
        varLname: jsonData["var_lname"] ?? "",
        varEmail: jsonData["var_email"] ?? "",
        varMobileNo: jsonData["var_mobile_no"] ?? "",
        deliveryboyName: jsonData["deliveryboy_name"] ?? "",
        deliveryboyMumber: jsonData["deliveryboy_number"] ?? "",
        deliveryboyEmail: jsonData["deliveryboy_email"] ?? "",
        txtReason: jsonData["txt_reason"] ?? "",
        fkProductArr: jsonData["fk_product_arr"]
                .map<OrderProductModel>(
                    (json) => OrderProductModel.fromJson(json))
                .toList() ??
            []);
  }
}

class OrderProductModel {
  String? fkProduct;
  String? varName;
  String? varPrice;
  String? varUnit;
  OrderProductModel(
      {this.fkProduct, this.varName, this.varPrice, this.varUnit});
  factory OrderProductModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderProductModel(
        fkProduct: jsonData["fk_product"] ?? "",
        varName: jsonData["var_name"] ?? "",
        varPrice: jsonData["var_price"] ?? "",
        varUnit: jsonData["var_unit"] ?? "");
  }
}
