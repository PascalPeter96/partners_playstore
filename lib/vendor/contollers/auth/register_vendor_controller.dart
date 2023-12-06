import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/services/network_handler.dart';
import 'package:wena_partners/vendor/models/auth/register_vendor_model.dart';


class RegisterVendorController extends GetxController {

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




  Future createNewVendor(String email, dynamic businessImage, String businessName, dynamic nationalIdFront, dynamic nationalIdBack,
      dynamic tradingLicense, String businessPhoneNo, String address, String firstName, String surname,
      dynamic accountName, dynamic accountNumber, dynamic bankName, dynamic mobileMoneyNumber, dynamic mobileMoneyNames,
      dynamic mobileMoneyProvider, String nextOfKinFirstname, String nextOfKinSurname, String nextOfKinPhoneNo,
      dynamic nextOfKinNationalIdFront, dynamic nextOfKinNationalIdBack, ) async {

    isLoading(true);

    // var fullUrl = 'https://admin.wenahardware.com/api/v1/register-store';
    var fullUrl = 'http://staging.wenahardware.com/api/v1/register-store';
    // var fullUrl = 'https://staging.wenahardware.com/api/v1/register-store';
    // final pickedFileBytes = await newFile.readAsBytes();
    final request = http.MultipartRequest('POST', Uri.parse(fullUrl));

    request.fields['email'] = email;
    // request.fields['avator'] = businessImage.toString();
    request.fields['business_name'] = businessName;
    // request.fields['national_id_front'] = nationalIdFront.toString();
    // request.fields['national_id_back'] = nationalIdBack.toString();
    // request.fields['trading_license'] = tradingLicense.toString();
    request.fields['phone_no'] = businessPhoneNo;
    request.fields['address'] = address;
    request.fields['firstname'] = firstName;
    request.fields['surname'] = surname;
    request.fields['account_name'] = accountName;
    request.fields['account_number'] = accountNumber;
    request.fields['bank_name'] = bankName;
    request.fields['mobile_money_number'] = mobileMoneyNumber;
    request.fields['mobile_money_names'] = mobileMoneyNames;
    request.fields['mobile_money_provider'] = mobileMoneyProvider;
    request.fields['next_of_kin_firstname'] = nextOfKinFirstname;
    request.fields['next_of_kin_surname'] = surname;
    request.fields['next_of_kin_phone_no'] = nextOfKinPhoneNo;
    // request.fields['next_of_kin_national_id_front'] = nextOfKinNationalIdFront.toString();
    // request.fields['next_of_kin_national_id_back'] = nextOfKinNationalIdBack.toString();


    // var pic = await http.MultipartFile.fromBytes('avator', pickedFileBytes, filename: newFile.path.split('/').last);
    request.files.add(businessImage);
    request.files.add(nationalIdFront);
    request.files.add(nationalIdBack);
    request.files.add(tradingLicense);
    request.files.add(nextOfKinNationalIdFront);
    request.files.add(nextOfKinNationalIdBack);
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
      Get.snackbar('Verify OTP', '${data['message']}');

    } else if(data['message'] == 'The email has already been taken.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The password must be at least 8 characters.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The given password has appeared in a data leak.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The address field is required.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else {
      isLoading(false);
      print(data);
      print('Failed API Login');
      Fluttertoast.showToast(msg: '${data['message']}', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);

    }

    // Get.snackbar('Registered', 'Account Created Successfully');

  }

  addVendor(String email, dynamic businessImage, String businessName, dynamic nationalIdFront, dynamic nationalIdBack,
      dynamic tradingLicense, String businessPhoneNo, String address, String firstName, String surname,
      dynamic accountName, dynamic accountNumber, dynamic bankName, dynamic mobileMoneyNumber, dynamic mobileMoneyNames,
      dynamic mobileMoneyProvider, String nextOfKinFirstname, String nextOfKinSurname, String nextOfKinPhoneNo,
      dynamic nextOfKinNationalIdFront, dynamic nextOfKinNationalIdBack, ) async {

    isLoading(true);

    RegisterVendorModel registerVendorModel = RegisterVendorModel(email: email, avator: businessImage,
        businessName: businessName, nationalIdFront: nationalIdFront, nationalIdBack: nationalIdBack,
        tradingLicense: tradingLicense, phoneNo: businessPhoneNo, address: address, firstname: firstName,
        surname: surname, accountName: accountName, accountNumber: accountNumber, bankName: bankName,
        mobileMoneyNumber: mobileMoneyNumber, mobileMoneyNames: mobileMoneyNames,
        mobileMoneyProvider: mobileMoneyProvider, nextOfKinFirstname: nextOfKinFirstname,
        nextOfKinSurname: nextOfKinSurname, nextOfKinPhoneNo: nextOfKinPhoneNo,
        nextOfKinNationalIdFront: nextOfKinNationalIdFront, nextOfKinNationalIdBack: nextOfKinNationalIdBack);

    var response = await NetworkHandler.post(registerVendorModelToJson(registerVendorModel), 'register-store', '');
    var data = json.decode(response);
    print(response);
    print(data);

    if(data['status'] == 'success'){
      isLoading(false);
      print(data);
      Get.back();
      // Get.to(() => EmailVerifyOtp(userData: data['user'],));
      Get.snackbar('Verify OTP', '${data['message']}');

    } else if(data['message'] == 'The email has already been taken.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The password must be at least 8 characters.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The given password has appeared in a data leak.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else if(data['message'] == 'The address field is required.'){
      isLoading(false);
      Fluttertoast.showToast(msg: '${data['message']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);
      // print(data);
    } else {
      isLoading(false);
      print(data);
      print('Failed API Login');
      Fluttertoast.showToast(msg: '${data['message']}', backgroundColor: Colors.black, textColor: AppTheme.redFillColor2);

    }

  }

  loadButton() async{
    isLoading(true);
    await Future.delayed(const Duration(seconds: 5));
    isLoading(false);
  }


}