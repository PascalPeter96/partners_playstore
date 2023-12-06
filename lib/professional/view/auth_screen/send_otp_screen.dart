// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, use_build_context_synchronously


import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:wena_partners/professional/controller/otp_controller.dart';
import 'package:wena_partners/professional/utils/text.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';




class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {

  final TextEditingController phoneNo = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final bool _validate = false;

  final bool _isLoding = false;

  String countryCode = "256";

  String errorText = "";

  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<OtpController>(
              id: 'sendOtp',
              init: OtpController(),
              builder: (controller) {
                return SingleChildScrollView(
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
                                    controller: phoneNo,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    decoration:  InputDecoration(
                                      // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                      contentPadding: EdgeInsets.only(right: 10),
                                      counterText: "",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: phoneNoText,
                                      hintStyle: TextStyle(color: Color(0xFF8391A1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                          if(errorText != "")
                            Text(errorText,style: TextStyle(color: Color(0xFFF44336),fontFamily: 'SEGOEUI',fontWeight: FontWeight.bold,fontSize: 13)),
                        SizedBox(
                          height: 40,
                        ),

                        GestureDetector(
                          onTap: () {

                            if(phoneNo.text.isEmpty){
                              setState(() {
                                errorText = "Enter the phone number";
                                // _validate = true;
                              });
                            }
                            else if(phoneNo.text.length != 10){
                              setState(() {
                                errorText = "Please enter 10 digit phone";
                                // _validate = true;
                              });
                            }
                            else{
                              // errorText = "";
                              // controller.SendOtp(mobileNo: phoneNo.text,countryCode: countryCode.replaceAll("+", ""));
                              Get.offAll(() => BottomBar());
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: const Color(0xFF149C48),
                              child: Center(
                                child: controller.isSendOtpLoad == true ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))):Text(
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

}
