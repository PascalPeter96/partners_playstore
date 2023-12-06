import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/auth/delivery_initial_screen.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/view/auth_screen/professional_initial_screen.dart';
import 'package:wena_partners/splash_screen.dart';
import 'package:wena_partners/vendor/account/screens/login_screen.dart';
import 'package:wena_partners/vendor/account/screens/start_screen.dart';
import 'package:wena_partners/vendor/account/screens/vendor_initial_screen.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/widgets/app_buttons.dart';

class InitialScreeen extends StatefulWidget {
  const InitialScreeen({Key? key}) : super(key: key);

  @override
  State<InitialScreeen> createState() => _InitialScreeenState();
}

class _InitialScreeenState extends State<InitialScreeen> {
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Image.asset('assets/images/logo.png',
            width: 100.w,
            height: 10.h,
          ),

          SizedBox(height: 5.h,),

          Lottie.asset(
            'assets/lotties/initial_lottie.json',
            height: 40.h,
          ),

          SizedBox(height: 3.h,),

         AppButton(
           width: 50.w,
             title: 'Vendor',
             color: AppTheme.primaryColor,
             function: (){
               // Get.to(() => StartScreen());
               Get.to(() => VendorInitialScreen());
               // Get.to(() => LoginScreen());
             },
         ),
          SizedBox(height: 3.h,),

          AppButton(
            width: 50.w,
            title: 'Delivery',
            color: Colors.grey.shade200,
            textStyle: AppTheme.blackButtonText,
            function: (){
              // Get.to(() => StartScreen());
              Get.to(() => DeliveryInitialScreen());
              // Get.to(() => LoginScreen());
            },
          ),

          SizedBox(height: 3.h,),

          AppButton(
            width: 50.w,
            title: 'Professional',
            color: Colors.black,
            function: (){
              Get.to(() => ProfessionalInitialScreen());
            },
          ),



        ],
      ),

    );
  }
}
