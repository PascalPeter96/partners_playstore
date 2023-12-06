import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/network_handler.dart';
import 'package:wena_partners/vendor/models/auth/signin_vendor_model.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_phone_otp.dart';

class SignInVendorController extends GetxController {
  var isLoading = false.obs;

  final userStorage = GetStorage();

  loginVendor(String phoneNo) async {
    isLoading(true);

    SignInVendorModel signInVendorModel = SignInVendorModel(phoneNo: phoneNo);
    var response = await NetworkHandler.post(signInVendorModelToJson(signInVendorModel), 'store-login', '');

    var data = json.decode(response);

    if(data['status'] == 'success'){
      isLoading(false);
      print(data);
      // await userStorage.write('isLoggedIn', true);
      // await userStorage.write('email', data['data']['user']['email']);
      // await userStorage.write('walletId', data['data']['user']['wallet']['wallet_id']);
      // await userStorage.write('walletBalance', data['data']['user']['wallet']['balance']);
      // await userStorage.write('user', data['data']['user']);
      // await userStorage.write('customerId', data['data']['user']['customer']['customer_id']);
      // await userStorage.write('userId', data['data']['user']['id']);
      // await userStorage.write('accessToken', data['data']['accessToken']);
      // await userStorage.write('deviceToken', data['data']['user']['fcm_token']);
      Get.off(() => VendorVerifyOtp(phone: phoneNo, userId: data['user_id'],));
      Get.snackbar('OTP', 'Sent otp to attached email', titleText: Text('OTP', style: AppTheme.greenTitle,));
      // print( userStorage.read('email'));
      // print( userStorage.read('walletId'));
      // print( userStorage.read('walletBalance'));
      // print(userStorage.read('customerId'));

    } else if(data['error'] == 'Password is incorrect'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['error']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The password must be at least 8 characters.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The given password has appeared in a data leak.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    }  else if(data['message'] == null){
      isLoading(false);
      Fluttertoast.showToast(msg: 'Please sign up', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2,);
      // print(data);
    } else {
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      print(data);
      print('Failed API Login');
    }

    // Get.snackbar('Registered', 'Account Created Successfully');

  }

}