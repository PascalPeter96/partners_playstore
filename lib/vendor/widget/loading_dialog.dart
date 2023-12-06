import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wena_partners/vendor/config/app_colors.dart';


void showLoadingDialog() {
  Future.delayed(const Duration(seconds: 0), () {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const CircularProgressIndicator(
                  strokeWidth: 1.0,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.whiteColor,
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  });
}

Widget wenaLoading() {
  Future.delayed(const Duration(seconds: 0), () {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const CircularProgressIndicator(
                  strokeWidth: 1.0,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.whiteColor,
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 24,
                width: 24,
              ),
            ],
          ),
        ),
      ),
    );
  });

  throw Exception('');

}

void hideLoadingDialog() {
  Get.back();
}
