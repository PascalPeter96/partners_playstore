import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/network_handler.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';
import 'package:wena_partners/vendor/models/auth/verify_otp_model.dart';
import 'package:get_storage/get_storage.dart';

class VerifyOtpController extends GetxController {

  var isLoading = false.obs;
  final userStorage = GetStorage();

  verifyOtp(String userId, String otp) async{
    isLoading(true);
    VerifyOtpModel verifyOtpModel =  VerifyOtpModel(userId: userId, otp: otp);
    var response = await NetworkHandler.post(verifyOtpModelToJson(verifyOtpModel), 'verify-partner-otp', '');

    var data = json.decode(response);
    print(data);

    if(data['status'] == 'success'){
      isLoading(false);
      // print(data);
      await userStorage.write('isVendorLoggedIn', true);
      await userStorage.write('vendorEmail', data['data']['user']['email']);
      await userStorage.write('vendorUserId', data['data']['user']['id']);
      await userStorage.write('vendorWalletId', data['data']['user']['wallet']['wallet_id']);
      await userStorage.write('vendorWalletBalance', data['data']['user']['wallet']['balance']);
      await userStorage.write('vendor', data['data']['user']);
      await userStorage.write('vendorName', data['data']['user']['store']['business_name']);
      await userStorage.write('vendorEmail', data['data']['user']['email']);
      await userStorage.write('vendorAvatar', data['data']['user']['avator_url']);
      await userStorage.write('vendorLicence', data['data']['user']['store']['trading_license']);
      await userStorage.write('vendorStartDate', data['data']['user']['store']['created_at']);
      await userStorage.write('vendorPhone', data['data']['user']['phone_no"']);
      await userStorage.write('vendorIdFront', data['data']['user']['store']['national_id_front']);
      await userStorage.write('vendorIdBack', data['data']['user']['store']['national_id_back']);
      await userStorage.write('vendorFirstName', data['data']['user']['store']['firstname']);
      await userStorage.write('vendorLastName', data['data']['user']['store']['surname']);
      await userStorage.write('vendorAccessToken', data['data']['access_token']);
      await userStorage.write('storeId', data['data']['user']['store']['store_id']);

        Get.offAll(() => DashboardScreen());

      Get.snackbar('Success', 'Logged In Successfully', titleText: Text('Success', style: AppTheme.greenTitle,));

    } else if(data['error'] == 'Verification code is either incorrect or has expired'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['error']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    }

    else {
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['error']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      print(data);
      print('Failed API Login');
    }

  }

}