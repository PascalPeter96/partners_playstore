import 'dart:core';
import 'package:flutter/material.dart';
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
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class TransctionlistScreen extends StatefulWidget {
  @override
  _TransactionlistState createState() => _TransactionlistState();
}

class _TransactionlistState extends State<TransctionlistScreen> {
  final int _selectPos = 0;
  final bool _isAllChecked = false;

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
                                        "#0315648",
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
            Container(
                margin: EdgeInsets.only(top: dimen20, bottom: dimen20),
                height: dimen50,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Total",
                      style: textSegoeUiColorBlackSize20,
                    )),
                    Container(
                      child: Text(
                        "$ugxSymbole $walletAmount",
                        style: textSegoeUiColorBlackSize20,
                      ),
                    )
                  ],
                ))
          ],
        ))),
        "Transaction List");
  }
}
