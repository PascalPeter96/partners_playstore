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
import 'package:wena_partners/vendor/transaction/repository/withdrow_repository.dart';
import 'package:wena_partners/vendor/transaction/screen/transaction_list.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';


class WalletScreen extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<WalletScreen> {
  int _selectPos = 0;
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

  final WithdrowRepository _withdrowRepository = WithdrowRepository();

  withdrow() {
    _withdrowRepository.withdrow(
        data: {"vendor_id": _userId},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        getUserDetails();
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

  Future<void> _showMyDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dcontext) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: textSegoeUiColor161616Size16),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay', style: textSegoeUiColor161616Size18),
              onPressed: () {
                Navigator.of(dcontext).pop();
              },
            ),
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
                padding: EdgeInsets.all(dimen20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(dimen30)),
                    border: Border.all(
                      width: 2,
                      color: const Color(colorSecondary),
                    )),
                child: Column(children: [
                  Container(
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "Balance",
                          style: textSegoeUiColorContentSize20,
                        ),
                      ),
                      if (walletAmount != null)
                        Container(
                          child: Text(
                            ugxSymbole +
                                double.parse(walletAmount.toString())
                                    .toStringAsFixed(2),
                            style: textSegoeUiColor292D32Size34,
                          ),
                        )
                    ]),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (walletAmount == 0.0) {
                          _showMyDialog(
                            context,
                            "Not enough amount in your wallet to withdraw.",
                          );
                        } else {
                          withdrow();
                        }
                      },
                      child: Container(
                          margin:
                              EdgeInsets.only(top: dimen20, bottom: dimen20),
                          height: dimen50,
                          child: const CustomButtonColorSecondaryWidget(
                              "Withdraw", false)))
                ]),
              ),
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
                            if (mounted) {
                              setState(() {});
                              getTransactions(
                                  APIString.earningUrl, {"vendor_id": _userId});
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
                              "EARNING",
                              style: _selectPos == 0
                                  ? textSegoeUiColorSecondarySize16
                                  : textSegoeUiColorContentSize16,
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            _selectPos = 1;
                            if (mounted) {
                              setState(() {});
                              getTransactions(APIString.pendingTransactionUrl,
                                  {"vendor_id": _userId});
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
                            if (mounted) {
                              setState(() {});
                              getTransactions(APIString.completedTransctionUrl,
                                  {"vendor_id": _userId});
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
              Container(
                child: Row(children: [
                  Expanded(
                      child: Text(
                    "Transaction",
                    style: textSegoeUiColorBlackSize20,
                  )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransctionlistScreen()));
                      },
                      child: Container(
                          child: Text(
                        "View All",
                        style: textSegoeUiColorSecondarySize18,
                      )))
                ]),
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
          ],
        ))),
        "Your Wallet");
  }
}
