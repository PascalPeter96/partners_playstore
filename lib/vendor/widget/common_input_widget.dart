import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';

class CommonInputWidget extends StatelessWidget {
  TextEditingController controller;
  String hint;
  bool isSecure;
  TextInputType inputType;
  FocusNode? nextFocusNode;
  TextInputAction actionType;
  FocusNode? focusNode;
  bool isValidator = false;
  String validatorString = "";
  int line;
  int maxlength;
  var textChangeListner;
  bool isEnabled;
  bool haveForceError;
  String forceError;
  CommonInputWidget(this.controller,
      {this.hint = "",
      this.isSecure = false,
      this.inputType = TextInputType.text,
      this.focusNode,
      this.nextFocusNode,
      this.isValidator = false,
      this.validatorString = "",
      this.line = 1,
      this.maxlength = 100,
      this.actionType = TextInputAction.next,
      this.textChangeListner,
      this.isEnabled = true,
      this.haveForceError = false,
      this.forceError = ""});

  @override
  Widget build(BuildContext context) {
    if (textChangeListner != null) {
      controller.addListener(() {
        textChangeListner(controller.text);
      });
    }
    return Container(
        child: isSecure
            ? TextFormField(
                cursorColor: const Color(colorContent),
                textAlign: TextAlign.left,
                controller: controller,
                textInputAction: actionType,
                focusNode: focusNode,
                keyboardType: inputType,
                obscureText: isSecure,
                enabled: isEnabled,
                onChanged: (value) {},
                onSaved: (value) {
                  if (focusNode != null) {
                    FocusScope.of(context).requestFocus(nextFocusNode);
                  }
                },
                validator: (value) {
                  if (haveForceError) {
                    return forceError;
                  }
                  if (isValidator) {
                    if (TextInputType.emailAddress == inputType) {
                      if (value == "") {
                        return "Email is required";
                      } else if (!value!.isValidEmail()) {
                        return "Email is not valid";
                      }
                    } else if (value == "") {
                      return validatorString;
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    counterText: "",
                    hintText: hint,
                    contentPadding: EdgeInsets.only(
                        left: dimen20,
                        top: dimen10,
                        bottom: dimen10,
                        right: dimen20), // Added this
                    border: InputBorder.none,
                    filled: true,
                    errorMaxLines: 3,
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(colorDADADA)),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    errorStyle: textSegoeUiColorRedSize16,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    fillColor: const Color(colorF7F8F9),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(colorDADADA)),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(colorDADADA)),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    hintStyle: textSegoeUiColorContentSize16),
                style: textSegoeUiColorBlackSize16)
            : TextFormField(
                cursorColor: const Color(colorContent),
                textAlign: TextAlign.left,
                controller: controller,
                textInputAction: actionType,
                focusNode: focusNode,
                keyboardType: inputType,
                minLines: line,
                maxLength: maxlength,
                enabled: isEnabled,
                maxLines: 10,
                obscureText: isSecure,
                onSaved: (value) {
                  if (focusNode != null) {
                    FocusScope.of(context).requestFocus(nextFocusNode);
                  }
                },
                validator: (value) {
                  if (haveForceError) {
                    return forceError;
                  }
                  if (isValidator) {
                    if (TextInputType.emailAddress == inputType) {
                      if (value == "") {
                        return "Email is required";
                      } else if (!value!.isValidEmail()) {
                        return "Email is not valid";
                      }
                    }
                    if (value == "") {
                      return validatorString;
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    counterText: "",
                    hintText: hint,
                    contentPadding: EdgeInsets.only(
                        left: dimen20,
                        top: dimen10,
                        bottom: dimen10,
                        right: dimen20), // Added this
                    border: InputBorder.none,
                    filled: true,
                    errorMaxLines: 3,
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(colorDADADA)),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    errorStyle: textSegoeUiColorRedSize16,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    fillColor: const Color(colorF7F8F9),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(colorDADADA)),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(colorDADADA)),
                      borderRadius: BorderRadius.circular(dimen10),
                    ),
                    hintStyle: textSegoeUiColorContentSize16),
                style: textSegoeUiColorBlackSize16));
  }
}
