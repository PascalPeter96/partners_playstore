import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';


class MobileInputWidget extends StatefulWidget {
  TextEditingController? controller;
  bool? isEnabled;
  bool? isPadding;
  EdgeInsetsGeometry? contentPadding;
  var onCountryCodeChange;
  String countryCode;
  bool isError;
  MobileInputWidget(
      {Key? key,
      this.controller,
      this.isEnabled,
      this.isPadding = true,
      this.onCountryCodeChange,
      this.contentPadding,
      this.countryCode = "",
      this.isError = false})
      : super(key: key);

  @override
  State<MobileInputWidget> createState() => _MobileInputWidgetState();
}

class _MobileInputWidgetState extends State<MobileInputWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: widget.isError ? 2.0 : 1.0,
              color: widget.isError ? Colors.red : const Color(colorDADADA)),
          color: const Color(colorF7F8F9),
          borderRadius: BorderRadius.all(Radius.circular(dimen15))),
      padding: EdgeInsets.all(widget.isPadding == false ? dimen06 : dimen12),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {},
              child: Row(children: [
                Image.asset(
                  "assets/icons/flag.png",
                  width: dimen25,
                  height: dimen25,
                ),
                Padding(
                    padding: EdgeInsets.only(left: dimen05, right: dimen05),
                    child: Text(
                      widget.countryCode != "" ? widget.countryCode : "+256",
                      style: textSegoeUiColorContentSize16,
                    )),
                Image.asset(
                  "assets/icons/arrow_down.png",
                  width: dimen15,
                  height: dimen20,
                  color: Colors.grey,
                )
              ])),
          SizedBox(
            width: dimen05,
          ),
          Container(
            height: dimen25,
            width: 1.0,
            margin: EdgeInsets.only(right: dimen05),
            color: const Color(colorDADADA),
          ),
          Expanded(
            child: TextFormField(
                cursorColor: Colors.black,
                textAlign: TextAlign.left,
                enabled: widget.isEnabled,
                controller: widget.controller,
                textInputAction: TextInputAction.done,
                maxLength: 9,
                keyboardType: TextInputType.number,
                obscureText: false,
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                    counterText: "",
                    hintText: " Enter your Phone",
                    isDense: true,
                    // Added this
                    // contentPadding: const EdgeInsets.only(left: 1, top: 5, bottom: 5, right: 5), // Added this
                    contentPadding: const EdgeInsets.only(
                        left: 1, top: 5, bottom: 5, right: 5),
                    // Added this
                    border: InputBorder.none,
                    hintStyle: textSegoeUiColorContentSize16),
                style: textSegoeUiColorBlackSize16),
          ),
        ],
      ),
    );
  }
}
