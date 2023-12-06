import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen();
  @override
  _NotificactionState createState() => _NotificactionState();
}

class _NotificactionState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: ListView.builder(
          itemCount: 0,
          itemBuilder: ((context, index) => Container(
                margin: EdgeInsets.only(bottom: dimen20),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/Initials_image.png",
                          width: dimen60,
                          height: dimen60,
                        ),
                      ),
                      SizedBox(
                        width: dimen20,
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You have received new order request",
                                style: textSegoeUiColor292D32Size18,
                              ),
                              SizedBox(
                                height: dimen10,
                              ),
                              Text(
                                "Today 2:30",
                                textAlign: TextAlign.start,
                                style: textSegoeUiColorContentSize14,
                              )
                            ]),
                      )),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: dimen30,
                          bottom: dimen30,
                          left: dimen30,
                          right: dimen20),
                      height: dimen30,
                      child: Row(children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: const Color(colorSecondary),
                              borderRadius: BorderRadius.circular(dimen10)),
                          child: Align(
                              alignment: FractionalOffset.center,
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              "View",
                                              style: textSegoeUiWhiteSize16,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ])),
                        )),
                        SizedBox(
                          width: dimen10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: const Color(colorSecondary).withOpacity(0.3),
                              border: Border.all(
                                  width: 1, color: const Color(colorSecondary)),
                              borderRadius: BorderRadius.circular(dimen10)),
                          child: Align(
                              alignment: FractionalOffset.center,
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              "ACCEPT",
                                              style:
                                                  textSegoeUiColorSecondarySize16,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ])),
                        )),
                        SizedBox(
                          width: dimen10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: const Color(colorLightRed).withOpacity(0.15),
                              border: Border.all(
                                  width: 1,
                                  color: const Color(colorLightRed).withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(dimen10)),
                          child: Align(
                              alignment: FractionalOffset.center,
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              "REJECT",
                                              style:
                                                  textSegoeUiColorOpacityLightRedSize14,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ])),
                        )),
                      ])),
                  SizedBox(
                    height: dimen20,
                  ),
                  const Divider(
                    color: Color(colorContent),
                    height: 2,
                  )
                ]),
              )),
        )),
        "Notifications");
  }
}
