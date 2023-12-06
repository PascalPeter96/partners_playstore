import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/subscription/models/subscription_model.dart';
import 'package:wena_partners/vendor/subscription/repository/get_subscription_details_repository.dart';
import 'package:wena_partners/vendor/subscription/repository/subscribe_repository.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class SubscriptionScreen extends StatefulWidget {
  String subSrciptionId;
  SubscriptionScreen(this.subSrciptionId);
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<SubscriptionScreen> {
  final SubscriptionDetailsRepository _subscriptionDetailsRepository =
      SubscriptionDetailsRepository();
  final SubscribeRepository _subscribeRepository = SubscribeRepository();
  SubscriptionModel _model = SubscriptionModel();
  @override
  void initState() {
    // TODO: implement initState

    getSubscription();
    super.initState();
  }

  String _userId = "";
  String _userToken = "";
  getSubscription() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();
    _subscriptionDetailsRepository.getSubscriptionDetails(
        data: {"subscription_id": widget.subSrciptionId},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
          if (_subscriptionDetailsRepository.subResp.status == Status.LOADING) {
            showLoadingDialog();
          } else if (_subscriptionDetailsRepository.subResp.status ==
              Status.COMPLETED) {
            hideLoadingDialog();
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        _model = SubscriptionModel.fromJson(value['body']["data"]);
      }
    });
  }

  subscribe() async {
    _subscribeRepository.subScribe(
        data: {
          "fk_plan_id": widget.subSrciptionId,
          "fk_vendor": _userId,
          "var_auth_token": _userToken,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {
      if (value["body"]["status"] == 200) {
        showSuccess();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value["body"]["message"])));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
          child: Container(
              alignment: FractionalOffset.center,
              child: Column(children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: EdgeInsets.all(dimen15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: const Color(colorSecondary)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(dimen30))),
                        margin: EdgeInsets.only(top: dimen30),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/icons/diamond.png",
                              width: dimen100,
                              height: dimen100,
                            ),
                            if (_model.intGlcode != null)
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$ugxSymbole ${_model.price}",
                                      textAlign: TextAlign.center,
                                      style: textSegoeUiColor292D32Size34,
                                    ),
                                    Text(
                                      _model.month == "12"
                                          ? ' / Year'
                                          : " /${(_model.month == "1" ? '' : _model.month)} month",
                                      textAlign: TextAlign.center,
                                      style: textSegoeUiColorContentSize16,
                                    )
                                  ]),
                            SizedBox(
                              height: dimen30,
                            ),
                            if (_model.intGlcode != null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: HtmlWidget(_model.varDetails!),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: dimen40,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Amount",
                            style: textSegoeUiColor4C5967Size18,
                          )),
                          Text(
                            "$ugxSymbole ${_model.price}",
                            style: textSegoeUiColor4C5967Size18,
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimen20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Tax",
                            style: textSegoeUiColor4C5967Size18,
                          )),
                          Text(
                            "$ugxSymbole 0",
                            style: textSegoeUiColor4C5967Size18,
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimen20,
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: dimen20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            "Total",
                            style: textSegoeUiColor4C5967Size18,
                          )),
                          Text(
                            "$ugxSymbole ${_model.price}",
                            style: textSegoeUiColor4C5967Size18,
                          )
                        ],
                      ),
                    ]))),
                GestureDetector(
                    onTap: () {
                      subscribe();
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: dimen30, bottom: dimen30),
                        height: dimen50,
                        child: CustomButtonColorSecondaryWidget(
                            "Confirm Payment",
                            _subscribeRepository.subResp.status ==
                                Status.LOADING)))
              ])),
        ),
        "Review Summary");
  }

  showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(dimen30))),
          content: Wrap(
            children: [
              Container(
                  alignment: FractionalOffset.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(dimen30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/success.png",
                      ),
                      Text(
                        "Congratulations!",
                        style: textSegoeUiColorSecondarySize34,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: dimen20,
                      ),
                      Text(
                        ("You have successfully subscribed${_model.month! == "12"
                                ? ' 1 Year'
                                : " ${_model.month} month"}  premium. Enjoy the benefits!"),
                        style: textSegoeUiColorContentSize16,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: dimen20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: dimen20, bottom: dimen20),
                              height: dimen50,
                              child: const CustomButtonColorSecondaryWidget(
                                  "Ok Great!", false)))
                    ],
                  )),
            ],
          ),

          actions: const [],
        );
      },
    );
  }
}
