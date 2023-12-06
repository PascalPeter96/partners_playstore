import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/view/auth_screen/signUp_screen.dart';
import 'package:wena_partners/professional/view/auth_screen/signning_screen.dart';
import 'package:wena_partners/professional/view/splacescreen.dart';
import 'package:wena_partners/professional/view/start_screen.dart';
import 'package:wena_partners/vendor/account/screens/login_screen.dart';
import 'package:wena_partners/vendor/account/screens/sign_up_screen.dart';
import 'package:wena_partners/vendor/account/screens/start_screen.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_phone_login.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_signup.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/app_title.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';

class VendorInitialScreen extends StatelessWidget {
  const VendorInitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              width: 50.w,
              title: 'Log In',
              color: AppTheme.primaryColor,
              function: () {
                // Get.to(() => ProStartScreen());
                Get.to(() => VendorPhoneLogin());
              },
            ),
            SizedBox(height: 3.h,),

            AppButton(
              width: 50.w,
              title: 'Sign Up',
              color: Colors.black,
              function: (){
                Get.to(() => VendorSignUpScreen());
              },
            ),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTitle(title: 'Vendor'),
          Center(
            child: Lottie.asset(
                'assets/lotties/vendor.json',
                height: 50.h
            ),
          ),
        ],
      ),

    );
  }
}
