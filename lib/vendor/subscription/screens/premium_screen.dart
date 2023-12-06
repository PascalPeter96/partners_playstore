import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/subscription/screens/subscription_screen.dart';

import '../../utils/status.dart';
import '../../widget/background_widget_wb.dart';
import '../../widget/loading_dialog.dart';
import '../models/subscription_model.dart';
import '../repository/get_allsubscription_repository.dart';

class PremiumScreen extends StatefulWidget {
  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<PremiumScreen> {
  final SubscriptionListRepository _subscriptionListRepository =
      SubscriptionListRepository();

  List<SubscriptionModel> subscription = [];
  @override
  void initState() {
    // TODO: implement initState
    getSubscription();
    super.initState();
  }

  getSubscription() async {
    _subscriptionListRepository.getSubscription(stateChange: () {
      if (mounted) {
        setState(() {});
      }
      if (_subscriptionListRepository.subResp.status == Status.LOADING) {
        showLoadingDialog();
      } else if (_subscriptionListRepository.subResp.status ==
          Status.COMPLETED) {
        hideLoadingDialog();
      }
    }).then((value) {
      if (value["body"]["status"] == 200) {
        subscription = value['body']["data"]
            .map<SubscriptionModel>((json) => SubscriptionModel.fromJson(json))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: SingleChildScrollView(
          child: Container(
              alignment: FractionalOffset.topCenter,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Upgrade to premium",
                      textAlign: TextAlign.center,
                      style: textSegoeUiColor292D32Size32,
                    ),
                    SizedBox(
                      height: dimen20,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: dimen20, right: dimen20),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and t's standard dummy text ",
                          style: textSegoeUiColorContentSize16,
                          textAlign: TextAlign.center,
                        )),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: subscription.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubscriptionScreen(
                                                subscription[index]
                                                    .intGlcode!)));
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width -
                                      dimen40,
                                  padding: EdgeInsets.all(dimen15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: const Color(colorSecondary)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(dimen30))),
                                  margin: EdgeInsets.only(top: dimen30),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/diamond.png",
                                        width: dimen100,
                                        height: dimen100,
                                      ),
                                      Text(
                                        subscription[index].varTitle!,
                                        style: textSegoeUiColor292D32Size20,
                                      ),
                                      SizedBox(
                                        height: dimen30,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: HtmlWidget(
                                            subscription[index]
                                                .varDetails!, // Your Html code over here
                                          ))
                                        ],
                                      ),
                                    ],
                                  )),
                            )),
                    SizedBox(
                      height: dimen50,
                    ),
                  ])),
        )),
        "Subscriptions");
  }
}
