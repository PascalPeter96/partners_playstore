import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/sizes.dart';
import '../../styles/theme.dart';
import '../../widget/background_widget_wb.dart';

class DeliveryAgentScreen extends StatefulWidget {
  @override
  _DeliveryAganetState createState() => _DeliveryAganetState();
}

class _DeliveryAganetState extends State<DeliveryAgentScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: ((context, index) => Container(
                    margin: EdgeInsets.only(bottom: dimen20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: dimen50,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Delivery Agent",
                                    style: textSegoeUiColor292D32Size18,
                                  )),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: dimen10,
                                            right: dimen10,
                                            top: dimen05,
                                            bottom: dimen05),
                                        decoration: BoxDecoration(
                                            color: const Color(colorSecondary)
                                                .withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(dimen15)),
                                        child: Text(
                                          "ASSIGN",
                                          style:
                                              textSegoeUiColorOpacityLightGreenSize14,
                                        ),
                                      )),
                                ],
                              )),
                          SizedBox(
                            height: dimen10,
                          ),
                          Text(
                            "Vehical Type :- Big Vehical 6 tyre",
                            textAlign: TextAlign.start,
                            style: textSegoeUiColorContentSize14,
                          ),
                          SizedBox(
                            height: dimen10,
                          ),
                          Text(
                            "Vehical Number :- UG 18 AB 1234",
                            textAlign: TextAlign.start,
                            style: textSegoeUiColorContentSize14,
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          const Divider(
                            color: Color(colorContent),
                            height: 2,
                          )
                        ]),
                  )),
            ),
          ),
        ),
        "List of Delivery Agent");
  }
}
