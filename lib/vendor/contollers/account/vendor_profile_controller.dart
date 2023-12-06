import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/services/network_handler.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/models/auth/register_vendor_model.dart';


class EditVendorController extends GetxController {

  var isLoading = false.obs;


  RxString newBusinessImagePath = ''.obs;
  RxString newNationalIdFrontPath = ''.obs;
  RxString newNationalIdBackPath = ''.obs;
  RxString newTradingLicensePath = ''.obs;
  RxString newNextOfKinNationalIdFrontPath = ''.obs;
  RxString newNextOfKinNationalIdBackPath = ''.obs;






  pickBusinessImage(ImageSource imageSource) async{

    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      newBusinessImagePath.value = pickedFile.path;

    } else{
      Fluttertoast.showToast(msg: 'No Business Image Picked', toastLength: Toast.LENGTH_LONG);
    }
  }

  pickNationalIdFront(ImageSource imageSource) async{

    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      newNationalIdFrontPath.value = pickedFile.path;

    } else{
      Fluttertoast.showToast(msg: 'No Front Image Picked', toastLength: Toast.LENGTH_LONG);
    }
  }

  pickNationalIdBack(ImageSource imageSource) async{

    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      newNationalIdBackPath.value = pickedFile.path;

    } else{
      Fluttertoast.showToast(msg: 'No Back Image Picked', toastLength: Toast.LENGTH_LONG);
    }
  }

  pickTradingLicense(ImageSource imageSource) async{

    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      newTradingLicensePath.value = pickedFile.path;

    } else{
      Fluttertoast.showToast(msg: 'No Trading License Image Picked', toastLength: Toast.LENGTH_LONG);
    }
  }

  pickNextOfKinNationalIdFront(ImageSource imageSource) async{

    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      newNextOfKinNationalIdFrontPath.value = pickedFile.path;

    } else{
      Fluttertoast.showToast(msg: 'No Front Image Picked', toastLength: Toast.LENGTH_LONG);
    }
  }

  pickNextOfKinNationalIdBack(ImageSource imageSource) async{

    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if(pickedFile != null){
      newNextOfKinNationalIdBackPath.value = pickedFile.path;

    } else{
      Fluttertoast.showToast(msg: 'No Back Image Picked', toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  void onInit() {
    // newFile = XFile('');

    super.onInit();
  }




  Future updateVendor( String businessName, dynamic nationalIdFront, dynamic nationalIdBack,
      dynamic tradingLicense, String businessPhoneNo, ) async {

    isLoading(true);

    // var fullUrl = 'https://admin.wenahardware.com/api/v1/register-store';
    // var fullUrl = 'http://staging.wenahardware.com/api/v1/register-store';
    // var fullUrl = 'https://staging.wenahardware.com/api/v1/update-store/${userStorage.read('storeId')}';
    var fullUrl = 'https://admin.wenahardware.com/api/v1/update-store/${userStorage.read('storeId')}';
    // final pickedFileBytes = await newFile.readAsBytes();
    final request = http.MultipartRequest('POST', Uri.parse(fullUrl));

    // request.fields['avator'] = businessImage.toString();
    request.fields['business_name'] = businessName;
    // request.fields['national_id_front'] = nationalIdFront.toString();
    // request.fields['national_id_back'] = nationalIdBack.toString();
    // request.fields['trading_license'] = tradingLicense.toString();
    request.fields['phone_no'] = businessPhoneNo;
    // request.fields['next_of_kin_national_id_front'] = nextOfKinNationalIdFront.toString();
    // request.fields['next_of_kin_national_id_back'] = nextOfKinNationalIdBack.toString();


    // var pic = await http.MultipartFile.fromBytes('avator', pickedFileBytes, filename: newFile.path.split('/').last);

    request.files.add(nationalIdFront);
    request.files.add(nationalIdBack);
    request.files.add(tradingLicense);
    request.headers.addAll({
      'Accept' : 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      // 'Content-type': 'multipart/form-data',

    });
    var response = await http.Response.fromStream(await request.send());
    // print(response.body);
    var data = json.decode(response.body);
    print(response);
    print(data);


    if(data['status'] == 'success'){
      isLoading(false);
      print(data);
      // Get.to(() => EmailVerifyOtp(userData: data['user'],));
      Get.snackbar('Updated Successfully', '${data['message']}');
      Get.back();

    } else {
      isLoading(false);
      print(data);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);

    }

    // Get.snackbar('Registered', 'Account Created Successfully');

  }



  loadButton() async{
    isLoading(true);
    await Future.delayed(const Duration(seconds: 5));
    isLoading(false);
  }


}