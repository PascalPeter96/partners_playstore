import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/config/app_colors.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/config/text_style.dart';
import 'package:wena_partners/vendor/orders/models/order_model.dart';
import 'package:wena_partners/vendor/orders/repository/order_repository.dart';
import 'package:wena_partners/vendor/orders/screens/order_details_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class OrderHistoryScreen extends StatefulWidget {
  final backListner;
  const OrderHistoryScreen({Key? key, this.backListner})
      : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistoryScreen> {
  List<Map<String, dynamic>> tabList = [
    {
      "text": "ALL",
    },
    {
      "text": "COMPLETED",
    },
    {
      "text": "PENDING",
    },
    {
      "text": "CANCEL",
    },
  ];

  int selectIndex = 0;
  String _userId = "";
  String _userToken = "";
  final OrderListRepository _orderListRepository = OrderListRepository();
  List<OrderModel> _orderModel = [];
  getOrders(String status) async {
    _orderModel.clear();
    _orderListRepository.orderList(
        data: {"var_vendor_id": _userId, "var_flag": status},
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_orderListRepository.subResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_orderListRepository.subResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _orderModel = value["body"]["data"]
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
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
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
      Expanded(
        child: Column(children: [
          Container(
            height: dimen35,
            margin: EdgeInsets.only(top: dimen24, bottom: dimen16),
            child: ListView.builder(
              itemCount: tabList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: dimen16),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    selectIndex = index;
                    if (index == 0) {
                      getOrders("A");
                    } else if (index == 1) {
                      getOrders("S");
                    } else if (index == 2) {
                      getOrders("A");
                    } else if (index == 3) {
                      getOrders("P");
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: dimen16),
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectIndex == index
                          ? AppColors.lightPrimaryColor
                          : AppColors.transparentColor,
                      borderRadius: BorderRadius.circular(dimen30),
                      border: Border.all(
                        color: selectIndex == index
                            ? AppColors.primaryColor
                            : AppColors.greyColor,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      "${tabList[index]["text"]}",
                      style: AppTextStyle.regular600.copyWith(
                        fontSize: dimen16,
                        color: selectIndex == index
                            ? AppColors.primaryColor
                            : AppColors.greyColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: _orderModel.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: dimen30),
                      child: Text(
                        "Orders not found.",
                        style: textSegoeUiColorContentSize16,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _orderModel.length,
                      padding: EdgeInsets.only(left: dimen16, right: dimen16),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OrderDetailsScreen(_orderModel[index]),
                              ),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(dimen15),
                              margin: EdgeInsets.only(bottom: dimen20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(dimen15)),
                                  border: Border.all(
                                      width: 1, color: const Color(colorE8EFF3))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _orderModel[index].orderId!,
                                        style: textSegoeUiColorBlackSize20,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        _orderModel[index].dtCreateddate!,
                                        style: textSegoeUiColorContentSize16,
                                      )
                                    ],
                                  )),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: dimen10,
                                        right: dimen10,
                                        top: dimen05,
                                        bottom: dimen10),
                                    decoration: BoxDecoration(
                                      color: Color(getStatusColor(
                                              _orderModel[index].chrStatus!))
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(dimen30)),
                                    ),
                                    child: Text(
                                      getStatusText(
                                          _orderModel[index].chrStatus!),
                                      style: getStatusTextStyle(
                                          _orderModel[index].chrStatus!),
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
            ),
          )
        ]),
      ),
      "Order",
    );
  }
}
