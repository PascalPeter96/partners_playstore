import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/delivery/screens/delivery_list_screen.dart';
import 'package:wena_partners/vendor/orders/models/order_details_model.dart';
import 'package:wena_partners/vendor/orders/models/order_model.dart';
import 'package:wena_partners/vendor/orders/repository/order_details_repository.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';
class OrderDetailsScreen extends StatefulWidget {
  OrderModel orderModel;
  OrderDetailsScreen(this.orderModel);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetailsScreen> {
  String _userId = "";
  String _userToken = "";
  final OrderDetailsRepository _orderDetailsRepository = OrderDetailsRepository();
  OrderDetailsModel _orderModel = OrderDetailsModel();
  getOrders(String status) async {
    _orderDetailsRepository.orderDetails(
        data: {"fk_order": widget.orderModel.fkOrder},
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_orderDetailsRepository.subResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_orderDetailsRepository.subResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _orderModel = OrderDetailsModel.fromJson(value["body"]["data"][0]);
      } else {}
    });
  }

  getUserDetails() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();

    getOrders("A");
  }

  @override
  void initState() {
    getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: dimen20,
            ),
            const Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: dimen10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset(
                "assets/images/placeholder.png",
                width: dimen60,
                height: dimen60,
              ),
              SizedBox(
                width: dimen20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${widget.orderModel.varFname!} ${widget.orderModel.varLname!}",
                    style: textSegoeUiColor161616Size18,
                  ),
                  SizedBox(
                    height: dimen05,
                  ),
                  Text(
                    widget.orderModel.varEmail!,
                    style: textSegoeUiColorContentSize16,
                  )
                ],
              )),
            ]),
            SizedBox(
              height: dimen10,
            ),
            const Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: dimen10,
            ),
            Padding(
              padding: EdgeInsets.only(left: dimen20, right: dimen20),
              child: Row(children: [
                Expanded(
                  child: Text(
                    "Orde ID",
                    style: textSegoeUiColor161616Size16,
                  ),
                ),
                Text(
                  widget.orderModel.orderId!,
                  style: textSegoeUiColor161616Size16,
                ),
              ]),
            ),
            SizedBox(
              height: dimen10,
            ),
            const Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: dimen10,
            ),
            Padding(
              padding: EdgeInsets.only(left: dimen20, right: dimen20),
              child: Row(children: [
                Expanded(
                  child: Text(
                    "Date",
                    style: textSegoeUiColor161616Size16,
                  ),
                ),
                Text(
                  widget.orderModel.dtCreateddate!.split(" ")[0],
                  style: textSegoeUiColor161616Size16,
                ),
              ]),
            ),
            SizedBox(
              height: dimen10,
            ),
            const Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: dimen10,
            ),
            Padding(
              padding: EdgeInsets.only(left: dimen20, right: dimen20),
              child: Row(children: [
                Expanded(
                  child: Text(
                    "Time",
                    style: textSegoeUiColor161616Size16,
                  ),
                ),
                Text(
                  widget.orderModel.dtCreateddate!.split(" ")[1],
                  style: textSegoeUiColor161616Size16,
                ),
              ]),
            ),
            SizedBox(
              height: dimen10,
            ),
            const Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: dimen10,
            ),
            Padding(
              padding: EdgeInsets.only(left: dimen20, right: dimen20),
              child: Row(children: [
                Expanded(
                  child: Text(
                    "Status",
                    style: textSegoeUiColor161616Size16,
                  ),
                ),
                Text(
                  getStatusText(widget.orderModel.chrStatus!),
                  style: getStatusTextStyle(widget.orderModel.chrStatus!)!,
                ),
              ]),
            ),
            SizedBox(
              height: dimen10,
            ),
            const Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: dimen10,
            ),
            if (_orderModel.fkProductArr != null &&
                _orderModel.fkProductArr!.isNotEmpty)
              Container(
                  padding: EdgeInsets.all(dimen10),
                  decoration: BoxDecoration(
                      color: const Color(colorF7F8F9),
                      borderRadius: BorderRadius.all(Radius.circular(dimen10)),
                      border: Border.all(width: 1, color: const Color(colorDADADA))),
                  child: ListView.builder(
                      itemCount: _orderModel.fkProductArr!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) => Container(
                            child: Column(children: [
                              if (index == 0)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: Text(
                                        "#",
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Text(
                                        "Name",
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: Text(
                                        "Unit",
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Text(
                                        "Price ($ugxSymbole)",
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                    )
                                  ],
                                ),
                              SizedBox(
                                height: dimen10,
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              SizedBox(
                                height: dimen10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 3, right: 3),
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Text(
                                      (index + 1).toString(),
                                      style: textSegoeUiColorContentSize16,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 3, right: 3),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Text(
                                      _orderModel.fkProductArr![index].varName!,
                                      style: textSegoeUiColorContentSize16,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Text(
                                      _orderModel.fkProductArr![index].varUnit!,
                                      style: textSegoeUiColorContentSize16,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 3, right: 3),
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Text(
                                      _orderModel
                                          .fkProductArr![index].varPrice!,
                                      style: textSegoeUiColorContentSize16,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: dimen10,
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              SizedBox(
                                height: dimen10,
                              ),
                            ]),
                          )))),
            SizedBox(
              height: dimen20,
            ),
            if (_orderModel.intGlcode != null)
              Container(
                padding: EdgeInsets.all(dimen10),
                decoration: BoxDecoration(
                    color: const Color(colorF7F8F9),
                    borderRadius: BorderRadius.all(Radius.circular(dimen10)),
                    border: Border.all(width: 1, color: const Color(colorDADADA))),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Payment Type",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        _orderModel.varPaymentMode!,
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Applied Promo code",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        _orderModel.varPromocode!,
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Cashback",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        ugxSymbole +
                            (_orderModel.varCashback! == ""
                                ? " 0"
                                : " ${_orderModel.varCashback!}"),
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Total amount",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        ugxSymbole +
                            (_orderModel.varTotalAmount! == ""
                                ? " 0"
                                : " ${_orderModel.varTotalAmount!}"),
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Discount",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        ugxSymbole +
                            (_orderModel.varDiscountAmount! == ""
                                ? " 0"
                                : " ${_orderModel.varDiscountAmount!}"),
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Delivery Charges",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        ugxSymbole +
                            (_orderModel.deliveryCharge! == ""
                                ? " 0"
                                : " ${_orderModel.deliveryCharge!}"),
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Wallet amount",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        ugxSymbole +
                            (_orderModel.varWalletAmount! == ""
                                ? " 0"
                                : " ${_orderModel.varWalletAmount!}"),
                        style: textSegoeUiColorContentSize16,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: dimen10,
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: dimen10,
                  ),
                  Row(children: [
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        "Payable Amount",
                        style: textSegoeUiColor161616Size20,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Text(
                        ugxSymbole +
                            (_orderModel.varPayableAmount! == ""
                                ? " 0"
                                : " ${_orderModel.varPayableAmount!}"),
                        style: textSegoeUiColor161616Size20,
                      ),
                    ),
                  ]),
                ]),
              ),
            SizedBox(
              height: dimen40,
            ),
            Container(
                alignment: FractionalOffset.center,
                child: Text(
                  "Request Send",
                  style: textSegoeUiColorSecondarySize16Bold,
                )),
            SizedBox(
              height: dimen20,
            ),
            Container(
                margin: EdgeInsets.only(top: dimen20),
                height: dimen50,
                child: const CustomButtonColorSecondaryWidget(
                    "Send Request Nearby", false)),
            SizedBox(
              height: dimen20,
            ),
            Container(
                alignment: FractionalOffset.center,
                child: Text(
                  "OR",
                  style: textSegoeUiColorContentSize16,
                )),
            SizedBox(
              height: dimen20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryAgentScreen(),
                    ),
                  );
                },
                child: SizedBox(
                    height: dimen50,
                    child: const CustomButtonColorSecondaryWidget(
                        "Assign Delivery Agent", false))),
            SizedBox(
              height: dimen60,
            ),
          ]),
        )),
        widget.orderModel.orderId!);
  }
}
