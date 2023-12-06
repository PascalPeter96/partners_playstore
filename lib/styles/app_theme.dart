import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/sizes.dart';
import 'package:wena_partners/theme/theme_service.dart';


import 'colors.dart';


class AppTheme{

  static Color get backgroundColor => const Color(0xfff5f5f5);

  static Color get primaryColor => const Color(0xff149c48);

  static Color get primaryLightColor => const Color(0xffc8edd9);

  static Color get subtitleTextColor => const Color(0xFF8391A1);

  static Color get inputBackground => const Color(0xffF7F8F9);

  static Color get fillColor => const Color(0xFFE8ECF4);

  static Color get fillColor2 => const Color(0xFFDADADA);

  static Color get priceColor => const Color(0xFF8391A1);

  static Color get greenColor2 => const Color(0xFF149C48);

  static Color get borderColor2 => const Color(0xFFE8EFF3);

  static Color get redFillColor2 => const Color(0xFFFF6464);

  static Color get warningTextColor => const Color(0xFFE5740B);
  
  static Color get redFillColor20 => const Color(0xFFFF6464).withOpacity(0.2);

  static Color get warningFillColor20 => const Color(0xFFE5740B).withOpacity(0.2);
  


  static TextStyle get greySmallSegoe => TextStyle(
    color: Colors.grey.shade500,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get greySmallTahoma => TextStyle(
    color: Colors.grey.shade300,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'TahomaBold',
  );

  static TextStyle get sectionMediumTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get greenSectionMediumTitle2 => TextStyle(
    // color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    color: AppTheme.primaryColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get sectionNormalText => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 16.sp,
    // fontWeight: FontWeight.w100,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get cardTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get blackCardTitle => TextStyle(
    color:  Colors.black,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get sectionNormalPrice => TextStyle(
    color: priceColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get sectionNormalPrice2 => TextStyle(
    color: priceColor,
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get sectionMediumBoldTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get sectionBigTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get whiteButtonText => TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get whiteButtonText2 => TextStyle(
    color: Colors.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get blackButtonText => TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get buttonText => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get buttonText2 => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.black : Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );



  static TextStyle get greenButtonText => TextStyle(
    color: AppTheme.primaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get sectionWhiteBigTitle => TextStyle(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get greenTitle => TextStyle(
    color: primaryColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get transparentText => const TextStyle(
    color: Colors.transparent,
  );

  static TextStyle get greenSectionTitle => TextStyle(
    color: greenColor2,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get warningButtonText => TextStyle(
    color: AppTheme.warningTextColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get cancelButtonText => TextStyle(
    color: AppTheme.redFillColor2,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get greenSectionTitle2 => TextStyle(
    color: greenColor2,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get lightGreenSectionTitle => TextStyle(
    color: Colors.green,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get greenNormal => TextStyle(
    color: greenColor2,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get whiteNormal => TextStyle(
    color: Colors.white,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );


  static TextStyle get subtitleSmall => TextStyle(
    color: subtitleTextColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );



  static TextStyle get appTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get largeAppTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 22.5.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get blackLargeAppTitle => TextStyle(
    color: Colors.black,
    fontSize: 22.5.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get introTitle => TextStyle(
    color: ThemeService().isSavedDarkMode() ? Colors.white : Colors.black,
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    fontFamily: 'SegoeUi',
  );

  static TextStyle get greenIntroSub => TextStyle(
    color: greenColor2,
    fontSize: 17.5.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );


  static TextStyle get greenWalletPrice => TextStyle(
    color: primaryColor,
    fontSize: 25.sp,
    fontWeight: FontWeight.w700,
    fontFamily: 'SegoeUi',
  );

  static TextStyle textTahomaColor292D32Size30 = TextStyle(
    color:  const Color(color292D32),
    fontSize: dimen30,
    fontWeight: FontWeight.w700,
    fontFamily: 'TahomaBold',
  );

  static TextStyle textSegoeUiColorContentSize16 = TextStyle(
    color:  const Color(colorContent),
    fontSize: dimen16,
    fontWeight: FontWeight.w600,
    fontFamily: 'SegoeUi',
  );

}