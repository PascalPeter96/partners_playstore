class TransactionModel {
  String intGlCode;
  String fkVendor;
  String fkOrder;
  String chrStatus;
  String amount;
  String createDate;
  String transactionType;
  String orderId;
  bool isCheck = false;
  TransactionModel(
      {this.intGlCode = "",
      this.fkVendor = "",
      this.chrStatus = "",
      this.amount = "",
      this.createDate = "",
      this.transactionType = "",
      this.orderId = "",
      this.fkOrder = ""});
  factory TransactionModel.fromJson(Map<String, dynamic> jsonData) {
    return TransactionModel(
      intGlCode: jsonData["int_glcode"] ?? "",
      fkVendor: jsonData["fk_vendor"] ?? "",
      amount: jsonData["var_amount"] ?? "",
      chrStatus: jsonData["chr_status"] ?? "",
      createDate: jsonData["dt_createddate"] ?? "",
      transactionType: jsonData["transactionType"] ?? "C",
      orderId: jsonData["order_id"] ?? "",
      fkOrder: jsonData["fk_order"] ?? "",
    );
  }
}
