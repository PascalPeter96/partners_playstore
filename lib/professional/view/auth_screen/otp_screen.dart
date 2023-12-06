// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/controller/otp_controller.dart';
import 'package:wena_partners/professional/utils/text.dart';
import 'package:wena_partners/professional/view/auth_screen/forget_password_screen.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';


class OtpScreen extends StatefulWidget {


  OtpScreen({Key? key}) : super(key: key);


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String otp = "";

  bool isError = false;

  final _formKey = GlobalKey<FormState>();



  final TextEditingController otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
    margin: EdgeInsets.all(10),
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15),
    ),
  );


  Id() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getString("user_id");
    print("USER_ID>>>>>>>>>>>>>>>>======================================>>>>>>>>>${sp.getString('user_id')}");
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Id();
  }
  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
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
                    otpText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        fontFamily: 'Tahoma'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * .015),
                  child: const Text(
                    getOtpText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF7B8295),
                      fontFamily: 'SEGOEUI',
                      height: 1.3),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                 GetBuilder<OtpController>(
                    id: 'otp',
                    init: OtpController(),
                    builder: (controller) {
                      return Pinput(
                        defaultPinTheme: defaultPinTheme,
                        validator: (s) {
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => controller.onSubmitOtp(otp: pin),
                      );
                    }
                 ),
                SizedBox(
                  height: 40,
                ),
                GetBuilder<OtpController>(
                    id: 'otp',
                    init: OtpController(),
                    builder: (controller) {
                      return
                        controller.isLoading?
                            Center(child: CircularProgressIndicator(color: Color(0xFF149C48),),)
                            :
                        GestureDetector(
                        onTap: (){
                         Get.offAll(() => BottomBar());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            color: const Color(0xFF149C48),
                            child: Center(
                              child: const Text(
                                verifyText,
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
        ),
      );
  }

  void box({errorMsg}) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          Icon(Icons.close,color: Colors.red,size: 50,),
          SizedBox(height: 15,),
          Text(
            'Wrong',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.red,
              fontFamily: 'SEGOEUI',
              height: 1.3,
            ),
          ),
          SizedBox(height: 15,),
          Text(
            errorMsg,
            style: TextStyle(
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


}
