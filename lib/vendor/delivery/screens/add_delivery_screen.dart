import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/common_input_widget.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';

class AddDeliveryScreen extends StatefulWidget {
  @override
  _AddDeliveryState createState() => _AddDeliveryState();
}

class _AddDeliveryState extends State<AddDeliveryScreen> {
  final TextEditingController _controllerDriverName = TextEditingController();
  final TextEditingController _controllerMobileNumber = TextEditingController();
  final TextEditingController _controllerEmailAddress = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerLicenceNumber = TextEditingController();
  final TextEditingController _controllerVehicleNumer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                      alignment: FractionalOffset.centerLeft,
                      child: Column(
                        children: [
                          SizedBox(
                            height: dimen40,
                          ),
                          CommonInputWidget(
                            _controllerDriverName,
                            hint: "Driver Name",
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          MobileInputWidget(
                            controller: _controllerMobileNumber,
                            isEnabled: true,
                            onCountryCodeChange: (code) {},
                            contentPadding: const EdgeInsets.only(left: 5),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          CommonInputWidget(
                            _controllerEmailAddress,
                            hint: "Email Address",
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          CommonInputWidget(
                            _controllerPassword,
                            isSecure: true,
                            hint: "Password",
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          CommonInputWidget(
                            _controllerLicenceNumber,
                            hint: "License Number",
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          Container(
                            height: dimen50,
                            padding: EdgeInsets.only(
                                left: dimen10,
                                right: dimen10,
                                bottom: dimen05,
                                top: dimen05),
                            decoration: BoxDecoration(
                                color: const Color(colorF7F8F9),
                                border: Border.all(
                                    width: 2.0, color: const Color(colorDADADA)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dimen10))),
                            child: SizedBox(
                              width:
                                  MediaQuery.of(context).size.width - dimen50,
                              child: Stack(
                                alignment: FractionalOffset.center,
                                children: [
                                  Container(
                                      alignment: FractionalOffset.centerLeft,
                                      child: Text("Vehical type",
                                          style:
                                              textSegoeUiColorContentSize16)),
                                  Container(
                                      alignment: FractionalOffset.centerRight,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        underline: Container(),
                                        icon: Image.asset(
                                          "assets/icons/arrow_down.png",
                                          width: dimen16,
                                          height: dimen16,
                                        ),
                                        items: <String>[].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_) {
                                          setState(() {});
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                          CommonInputWidget(
                            _controllerVehicleNumer,
                            hint: "Vehical Number",
                          ),
                          SizedBox(
                            height: dimen20,
                          ),
                        ],
                      )))),
          Container(
              margin: EdgeInsets.only(top: dimen30, bottom: dimen30),
              height: dimen50,
              child: Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            const CustomButtonColorLightRedWidget("Cancel", false))),
                SizedBox(
                  width: dimen10,
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {},
                        child:
                            const CustomButtonColorSecondaryWidget("Save", false))),
              ]))
        ])),
        "Add Delivery Agent");
  }
}
