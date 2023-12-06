import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/app_style/sizes.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/app_sub.dart';
import 'package:wena_partners/widgets/app_title.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class ProfessionalVerifyOtp extends StatefulWidget {
  final String phone;
  const ProfessionalVerifyOtp({Key? key, required this.phone}) : super(key: key);

  @override
  State<ProfessionalVerifyOtp> createState() => _ProfessionalVerifyOtpState();
}

class _ProfessionalVerifyOtpState extends State<ProfessionalVerifyOtp> {

  final formKey = GlobalKey<FormState>();
  TextEditingController p1 = TextEditingController();


  String p1Error = '';

  String correctOtp = '4321';


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      bottomNavigationBar: SizedBox(
        height: 10.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const AppSub(sub: 'Didn\'t get the code'),
            TextButton(

              onPressed: (){
                Fluttertoast.showToast(msg: 'OTP Resent',backgroundColor: AppTheme.primaryColor);
              },
              child: Text('Resend ?',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),)
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TitleAppBar(
        ),

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: dimen05, top: dimen05),
                    child: const AppTitle(title: 'Verification'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: dimen05, top: dimen05),
                    child:  AppSub(sub: 'Enter verification code sent to your mobile number ${widget.phone}'),
                  ),
                  FadeInRight(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Pinput(
                        controller: p1,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        validator: (otp){
                          return null;


                        },
                        defaultPinTheme: PinTheme(
                          height: 10.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppTheme.borderColor2,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          textStyle: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        errorPinTheme: PinTheme(
                          height: 10.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: AppTheme.borderColor2,
                            borderRadius: BorderRadius.circular(20.sp),
                            border: Border.all(
                              color: Colors.red, width: 2,
                            ),
                          ),
                          textStyle: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  FadeInUp(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: AppButton(
                          title: 'Verify',
                          color: AppTheme.primaryColor,
                          function: (){

                            if(correctOtp == p1.text){
                              Get.snackbar('Welcome', 'Logged In Successfully');
                              Get.offAll(() => BottomBar());
                            } else {
                              Fluttertoast.showToast(msg: 'Invalid OTP', backgroundColor: Colors.red);
                            }

                          }),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
