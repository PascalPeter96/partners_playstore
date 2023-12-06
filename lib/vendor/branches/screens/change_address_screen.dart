import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';

class BranchesScreen extends StatefulWidget {
  @override
  _BranchesState createState() => _BranchesState();
}

class _BranchesState extends State<BranchesScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: SingleChildScrollView(
                child: Container(
                    alignment: FractionalOffset.centerLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: dimen20,
                                  right: dimen20,
                                  top: dimen30,
                                  bottom: dimen10),
                              child: Row(children: [
                                Icon(
                                  Icons.add,
                                  color: const Color(colorSecondary),
                                  size: dimen16,
                                ),
                                Text(
                                  " Add another branch",
                                  style: textSegoeUiColorSecondarySize16Bold,
                                ),
                              ])),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            height: 1,
                            color: const Color(colorContent).withOpacity(0.2),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            alignment: FractionalOffset.centerLeft,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Branch 1",
                                            style: textSegoeUiColor161616Size16,
                                          ),
                                          SizedBox(
                                            height: dimen10,
                                          ),
                                          Text(
                                            "3135 Southern Street, Lynbrook, NY, New York, 11563",
                                            style:
                                                textSegoeUiColorContentSize16Light,
                                          )
                                        ]),
                                  )),
                                  Image.asset(
                                    "assets/icons/edit_circle.png",
                                    width: dimen30,
                                    height: dimen30,
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            height: 1,
                            color: const Color(colorContent).withOpacity(0.2),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            alignment: FractionalOffset.centerLeft,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Branch 1",
                                            style: textSegoeUiColor161616Size16,
                                          ),
                                          SizedBox(
                                            height: dimen10,
                                          ),
                                          Text(
                                            "3135 Southern Street, Lynbrook, NY, New York, 11563",
                                            style:
                                                textSegoeUiColorContentSize16Light,
                                          )
                                        ]),
                                  )),
                                  Image.asset(
                                    "assets/icons/edit_circle.png",
                                    width: dimen30,
                                    height: dimen30,
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            height: 1,
                            color: const Color(colorContent).withOpacity(0.2),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                        ])))),
        "Change Address");
  }
}
