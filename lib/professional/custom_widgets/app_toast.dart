import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AppToast {
  static showToast(text){
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white.withOpacity(0.4),
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
