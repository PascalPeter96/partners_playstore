import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/model/selected_professions_detail.dart';
import 'package:wena_partners/professional/view/auth_screen/otp_screen.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';

class OtpController extends GetxController {
  String? getotp;
  bool isSendOtpLoad = false;
  var fdata;


  SendOtpLoad(value) {
    isSendOtpLoad = value;
    update(['sendOtp']);
  }

  onSubmitOtp({otp}) {
    getotp = otp;
    print("getotp is====>>>$getotp");
    update(['otp']);
  }

  Future SendOtp({mobileNo, countryCode}) async {
    print("mobileNo====>>>$mobileNo");
    print("countryCode====>>>>$countryCode");
    SendOtpLoad(true);
    var headers = {'Cookie': 'PHPSESSID=a8c5a6af9d6a6869dabecb91fd04b114'};
    var request = http.MultipartRequest('POST',
        Uri.parse("${SERVER_ADDRESS}api/professional/generateOtpByMobileNo"));
    request.fields.addAll({
      'var_mobile_no': mobileNo.toString(),
      'var_country_code': countryCode.toString(),
      'var_type': 'F'
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      SendOtpLoad(false);
      print(response.body);
      String data = response.body;
      fdata = json.decode(data);
      print("send otp data is====>>>$data");
      if (fdata['code'] == 200) {
        Get.to(OtpScreen());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("professionalId", fdata['professionalId']);
      } else {
        box(errorMsg: fdata['msg']);
      }
      // joinCommuityModel = JoinCommuityModel.fromJson(json.decode(data));
      // joinCommuiry = joinCommuityModel!.data!;
      // print("professionsUnitList========>>>${joinCommuityModel!.msg}");
    } else {
      SendOtpLoad(false);
      print(response.reasonPhrase);
      box(errorMsg: response.reasonPhrase);
    }
  }

  void box({errorMsg}) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          const Icon(
            Icons.close,
            color: Colors.red,
            size: 50,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Wrong',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.red,
              fontFamily: 'SEGOEUI',
              height: 1.3,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            errorMsg,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
              fontFamily: 'SEGOEUI',
              height: 1.3,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )
      ],
    );
  }

  bool isLoading = false;

  loading(bool value) {
    isLoading = value;
    update(['otp']);
  }

  signUpApi(Map data) async {
    String firstName = data['firstName'];
    String surName = data['surName'];
    String email = data['email'];
    String countryCode = data['countryCode'];
    String phoneNo = data['phoneNo'];
    String getCity = data['getCity'];
    File? image = data['image'];
    File? image1 = data['image1'];
    File? image2 = data['image2'];
    String mode = data['mode'];
    String accountname = data['accountname'];
    String bankname = data['bankname'];
    String Bankcode = data['Bankcode'];
    String Branchname = data['Branchname'];
    String selectNetwork = data['selectNetwork'];
    String paymentPhoneNo = data['paymentPhoneNo'];
    String countryPhone = data['countryPhone'];
    String serviceId = data['serviceId'];
    List<SelectedProfessionsDetailClass> selectedProfessionDetailClass =
        data['selectedProfessionDetailClass'];
    BuildContext context = data['context'];
    String accountNumber = data['accountNumber'];
    String password = data['password'];

    List<String> professionDetailIds = [];

    for (int i = 0; i < selectedProfessionDetailClass.length; i++) {
      var data = selectedProfessionDetailClass[i];
      professionDetailIds.add('"${data.id}"');
    }

    String serviceDetail = '{';
    for (int i = 0; i < selectedProfessionDetailClass.length; i++) {
      var data = selectedProfessionDetailClass[i];
      serviceDetail +=
          '"${data.id}":{"fk_unit":${data.servicePer!.intGlcode},"var_price":${data.priceController.text}}${i == selectedProfessionDetailClass.length - 1 ? '' : ','}';
    }
    serviceDetail += '}';

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    print('var_fname : $firstName');
    print('var_lname : $surName');
    print('var_email : $email');
    print('var_country_code : $countryCode');
    print('var_mobile_no : $phoneNo');
    print('var_city : $getCity');
    print('fk_service_ids : $professionDetailIds');
    print('service_details : $serviceDetail');
    print('payment_mode : $mode');
    print('var_bank_account : $accountNumber');
    print('var_bank_name : $bankname');
    print('var_account_name : $accountname');
    print('var_bank_code : $Bankcode');
    print('var_bank_branch_name : $Branchname');
    print('fk_network_id : ${1}');
    print('var_mobile_money_mobile_no : $paymentPhoneNo');
    print('var_reg_mobile_money_mobile_no : $countryPhone');
    print('device_id : $token');
    print('var_password : $password');
    // print('var_image : ${image!.path}');
    // print('var_national_id_front : ${image1!.path}');
    // print('var_national_id_back : ${image2!.path}');

    loading(true);

    var request = http.MultipartRequest('POST',
        Uri.parse("${SERVER_ADDRESS}api/professional/professional_signup"));

    print(
        "-------------------Signup_Api ${SERVER_ADDRESS}api/professional/professional_signup");

    Map<String, String> body = {
      'var_fname': firstName,
      'var_lname': surName,
      'var_email': email,
      'var_country_code': countryCode,
      'var_mobile_no': phoneNo,
      'var_city': getCity,
      'fk_service_ids': professionDetailIds.toString(),
      'service_details': serviceDetail,
      'payment_mode': mode,
      'var_bank_account': accountNumber,
      'var_bank_name': bankname,
      'var_account_name': accountname,
      'var_bank_code': Bankcode,
      'var_bank_branch_name': Branchname,
      'fk_network_id': '1',
      'var_mobile_money_mobile_no': paymentPhoneNo,
      'var_reg_mobile_money_mobile_no': countryPhone,
      'device_id': token,
      'var_password': password,
    };

    print('after body service id is $professionDetailIds');

    request.fields.addAll(body);

    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('var_image', image.path));
    }

    if (image1 != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'var_national_id_front', image1.path));
    }

    if (image2 != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'var_national_id_back', image2.path));
    }

    if (selectedProfessionDetailClass.isNotEmpty) {
      for (int i = 0; i < selectedProfessionDetailClass.length; i++) {
        var data = selectedProfessionDetailClass[i];
        professionDetailIds.add(data.id);
        request.files.add(await http.MultipartFile.fromPath(
            'var_certificate[${data.id}]', data.image!.path));
      }
    }

    http.StreamedResponse response = await request.send();

    print('sign up status code is : ${response.statusCode}');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("=============================Signup $jsonResponse");

      if (jsonResponse['code'] == 200) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("user_id", jsonResponse['data']['int_glcode'].toString());

        print(
            "REGISTER_SCREEN_USER_ID_SET------------${sp.getString("user_id")}");

        Get.to(const BottomBar());

        loading(false);
      } else if (jsonResponse['code'] == 400) {
        const CircularProgressIndicator();
      }
    } else {
      loading(false);
      print(response.reasonPhrase);
    }
  }
}
