import 'dart:core';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/transaction/models/transaction_model.dart';
import 'package:wena_partners/vendor/transaction/repository/complete_transaction_repository.dart';
import 'package:wena_partners/vendor/transaction/repository/wallet_amount_repository.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

class AccountStatementScreen extends StatefulWidget {
  @override
  _AccountStatementState createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatementScreen> {
  final int _selectPos = 0;
  bool _isAllChecked = false;

  final TransactionCompleteRepository _transactionRepository =
      TransactionCompleteRepository();
  List<TransactionModel> _transactionList = [];
  getTransactions(String url, var data) async {
    _transactionList.clear();
    _transactionRepository
        .getCompleteTranstions(
            url: url,
            data: data,
            stateChange: () {
              if (mounted) {
                setState(() {});

                if (_transactionRepository.productResp.status ==
                    Status.LOADING) {
                  showLoadingDialog();
                } else if (_transactionRepository.productResp.status ==
                    Status.COMPLETED) {
                  hideLoadingDialog();
                }
              }
            })
        .then((value) {
      if (value["body"]["status"] == 200) {
        _transactionList = value['body']["data"]
            .map<TransactionModel>((json) => TransactionModel.fromJson(json))
            .toList();
      } else {}
    });
  }

  final WalletAmountRepository _walletAmountRepository = WalletAmountRepository();
  dynamic walletAmount = 0.0;
  getWalletAmount() {
    _walletAmountRepository.getWalletAmount(
        data: {"vendor_id": _userId},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        walletAmount = value["data"]["total_amount"];
      }
    });
  }

  String _userId = "";
  String _userToken = "";
  getUserDetails() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();
    getTransactions(APIString.earningUrl, {"vendor_id": _userId});
    getWalletAmount();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  Map<String, TransactionModel> selectedModels = {};
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
      sheet.getRangeByName('B$counter').setText(value.createDate);
      //Add DateTime
      sheet
          .getRangeByName('C$counter')
          .setText(getStatusText(value.chrStatus));

      counter++;
      // Save the document.
    });

    final List<int> bytes = workbook.saveAsStream();
    try {
      final directory = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String fileName = "account_report_${DateTime.now()
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
                      selectedModels.clear();
                      setState(() {
                        _isAllChecked = value!;
                        if (value) {
                          for (var element in _transactionList) {
                            element.isCheck = true;
                            selectedModels[element.intGlCode] = element;
                          }
                        } else {
                          for (var element in _transactionList) {
                            element.isCheck = false;
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
              SizedBox(
                height: dimen20,
              ),
              ListView.builder(
                  itemCount: _transactionList.length,
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
                              value: _transactionList[index].isCheck,
                              onChanged: (bool? value) {
                                if (value!) {
                                  _transactionList[index].isCheck = value;
                                  selectedModels[_transactionList[index]
                                      .intGlCode] = _transactionList[index];
                                } else {
                                  _transactionList[index].isCheck = value;
                                  selectedModels.remove(
                                      _transactionList[index].intGlCode);
                                }
                                setState(() {});
                              },
                            ),
                            Container(
                                alignment: FractionalOffset.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    bottom: 5.0,
                                    top: 5.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: const Color(colorE8ECF4)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(dimen15))),
                                margin: EdgeInsets.only(right: dimen10),
                                child: Image.asset(
                                  _transactionList[index].transactionType == "C"
                                      ? "assets/icons/icon_down_arrow.png"
                                      : "assets/icons/icon_top_arrow.png",
                                  width: dimen30,
                                  height: dimen30,
                                )),
                            Expanded(
                                child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        _transactionList[index].createDate,
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        _transactionList[index].orderId,
                                        style: textSegoeUiColorBlackSize20,
                                      ),
                                    ),
                                  ]),
                            )),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: dimen10,
                                      right: dimen10,
                                      top: 5.0,
                                      bottom: 5.0),
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    "$ugxSymbole ${_transactionList[index].amount}",
                                    style: _transactionList[index]
                                                .transactionType ==
                                            "C"
                                        ? textSegoeUiColorSecondarySize16
                                        : textSegoeUiColorLightRedSize16,
                                  ),
                                )),
                          ]),
                        ),
                      ))),
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
        "Account Statement");
  }
}
