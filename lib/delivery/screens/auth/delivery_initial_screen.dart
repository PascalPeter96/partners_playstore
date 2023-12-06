import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/auth/delivery_phone_login.dart';
import 'package:wena_partners/delivery/screens/auth/delivery_signup.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/app_title.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';
import 'package:animate_do/animate_do.dart';

class DeliveryInitialScreen extends StatelessWidget {
  const DeliveryInitialScreen({Key? key}) : super(key: key);

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
              title: 'Log In',
              color: AppTheme.primaryColor,
              function: (){
                Get.to(() => DeliveryPhoneLogin());
              },
            ),
            SizedBox(height: 3.h,),

            AppButton(
              title: 'Sign Up',
              color: Colors.black,
              function: (){
                // Get.snackbar('Sign Up', 'Use Log In to Initiate');
                Get.to(() => DeliverySignUpScreen());
              },
            ),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          AppTitle(title: 'Delivery'),

          Center(
            child: SlideInLeft(
              child: Lottie.asset(
                'assets/lotties/delivery2.json',
                height: 50.h,
              ),
            ),
          ),

        ],
      ),

    );
  }
}
