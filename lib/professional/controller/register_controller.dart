// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';

class RegisterController extends GetxController{

  ///------model class name------------


  ///-------bool var------------------

  bool isHomeLoad = false;

  bool validate = false;

  bool isLoding = false;

  ///------empty list-----------------


  // @override
  // onInit() {
  //   super.onInit();
  // }

  loading(value) {
    isHomeLoad = value;
    validate = value;
    isLoding = value;
    update(['register']);
  }

  ///-------------post register  api---------------------------------

  Future loginUser({
    required String countryCode,
    required String phoneNo,
    required String tokenGet,
    required String pass,
    required BuildContext context,
  }) async {

    loading(true);

    String? tokenGet = await firebaseMessaging.getToken();

    print("TOKEN*****************************************$tokenGet");

    var request = http.MultipartRequest('POST',Uri.parse("${SERVER_ADDRESS}api/professional/professionalLogin"));

    print("-------------------register api ${SERVER_ADDRESS}api/professional/professionalLogin");

    request.fields.addAll({
      'var_country_code': countryCode.toString(),
      'var_mobile_no':  phoneNo.toString(),
      'var_device_token': tokenGet.toString(),
      'var_password': pass.toString(),
    });

    print("---------------------------var_country_code ${countryCode.toString()}");
    print("---------------------------var_mobile_no ${phoneNo.toString()}");
    print("---------------------------password ${pass.toString()}");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("=============================register $jsonResponse");

      if (jsonResponse['code'] == 200) {

        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("user_id", jsonResponse['data']['int_glcode'].toString());

        print("LOGIN_SCREEN_USER_ID_SET------------${sp.getString("user_id")}");

        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OtpScreen(phoneNo.toString(),jsonResponse['data']['var_otp'])), (Route<dynamic> route) => false);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BottomBar()), (Route<dynamic> route) => false);

        loading(false);
      }
      else if(jsonResponse['code'] == 400){

        box('Invalid Mobile Number or Password!');
        loading(false);
        // const CircularProgressIndicator();
      }
    }
    else {
      loading(false);
      print(response.reasonPhrase);
      box(response.reasonPhrase);
    }
  }
}


void box(error) {
  Get.defaultDialog(
    title: '',
    content:  Column(
      children:  [
        const Icon(Icons.close,color: Colors.red,size: 50,),
        const SizedBox(height: 15,),
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
        const SizedBox(height: 15,),
        Text(
          // 'Invalid Mobile Number or Password!',
          '$error',
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
          onPressed: (){
            Get.back();
            // Get.back();
            // Get.delete<MyProjectController>();
            // Get.off(const SignScreen());
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