import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

double toastIconSize = 30;
double toastHeight = 80;
double toastBorderRadius = 10;
double toastMessageFontSize = 13;
double toastTitleFontSize = 16;

class Toast {
  static successToast({@required BuildContext? context, @required String? message}) {
   /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.success(
      title: const Text("Success"),
      description: Text(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(context!).size.width - 15,
      borderRadius: toastBorderRadius,
      iconType: IconType.cupertino,
    ).show(context);
  }

  static warningToast({@required BuildContext? context, double? height,@required String? message}) {
   /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.warning(
      title: const Text('Warning'),
      description: Text(message!),
      iconSize: toastIconSize,
      height: height ?? toastHeight,
      width: MediaQuery.of(context!).size.width - 16,
      borderRadius: toastBorderRadius,
      iconType: IconType.cupertino,
    ).show(context);
  }

  static errorToast({@required BuildContext? context, @required String? message}) {
   /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.error(
      title: const Text('Error'),
      description: Text(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(context!).size.width - 15,
      borderRadius: toastBorderRadius,
      iconType: IconType.cupertino,
    ).show(context);
  }

  static infoToast(
      {@required BuildContext? context,
      @required String? message,
      @required String? title,
      }) {
   /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.info(
      title: Text(title!),
      description: Text(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(context!).size.width - 15,
      borderRadius: toastBorderRadius,
      iconType: IconType.cupertino,
    ).show(context);
  }

  static deleteToast({@required BuildContext? context, @required String? message}) {
   /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.delete(
      title: const Text('Deleted'),
      description: Text(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(context!).size.width - 15,
      borderRadius: toastBorderRadius,
      iconType: IconType.cupertino,
    ).show(context);
  }
}
