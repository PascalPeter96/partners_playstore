import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/contollers/store/store_statistics_controller.dart';
import 'package:wena_partners/vendor/dashboard/models/analytics_model.dart';
import 'package:wena_partners/vendor/dashboard/repository/dashboard_analytic_repository.dart';
import 'package:wena_partners/vendor/orders/models/order_model.dart';
import 'package:wena_partners/vendor/orders/repository/order_repository.dart';
import 'package:wena_partners/vendor/orders/screens/order_details_screen.dart';
import 'package:wena_partners/vendor/orders/screens/order_history_screnn.dart';
import 'package:wena_partners/vendor/product/models/ProductModel.dart';
import 'package:wena_partners/vendor/product/repository/dashboardproduct_repository.dart';
import 'package:wena_partners/vendor/product/screen/add_product_screen.dart';
import 'package:wena_partners/vendor/product/screen/edit_product_screen.dart';
import 'package:wena_partners/vendor/screens/products/add_retail_product_tab.dart';
import 'package:wena_partners/vendor/screens/products/add_vendor_products_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTabScreen> {

  final userStorage = GetStorage();

  final DashboardAnalyticRepository _analyticRepository =
  DashboardAnalyticRepository();
  String _userId = "";
  String _userToken = "";
  AnalyticModel _analyticModel = AnalyticModel();

  getAnalytics() async {
    _analyticRepository.getAnalytics(
        data: {
          "vendor_id": _userId,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _analyticModel = AnalyticModel.fromJson(value["body"]["data"]);
      } else {}
    });
  }

  final DashboardProductRepository _productRepository = DashboardProductRepository();
  ProductModel _productModel = ProductModel();

  getProducts() async {
    _productRepository.getProducts(
        data: {
          "var_vendor_id": _userId,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_productRepository.productResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_productRepository.productResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _productModel = ProductModel.fromJson(value['body']);
      } else {}
    });
  }

  final OrderListRepository _orderListRepository = OrderListRepository();
  List<OrderModel> _orderModel = [];

  getOrders() async {
    _orderListRepository.orderList(
        data: {"var_vendor_id": _userId, "var_flag": "A"},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _orderModel = value["body"]["data"]
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {}
    });
  }

  final OrderListRepository _orderPendingListRepository = OrderListRepository();
  List<OrderModel> _orderPendingModel = [];

  getPendingOrders() async {
    _orderPendingListRepository.orderList(
        data: {"var_vendor_id": _userId, "var_flag": "P"},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _orderPendingModel = value["body"]["data"]
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {}
    });
  }

  getUserDetails() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();
    getAnalytics();
    getProducts();
    getPendingOrders();
    getOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StoreStatisticsController storeStatisticsController = Get.put(
        StoreStatisticsController(storeId: userStorage.read('storeId')));



    // final StoreStatisticsController storeStatisticsController = Get.put(
    //     StoreStatisticsController(storeId: '7de7af'));


    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: dimen20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin:
                EdgeInsets.only(left: dimen20, right: dimen20, bottom: dimen20),
                child: Text(
                  "Dashboard",
                  style: textSegoeUiColorBlackSize30,
                )),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: dimen20,
                          right: dimen20,
                        ),
                        padding: EdgeInsets.only(top: dimen10),
                        child: Row(children: [
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(dimen15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(dimen20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 15.0,
                                        ),
                                      ],
                                      border:
                                      Border.all(width: 1,
                                          color: const Color(colorE8EFF3))),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/today_order.png",
                                          width: dimen35,
                                          height: dimen35,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: dimen10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                    storeStatisticsController
                                                        .isLoading.value
                                                        ?
                                                    "0"
                                                        : storeStatisticsController
                                                        .storeStat.value
                                                        .dailyOrders.toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: textSegoeUiColorBlackSize18,
                                                  );
                                                  //   Text(
                                                  //   _analyticModel
                                                  //       .todayTotalOrders !=
                                                  //       null
                                                  //       ? _analyticModel
                                                  //       .todayTotalOrders!
                                                  //       : "0",
                                                  //   maxLines: 1,
                                                  //   overflow: TextOverflow
                                                  //       .ellipsis,
                                                  //   style: textSegoeUiColorBlackSize18,
                                                  // );
                                                }),
                                                Text(
                                                  "Orders Today",
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: textSegoeUiColorContentSize14,
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ))),
                          SizedBox(
                            width: dimen10,
                          ),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(dimen15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(dimen20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 15.0,
                                        ),
                                      ],
                                      border:
                                      Border.all(width: 1,
                                          color: const Color(colorE8EFF3))),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/total_order.png",
                                          width: dimen35,
                                          height: dimen35,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: dimen10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                    storeStatisticsController
                                                        .isLoading.value
                                                        ?
                                                    "0"
                                                        : storeStatisticsController
                                                        .storeStat.value
                                                        .totalOrders.toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: textSegoeUiColorBlackSize18,
                                                  );

                                                  // return Text(
                                                  //   _analyticModel
                                                  //       .totalOrders !=
                                                  //       null
                                                  //       ? _analyticModel
                                                  //       .totalOrders!
                                                  //       : "0",
                                                  //   maxLines: 1,
                                                  //   overflow: TextOverflow
                                                  //       .ellipsis,
                                                  //   style: textSegoeUiColorBlackSize18,
                                                  // );
                                                }),
                                                Text(
                                                  "Total Orders",
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: textSegoeUiColorContentSize14,
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ))),
                        ]),
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(
                            left: dimen20, right: dimen20, top: dimen20),
                        child: Row(children: [
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(dimen15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(dimen20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 15.0,
                                        ),
                                      ],
                                      border:
                                      Border.all(width: 1,
                                          color: const Color(colorE8EFF3))),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/total_product.png",
                                          width: dimen35,
                                          height: dimen35,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: dimen10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Obx(() {
                                                  return Text(
                                                    storeStatisticsController
                                                        .isLoading.value
                                                        ?
                                                    "0"
                                                        : storeStatisticsController
                                                        .storeStat.value
                                                        .totalProducts
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: textSegoeUiColorBlackSize18,
                                                  );

                                                  // return Text(
                                                  //   _analyticModel
                                                  //       .totalProduct !=
                                                  //       null
                                                  //       ? _analyticModel
                                                  //       .totalProduct!
                                                  //       : "0",
                                                  //   maxLines: 1,
                                                  //   overflow: TextOverflow
                                                  //       .ellipsis,
                                                  //   style: textSegoeUiColorBlackSize18,
                                                  // );
                                                }),
                                                Text(
                                                  "Total Products",
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: textSegoeUiColorContentSize14,
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ))),
                          SizedBox(
                            width: dimen10,
                          ),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.all(dimen15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(dimen20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 15.0,
                                        ),
                                      ],
                                      border:
                                      Border.all(width: 1,
                                          color: const Color(colorE8EFF3))),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/total_revenue.png",
                                          width: dimen35,
                                          height: dimen35,
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: dimen10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Obx(() {

                                                  return Text(
                                                    storeStatisticsController.isLoading.value ?
                                                    "0" : storeStatisticsController.storeStat.value.revenue.toString(),
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: textSegoeUiColorBlackSize18,
                                                  );

                                                  // return Text(
                                                  //   "$ugxSymbole ${_analyticModel
                                                  //       .totalProduct != null
                                                  //       ? _analyticModel
                                                  //       .totalProduct!
                                                  //       : "0"}",
                                                  //   maxLines: 1,
                                                  //   overflow: TextOverflow
                                                  //       .ellipsis,
                                                  //   style: textSegoeUiColorBlackSize18,
                                                  // );
                                                }),
                                                Text(
                                                  "Total Revenue",
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: textSegoeUiColorContentSize14,
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ))),
                        ]),
                      ),
                      SizedBox(
                        height: dimen20,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: dimen20, right: dimen20),
                          child: Row(children: [
                            Expanded(
                                child: Container(
                                    alignment: FractionalOffset.centerLeft,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.5,
                                    padding: EdgeInsets.all(dimen15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(dimen20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 15.0,
                                          ),
                                        ],
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(colorE8EFF3))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          child: Image.asset(
                                            "assets/icons/total_order.png",
                                            width: dimen35,
                                            height: dimen35,
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: dimen10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    _analyticModel
                                                        .totalOrders != null
                                                        ? _analyticModel
                                                        .totalOrders!
                                                        : "0",
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: textSegoeUiColorBlackSize18,
                                                  ),
                                                  Text(
                                                    "Store score",
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: textSegoeUiColorContentSize14,
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    ))),
                            Expanded(child: Container())
                          ])),
                      Container(
                          margin: EdgeInsets.only(
                              left: dimen20,
                              right: dimen20,
                              top: dimen30,
                              bottom: dimen20),
                          child: Row(children: [
                            Expanded(
                                child: Text(
                                  "Recent Orders",
                                  style: textSegoeUiColorBlackSize18Bold,
                                )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const OrderHistoryScreen()));
                                },
                                child: Text(
                                  "View All ",
                                  style: textSegoeUiColorSecondarySize16,
                                )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const OrderHistoryScreen()));
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: const Color(colorSecondary),
                                  size: dimen16,
                                ))
                          ])),
                      Container(
                          margin: EdgeInsets.only(
                              left: dimen20, right: dimen20),
                          child: _orderModel.isEmpty
                              ? Container(
                            margin: EdgeInsets.only(bottom: dimen30),
                            child: Text(
                              "Orders not found.",
                              style: textSegoeUiColorContentSize16,
                            ),
                          )
                              : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0.0),
                              itemCount: _orderModel.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) =>
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsScreen(
                                                    _orderModel[index]),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: dimen20),
                                        padding: EdgeInsets.all(dimen15),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(dimen15)),
                                            border: Border.all(
                                                width: 1,
                                                color: const Color(
                                                    colorE8EFF3))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      _orderModel[index]
                                                          .orderId!,
                                                      style: textSegoeUiColorBlackSize20,
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      _orderModel[index]
                                                          .dtCreateddate!,
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
                                                    _orderModel[index]
                                                        .chrStatus!))
                                                    .withOpacity(0.15),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(dimen30)),
                                              ),
                                              child: Text(
                                                getStatusText(
                                                    _orderModel[index]
                                                        .chrStatus!),
                                                style: getStatusTextStyle(
                                                    _orderModel[index]
                                                        .chrStatus!),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))))),
                      Container(
                          margin: EdgeInsets.only(
                              left: dimen20,
                              right: dimen20,
                              top: dimen30,
                              bottom: dimen20),
                          child: Row(children: [
                            Expanded(
                                child: Text(
                                  "Manage Products",
                                  style: textSegoeUiColorBlackSize18Bold,
                                )),
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => AddVendorProductsScreen());
                                  // Get.to(() => AddRetailProductTab());
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           AddVendorProductsScreen(),
                                  //     ));
                                },
                                child: Row(children: [
                                  Icon(
                                    Icons.add,
                                    color: const Color(colorSecondary),
                                    size: dimen16,
                                  ),
                                  Text(
                                    " ADD",
                                    style: textSegoeUiColorSecondarySize16,
                                  )
                                ])),
                          ])),
                      if (_productModel.data != null)
                        Container(
                            margin: EdgeInsets.only(
                              left: dimen20,
                              right: dimen20,
                            ),
                            child: _productModel.data!.isEmpty
                                ? Container(
                              margin: EdgeInsets.only(bottom: dimen30),
                              child: Text(
                                "Products not found.",
                                style: textSegoeUiColorContentSize16,
                              ),
                            )
                                : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0.0),
                                itemCount: _productModel.data!.length,
                                itemBuilder: ((context, index) =>
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: dimen20),
                                        padding: EdgeInsets.all(dimen15),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(dimen20)),
                                            border: Border.all(
                                                width: 1,
                                                color: const Color(
                                                    colorE8EFF3))),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            FadeInImage.assetNetwork(
                                              placeholder: 'assets/images/placeholder.png',
                                              imageErrorBuilder:
                                                  (context, error,
                                                  stackTrace) =>
                                                  Image.asset(
                                                    'assets/images/placeholder.png',
                                                  ),
                                              image: _productModel
                                                  .data![index].images![0]
                                                  .varImageUrl!,
                                              fit: BoxFit.fitWidth,
                                              width: dimen80,
                                              height: dimen80,
                                            ),
                                            Expanded(
                                                child: Container(
                                                  height: dimen80,
                                                  margin: EdgeInsets.only(
                                                      left: dimen10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                              alignment:
                                                              FractionalOffset
                                                                  .centerLeft,
                                                              child: Text(
                                                                _productModel
                                                                    .data![index]
                                                                    .varTitle!,
                                                                maxLines: 2,
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style:
                                                                textSegoeUiColor303733Size16,
                                                              ))),
                                                      if (_productModel
                                                          .data![index]
                                                          .oldPrice! !=
                                                          "0")
                                                        RichText(
                                                            text: TextSpan(
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                  text: "$ugxSymbole ${_productModel
                                                                      .data![index]
                                                                      .oldPrice!}",
                                                                  style: TextStyle(
                                                                    color:
                                                                    const Color(
                                                                        colorContent),
                                                                    fontSize: dimen14,
                                                                    fontWeight: FontWeight
                                                                        .w400,
                                                                    fontFamily: 'SegoeUi',
                                                                    decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                          children: [
                                                            Expanded(
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                                  children: [
                                                                    Text(
                                                                      "$ugxSymbole ${_productModel
                                                                          .data![index]
                                                                          .newPrice! !=
                                                                          "0"
                                                                          ? _productModel
                                                                          .data![index]
                                                                          .newPrice!
                                                                          : _productModel
                                                                          .data![index]
                                                                          .productVariations![
                                                                      0]
                                                                          .varPrice!}",
                                                                      maxLines: 2,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style:
                                                                      textSegoeUiColor292D32Size18Light,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5.0,
                                                                    ),
                                                                  ],
                                                                )),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          EditProductScreen(
                                                                              _productModel
                                                                                  .data![
                                                                              index]),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/icons/edit.png",
                                                                    width: dimen24,
                                                                    height: dimen24,
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              width: dimen10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // showDialog(
                                                                //   context: context,
                                                                //   builder: (context) =>
                                                                //       DeleteVendorProductDialog(
                                                                //     productId: _productModel
                                                                //         .data![index].intGlcode,
                                                                //   ),
                                                                // );
                                                              },
                                                              child: Container(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/icons/disable.png",
                                                                    width: dimen24,
                                                                    height: dimen24,
                                                                  )),
                                                            ),
                                                          ])
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ))))),
                      Container(
                          margin: EdgeInsets.only(
                              left: dimen20,
                              right: dimen20,
                              top: dimen30,
                              bottom: dimen20),
                          child: Row(children: [
                            Expanded(
                                child: Text(
                                  "Pending  Orders",
                                  style: textSegoeUiColorBlackSize18Bold,
                                )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const OrderHistoryScreen()));
                                },
                                child: Text(
                                  "View All ",
                                  style: textSegoeUiColorSecondarySize16,
                                )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const OrderHistoryScreen()));
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: const Color(colorSecondary),
                                  size: dimen16,
                                ))
                          ])),
                      Container(
                          margin: EdgeInsets.only(
                              left: dimen20, right: dimen20),
                          child: _orderPendingModel.isEmpty
                              ? Container(
                            margin: EdgeInsets.only(bottom: dimen30),
                            child: Text(
                              "Pending orders not found.",
                              style: textSegoeUiColorContentSize16,
                            ),
                          )
                              : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0.0),
                              itemCount: _orderPendingModel.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) =>
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsScreen(
                                                    _orderModel[index]),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: dimen20),
                                        padding: EdgeInsets.all(dimen15),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(dimen15)),
                                            border: Border.all(
                                                width: 1,
                                                color: const Color(
                                                    colorE8EFF3))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      _orderPendingModel[index]
                                                          .orderId!,
                                                      style: textSegoeUiColorBlackSize20,
                                                    ),
                                                    const SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      _orderPendingModel[index]
                                                          .dtCreateddate!,
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
                                                    _orderPendingModel[index]
                                                        .chrStatus!))
                                                    .withOpacity(0.15),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(dimen30)),
                                              ),
                                              child: Text(
                                                getStatusText(
                                                    _orderPendingModel[index]
                                                        .chrStatus!),
                                                style: getStatusTextStyle(
                                                    _orderPendingModel[index]
                                                        .chrStatus!),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))))),
                    ])))
          ]),
        ));
  }
}
