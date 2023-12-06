// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:wena_partners/professional/controller/forget_password_controller.dart';
import 'package:wena_partners/professional/controller/register_controller.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/utils/text.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var newPass = "";

  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<RegisterController>(
              id: 'register',
              init: RegisterController(),
              builder: (controller) {
                return controller.isHomeLoad == true?Center(child: CircularProgressIndicator()):
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 80),
                            child: Image.asset(
                              "assets/icons/icon_back.png",
                              height: 42,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: h * .035),
                          child: const Text(
                            createnewPasswordText,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Tahoma'),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: h * .015),
                          child: const Text(
                            pleaseEnterPassText,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF7B8295),
                              fontFamily: 'SEGOEUI',
                              height: 1.3,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        TextFormField(
                          controller: newpassword,
                          cursorColor: const Color(0xFF8391A1),
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE8ECF4),
                            prefix: const Icon(
                              Icons.cabin,
                              color: Colors.transparent,
                              size: 8,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF44336),
                              letterSpacing: 0.2,
                              fontFamily: 'SEGOEUI',
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            hintText: 'New Password',
                            hintStyle: const TextStyle(
                              color: Color(0xFF8391A1),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SEGOEUI',
                              fontSize: 14,
                              letterSpacing: 0.2,
                            ),
                          ),
                          validator: (value) {
                            newPass = value as String;
                            if (value.isEmpty) {
                              return 'Please enter new password';
                            }
                             else {
                                return null;
                              }
                          },
                        ),
                        SizedBox(height: 20),

                        TextFormField(
                          controller: confpassword,
                          cursorColor: const Color(0xFF8391A1),
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE8ECF4),
                            prefix: const Icon(
                              Icons.cabin,
                              color: Colors.transparent,
                              size: 8,
                            ),
                            errorStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF44336),
                              letterSpacing: 0.2,
                              fontFamily: 'SEGOEUI',
                            ),
                            contentPadding:
                            const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 3),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.6)),
                            hintText: 'Confirm password',
                            hintStyle: const TextStyle(
                              color: Color(0xFF8391A1),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SEGOEUI',
                              fontSize: 14,
                              letterSpacing: 0.2,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter confirm password';
                            } else {
                              if (newPass != value) {
                                return 'Please enter valid password';
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 45,
                        ),
                  GetBuilder<ForgetPassController>(
                      id: 'pass',
                      init: ForgetPassController(),
                      builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.ForgetPassword(password: newpassword.text);
                            }
                            // Get.to(PasswordChangedSuccessful());
                            // if (_formKey.currentState!.validate()) {
                            //   registerUser();
                            // }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: const Color(0xFF149C48),
                              child: Center(
                                child: controller.isLoadpass == true ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))) : Text(
                                  resetPasswordText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'SEGOEUI',
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }

  ///--------api calling--------------------

  registerUser() async {

    setState(() {
      // _isLoding=true;
    });

    print("Hello");

    String? tokenGet = await firebaseMessaging.getToken();

    print("TOKEN*****************************************$tokenGet");

    var request = http.MultipartRequest('POST',Uri.parse("${SERVER_ADDRESS}api/professional/professionalLogin"));

    print("-------------------Login_Api ${SERVER_ADDRESS}api/professional/professionalLogin");

    request.fields.addAll({
      // 'var_country_code': countryCode.toString(),
      // 'var_country_code': '91',
      // 'var_mobile_no':  phoneNo.toString(),
      'var_device_token': tokenGet.toString(),
    });

    // print("---------------------------var_country_code=${countryCode.toString()}");
    // print("---------------------------var_mobile_no=${phoneNo.text}");


    http.StreamedResponse response = await request.send();

    print("-----------hello");

    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());

      print("=============================Login_Response $jsonResponse");

      if (jsonResponse['code'] == 200) {


        // await SharedPreferences.getInstance().then((pref) {
        //   pref.setBool("isLoggedIn", true);
        //
        //   pref.setString("user_id", jsonResponse['data']['register']['id'].toString());
        //   pref.setString(AppConst.age, jsonResponse['data']['register']['age'].toString());
        //
        //   pref.getString(AppConst.age);
        //
        //
        //   print("AGE1212----------------------------${pref.getString(AppConst.age.toString())}");
        //
        //   print("======================USER_ID=============${jsonResponse['data']['register']['id'].toString()}");
        //
        //   // pref.setString("token", token.toString());
        // });
        ///----------------------
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OtpScreen(phoneNo.text.toString(),jsonResponse['data']['var_otp'])), (Route<dynamic> route) => false);
        ///----------------------
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen(phoneNo.text.toString(),jsonResponse['data']['var_otp'],)));
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBar()));

        // _isLoding=false;
      }
      else if(jsonResponse['code'] == 400){
        CircularProgressIndicator();
      }
    }
    else {
      setState(() {
        // _isLoding=false;
      });
      print(response.reasonPhrase);
    }
  }


}
