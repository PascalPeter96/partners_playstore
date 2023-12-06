import 'package:animate_do/animate_do.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/app_style/sizes.dart';
import 'package:wena_partners/vendor/contollers/auth/signin_vendor_controller.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_phone_otp.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_signup.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class VendorPhoneLogin extends StatefulWidget {
  const VendorPhoneLogin({Key? key}) : super(key: key);

  @override
  State<VendorPhoneLogin> createState() => _VendorPhoneLoginState();
}

class _VendorPhoneLoginState extends State<VendorPhoneLogin> {

  final SignInVendorController signInVendorController = Get.put(
      SignInVendorController());

  TextEditingController mobileCont = TextEditingController();
  String _countryCode = "+256";
  String _mobileError = "";

  final bool _isLoading = true;

  final countryPicker = const FlCountryCodePicker();
  late CountryCode countryCode;

  final _formKey = GlobalKey<FormState>();

  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'phone is required'),
    MinLengthValidator(9, errorText: 'phone number is short'),
    MaxLengthValidator(9, errorText: 'phone number has exceeded'),
  ]);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TitleAppBar(
          title: '',
          titleWidget: Container(width: 10.w,),
        ),
      ),

      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Don\'t have an account?', style: AppTheme.subtitleSmall,),
          SizedBox(
            width: 1.w,
          ),
          TextButton(
              onPressed: () {
                Get.off(() => VendorSignUpScreen());
              },
              child: Text('Register Now', style: AppTheme.greenNormal,)),

        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Started",
                    textAlign: TextAlign.start,
                    style: AppTheme.textTahomaColor292D32Size30,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Please enter your mobile number to log in. ",
                    style: AppTheme.textSegoeUiColorContentSize16,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  FadeInRight(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 90.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: TextFormField(
                        // maxLength: 9,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.phone,
                        controller: mobileCont,
                        validator: phoneValidator,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Bounceable(
                              onTap: () async {
                                final code = await countryPicker.showPicker(
                                    context: context);
                                setState(() {
                                  countryCode = code!;
                                });
                                print(countryCode);
                              },
                              child: Container(
                                width: 30.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    countryCode.flagImage,
                                    Container(
                                      child: Text(countryCode.dialCode),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_outlined),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppTheme.borderColor2,
                          hintText: 'Enter Your Phone',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: dimen20,
                  ),
                  // if (_mobileError != "")
                  //   Container(
                  //     child: Text(
                  //       _mobileError,
                  //       style: textSegoeUiColorRedSize16,
                  //     ),
                  //   ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: FadeInUp(
                      child: Obx(() {
                        return AppButton(
                          isLoading: signInVendorController.isLoading.value,
                          width: 50.w,
                          title: 'Continue',
                          color: AppTheme.primaryColor,
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              print('okay');
                              print(countryCode.dialCode);
                              print(mobileCont.text.trim());
                              print(countryCode.dialCode +
                                  mobileCont.text.trim());

                              signInVendorController.loginVendor(
                                  countryCode.dialCode.toString() +
                                      mobileCont.text.trim().toString());
                              // Get.off(() => VendorVerifyOtp(phone: countryCode.dialCode + mobileCont.text.trim()));
                            } else {
                              print('Failed');
                            }
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
