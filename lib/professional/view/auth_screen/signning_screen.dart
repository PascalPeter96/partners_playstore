// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:wena_partners/professional/controller/register_controller.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/utils/text.dart';
import 'package:wena_partners/professional/view/auth_screen/otp_screen.dart';
import 'package:wena_partners/professional/view/auth_screen/send_otp_screen.dart';
import 'package:wena_partners/professional/view/auth_screen/signUp_screen.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';


class SignScreen extends StatefulWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {


  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  bool _validate = false;

  bool _isLoding = false;

  bool isObscureText = true;


  String countryCode = "256";



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
                            getStartedText,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                fontFamily: 'Tahoma'),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: h * .015),
                          child: const Text(
                            pleaseEnterText,
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

                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE8ECF4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey)
                          ),
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CountryCodePicker(
                                  countryFilter: const ["UG","KE"],
                                  textStyle: const TextStyle(color: Color(0xFf8391A1)),
                                  onInit: (value) => "256",
                                  initialSelection: '256',
                                  dialogSize: const Size.fromWidth(330),
                                  onChanged: (value) {
                                    setState(() {
                                      countryCode = value.dialCode!;
                                      print('codesign====${value.dialCode}');
                                    });
                                  },
                                  flagDecoration: BoxDecoration(
                                    color: const Color(0xFF8391A1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  flagWidth: 40,
                                  padding: const EdgeInsets.all(0),
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),

                                const VerticalDivider(
                                  indent: 7,
                                  endIndent: 7,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                // const Center(child: Text("Enter your Phone", style: TextStyle(color: Color(0xFF8391A1),fontSize: 16,fontFamily: 'SEGOEUI')))
                                Expanded(
                                  child: TextFormField(
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
                                    controller: phoneNo,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration:  InputDecoration(
                                      counterText: '',
                                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                      contentPadding: EdgeInsets.only(right: 10),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: phoneNoText,
                                      hintStyle: TextStyle(color: Color(0xFF8391A1)),
                                    ),
                                    // validator: (value) {
                                    //   if (value!.isEmpty || value == null) {
                                    //     return 'Please enter phone';
                                    //   } else {
                                    //     if (value.length != 10) {
                                    //       return 'Please enter 10 digit phone';
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   }
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        if(_validate)
                        if(phoneNo.text.isEmpty)
                        Text(enterTheNoText,style: TextStyle(color: Color(0xFFF44336),fontFamily: 'SEGOEUI',fontWeight: FontWeight.bold,fontSize: 13)),
                        // if(_validate)
                        // if(phoneNo.text.length != 10)
                        // Text("Enter 10 digit phone number",style: TextStyle(color: Color(0xFFF44336),fontFamily: 'SEGOEUI',fontWeight: FontWeight.bold,fontSize: 13),),
                        SizedBox(height: 20),

                        TextFormField(
                          controller: password,
                          cursorColor: const Color(0xFF8391A1),
                          obscureText: isObscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE8ECF4),
                            prefix: const Icon(
                              Icons.cabin,
                              color: Colors.transparent,
                              size: 8,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isObscureText = !isObscureText;
                                    });
                                  },
                                  child: Icon(isObscureText?Icons.visibility_off:Icons.visibility,color: const Color(0xFF8391A1),)),
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
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Color(0xFF8391A1),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SEGOEUI',
                              fontSize: 14,
                              letterSpacing: 0.2,
                            ),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Enter your password';
                          //   }
                          //   return null;
                          // },
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter case sensitive \nPassword must contain special character \nPassword must contain number';
                              } else {
                                return null;
                              }
                            }
                            // if (value == null || value.isEmpty ||!regex.hasMatch(value)) {
                            //   return 'password  is invalid. Enter case sensitive';
                            // }
                            // return null;
                          },
                        ),


                        SizedBox(
                          height: 10,
                        ),
                        // _validate?Text(enterTheNoText,style: TextStyle(color: Color(0xFFF44336),fontFamily: 'SEGOEUI',fontWeight: FontWeight.bold),):Container(),
                        SizedBox(
                          height: 45,
                        ),

                        GestureDetector(
                          onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Get.to(() => OtpScreen());
                          }
                            // phoneNo.text.isEmpty ? _validate = true : _validate = false;
                            if(phoneNo.text.isEmpty || phoneNo.text.length!= 10){
                              setState(() {
                                _validate = true;
                              });
                            }

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: const Color(0xFF149C48),
                              child: Center(
                                child: _isLoding?CircularProgressIndicator(color: Colors.white,strokeWidth: 2,): Text(
                                  continueText,
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
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              accountText,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'SEGOEUI',
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 8),
                            InkWell(onTap: (){
                              Get.to(SignUpScreen());
                            },child: Text(
                              registerText,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF149C48),
                                fontFamily: 'SEGOEUI',
                                letterSpacing: 0.3,
                              ),
                            ),),
                          ],
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Get.to(SendOtpScreen());
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: const Color(0xFF149C48),
                              child: Center(
                                child: Text(
                                  forgetPassText,
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
                        ),
                        // Container(
                        //   alignment: Alignment.topRight,
                        //   child: InkWell(onTap: (){
                        //     Get.to(SendOtpScreen());
                        //   },child: Text(
                        //     forgetPassText,
                        //     style: TextStyle(
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 15,
                        //       color: Colors.black,
                        //       fontFamily: 'SEGOEUI',
                        //       letterSpacing: 0.3,
                        //     ),
                        //   ),),
                        // ),
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
        _isLoding=true;
      });

      print("Hello");

      String? tokenGet = await firebaseMessaging.getToken();

      print("TOKEN*****************************************$tokenGet");

      var request = http.MultipartRequest('POST',Uri.parse("${SERVER_ADDRESS}api/professional/professionalLogin"));

      print("-------------------Login_Api ${SERVER_ADDRESS}api/professional/professionalLogin");

      request.fields.addAll({
        'var_country_code': countryCode.toString(),
        // 'var_country_code': '91',
        'var_mobile_no':  phoneNo.text,
        'var_device_token': tokenGet.toString(),
        "var_password": password.text
      });

      print("---------------------------var_country_code=${countryCode.toString()}");
      print("---------------------------var_mobile_no=${phoneNo.text}");


      http.StreamedResponse response = await request.send();

      print("-----------hello");

      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(await response.stream.bytesToString());

        print("=============================Login_Response $jsonResponse");

          if (jsonResponse['code'] == 200) {

            await SharedPreferences.getInstance().then((pref) {


              pref.setString("user_id", jsonResponse['data']['int_glcode'].toString());
            });

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
            Get.to(BottomBar());
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomBar()));

          _isLoding=false;
        }
        else if(jsonResponse['code'] == 400){
          AppToast.showToast(jsonResponse['msg']);
          setState(() {
            _isLoding=false;
          });
          // CircularProgressIndicator();
        }
      }
      else {
        setState(() {
          _isLoding=false;
        });
        print(response.reasonPhrase);
      }
    }
}
