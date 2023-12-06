import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

import '../../config/local_storage.dart';
import '../../orders/models/order_model.dart';
import '../../orders/repository/order_repository.dart';
import '../../styles/colors.dart';
import '../../styles/sizes.dart';
import '../../styles/theme.dart';
import '../../utils/const.dart';
import '../../utils/status.dart';
import '../../widget/background_widget_wb.dart';
import '../../widget/custome_buttons.dart';
import '../../widget/loading_dialog.dart';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportState createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReportScreen> {
  int _selectPos = 0;
  bool _isAllChecked = false;

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

    getOrders("S");
  }

  exportExcel() async {
    // Create a new Excel document.
    final excel.Workbook workbook = excel.Workbook();
    //Accessing worksheet via index.
    int counter = 2;
    excel.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText("Order Id");
    //Add Number
    sheet.getRangeByName('B1').setText("Date");
    //Add DateTime
    sheet.getRangeByName('C1').setText("Status");
    selectedModels.forEach((key, value) {
      //Add Text.
      sheet.getRangeByName('A$counter').setText(value.orderId);
      //Add Number
      sheet
          .getRangeByName('B$counter')
          .setText(value.dtCreateddate);
      //Add DateTime
      sheet
          .getRangeByName('C$counter')
          .setText(getStatusText(value.chrStatus!));

      counter++;
      // Save the document.
    });

    final List<int> bytes = workbook.saveAsStream();
    try {
      final directory = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String fileName = "sale_report_${DateTime.now()
              .toString()
              .replaceAll(" ", "_")
              .replaceAll(".", "")
              .replaceAll(":", "_")
              .replaceAll("-", "_")}.xlsx";
      final File file = File('$directory/$fileName');
      if (!file.existsSync()) {
        File('$directory/$fileName').create(recursive: true);
      }
      await file.writeAsBytes(bytes);

      workbook.dispose();
      showDialogMessage(file.path);
    } catch (e) {
      String s = "";
    }
  }

  showDialogMessage(var file) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Text(
                      "Data exported.",
                      style: textSegoeUiColorContentSize14,
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
                alignment: FractionalOffset.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      OpenFilex.open(file);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: dimen20),
                        color: Colors.transparent,
                        child: Text(
                          'Open',
                          style: textSegoeUiColorContentSize14,
                        )))),
          ],
        );
      },
    );
  }

  Map<String, OrderModel> selectedModels = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: Container(
                child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
                        child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: const Color(colorDADADA)),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(dimen10))),
                  padding: EdgeInsets.all(dimen12),
                  child: Row(children: [
                    Image.asset(
                      "assets/icons/icon_search.png",
                      width: dimen30,
                      height: dimen30,
                    ),
                    Expanded(
                        child: TextFormField(
                            cursorColor: const Color(colorContent),
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            onSaved: (value) {},
                            validator: (value) {
                              return null;
                            },
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "Search Order...",
                                isDense: true, // Added this
                                contentPadding: const EdgeInsets.only(
                                    left: 1,
                                    top: 5,
                                    bottom: 5,
                                    right: 5), // Added this
                                border: InputBorder.none,
                                hintStyle: textSegoeUiColorContentSize16),
                            style: textSegoeUiColorBlackSize16)),
                    Container(
                        padding: EdgeInsets.all(dimen05),
                        decoration: BoxDecoration(
                            color: const Color(colorSecondary),
                            borderRadius:
                                BorderRadius.all(Radius.circular(dimen10))),
                        child: Image.asset(
                          "assets/icons/icon_sort_menu.png",
                          width: dimen24,
                          height: dimen24,
                        ))
                  ])),
              Container(
                margin: EdgeInsets.only(top: dimen20),
                height: dimen40,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _selectPos = 0;
                            getOrders("S");
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(left: dimen20, right: dimen20),
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 02,
                                    color: Color(_selectPos == 0
                                        ? colorSecondary
                                        : colorContent)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dimen40)),
                                color: Color(_selectPos == 0
                                        ? colorSecondary
                                        : 0xffffffff)
                                    .withOpacity(0.2)),
                            child: Text(
                              "COMPLETED",
                              style: _selectPos == 0
                                  ? textSegoeUiColorSecondarySize16
                                  : textSegoeUiColorContentSize16,
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            _selectPos = 1;
                            getOrders("p");
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: dimen20),
                            padding:
                                EdgeInsets.only(left: dimen20, right: dimen20),
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 02,
                                    color: Color(_selectPos == 1
                                        ? colorSecondary
                                        : colorContent)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dimen40)),
                                color: Color(_selectPos == 1
                                        ? colorSecondary
                                        : 0xffffffff)
                                    .withOpacity(0.2)),
                            child: Text(
                              "PENDING",
                              style: _selectPos == 1
                                  ? textSegoeUiColorSecondarySize16
                                  : textSegoeUiColorContentSize16,
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            _selectPos = 2;
                            getOrders("C");
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: dimen20),
                            padding:
                                EdgeInsets.only(left: dimen20, right: dimen20),
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 02,
                                    color: Color(_selectPos == 2
                                        ? colorSecondary
                                        : colorContent)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dimen40)),
                                color: Color(_selectPos == 2
                                        ? colorSecondary
                                        : 0xffffffff)
                                    .withOpacity(0.2)),
                            child: Text(
                              "CANCELED",
                              style: _selectPos == 2
                                  ? textSegoeUiColorSecondarySize16
                                  : textSegoeUiColorContentSize16,
                            ),
                          ))
                    ]),
              ),
              SizedBox(
                height: dimen20,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: const Color(colorSecondary),
                    value: _isAllChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAllChecked = value!;
                        selectedModels.clear();
                        for (var element in _orderModel) {
                          element.isCheck = value;
                          if (value) {
                            selectedModels[element.fkOrder!] = element;
                          } else {
                            selectedModels.remove(element.fkOrder);
                          }
                        }
                      });
                    },
                  ),
                  Expanded(
                      child: Text(
                    "Select All",
                    style: textSegoeUiColorContentSize20,
                  ))
                ],
              ),
              ListView.builder(
                  itemCount: _orderModel.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) => GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(dimen10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(dimen10)),
                              border: Border.all(
                                  width: 1.0,
                                  color: const Color(colorContent).withOpacity(0.3))),
                          margin: EdgeInsets.only(bottom: dimen15),
                          child: Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: const Color(colorSecondary),
                              value: _orderModel[index].isCheck,
                              onChanged: (bool? value) {
                                _orderModel[index].isCheck = value!;
                                if (value) {
                                  selectedModels[_orderModel[index].fkOrder!] =
                                      _orderModel[index];
                                } else {
                                  selectedModels
                                      .remove(_orderModel[index].fkOrder!);
                                }
                                setState(() {});
                              },
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        _orderModel[index].orderId!,
                                        style: textSegoeUiColorBlackSize20,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        _orderModel[index].dtCreateddate!,
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                    )
                                  ]),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dimen30)),
                              ),
                              child: Text(
                                getStatusText(_orderModel[index].chrStatus!),
                                style: getStatusTextStyle(
                                    _orderModel[index].chrStatus!),
                              ),
                            )
                          ]),
                        ),
                      )))
            ])))),
            GestureDetector(
                onTap: () async {
                  if (selectedModels.isNotEmpty) {
                    var status = await Permission.storage.status;
                    if (status.isGranted) {
                      exportExcel();
                    }
                    if (await Permission.storage.isDenied) {
                      if (await Permission.storage.request().isGranted) {
                        exportExcel();
                      }
                    }
                    if (await Permission.storage.isRestricted) {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.storage,
                      ].request();
                      if (statuses[Permission.storage]!.isGranted) {
                        exportExcel();
                      }
                    }
                  } else {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Container(
                                    alignment: FractionalOffset.centerLeft,
                                    child: Text(
                                      "Selected orders to export.",
                                      style: textSegoeUiColorContentSize14,
                                    )),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Container(
                                alignment: FractionalOffset.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(right: dimen20),
                                        color: Colors.transparent,
                                        child: Text(
                                          'Okay',
                                          style: textSegoeUiColorContentSize14,
                                        )))),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(top: dimen20, bottom: dimen20),
                    height: dimen50,
                    child: const CustomButtonColorSecondaryWidget("Export", false)))
          ],
        ))),
        "Sales Statement");
  }
}
