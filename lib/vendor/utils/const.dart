
import 'package:wena_partners/vendor/styles/theme.dart';


import '../styles/colors.dart';

String app_name = "Wena";
String deviceToken = "";
double userLat = 0;
double userLon = 0;
String ugxSymbole = "UGX";
bool isSubscribed = false;
String FCM_TOKEN = "";

getStatusColor(String status) {
  if (status.toLowerCase() == "a") {
    return colorE5740B;
  } else if (status.toLowerCase() == "s") {
    return colorSecondary;
  } else if (status.toLowerCase() == "c") {
    return colorLightRed;
  } else {
    return colorLightRed;
  }
}

getStatusText(String status) {
  if (status.toLowerCase() == "a") {
    return "Accepted";
  } else if (status.toLowerCase() == "c") {
    return "Canceled";
  } else if (status.toLowerCase() == "p") {
    return "Pending";
  } else if (status.toLowerCase() == "s") {
    return "Completed";
  }
}

getStatusTextStyle(String status) {
  if (status.toLowerCase() == "a") {
    return textSegoeUiColorE5740BSize16;
  } else if (status.toLowerCase() == "c") {
    return textSegoeUiColorLightRedSize16;
  } else if (status.toLowerCase() == "p") {
    return textSegoeUiColorE5740BSize16;
  } else if (status.toLowerCase() == "s") {
    return textSegoeUiColorSecondarySize16;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

bool validatePassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  print(value);
  if (value.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}

bool mobileNumberValidator(String mobileNumber) {
  String pattern = r"^[(]?[1-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{3}$";
  RegExp regex = RegExp(pattern);
  print(mobileNumber);
  if (mobileNumber.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(mobileNumber)) {
      return false;
    } else {
      return true;
    }
  }
}
