import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';


import 'colors.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "SegoeUi",
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: const Color(colorPrimary),
    canvasColor: const Color(colorPrimary),
    scaffoldBackgroundColor: const Color(colorPrimary),
    cardColor: const Color(0xFFFFFFFF),
    dividerColor: const Color(0x1f6D42CE),
    focusColor: const Color(0x1aF5E0C3),
    appBarTheme: _appBarTheme());

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Colors.black,
      toolbarTextStyle: TextStyle(color: Colors.black));
}

TextStyle textTahomaBlackSize40 = TextStyle(
  color: Colors.black,
  fontSize: dimen30,
  fontWeight: FontWeight.w700,
  fontFamily: 'TahomaBold',
);

TextStyle textTahomaColor292D32Size30 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen30,
  fontWeight: FontWeight.w700,
  fontFamily: 'TahomaBold',
);

TextStyle textTahomaBlackSize30 = TextStyle(
  color: Colors.black,
  fontSize: dimen30,
  fontWeight: FontWeight.w700,
  fontFamily: 'TahomaBold',
);

TextStyle textTahomaBlackSize20 = TextStyle(
  color: Colors.black,
  fontSize: dimen20,
  fontWeight: FontWeight.w700,
  fontFamily: 'TahomaBold',
);

TextStyle textTahomaBlackSize16 = TextStyle(
  color: Colors.black,
  fontSize: dimen16,
  fontWeight: FontWeight.w700,
  fontFamily: 'TahomaBold',
);

TextStyle textSegoeUiColorContentSize16 = TextStyle(
  color: const Color(colorContent),
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorContentSize20 = TextStyle(
  color: const Color(colorContent),
  fontSize: dimen20,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorContentSize16Bold = TextStyle(
  color: const Color(colorContent),
  fontSize: dimen16,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorContentSize14 = TextStyle(
  color: const Color(colorContent),
  fontSize: dimen14,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorContentSize14Light = TextStyle(
  color: const Color(colorContent),
  fontSize: dimen14,
  fontWeight: FontWeight.w400,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorContentSize16Light = TextStyle(
  color: const Color(colorContent),
  fontSize: dimen16,
  fontWeight: FontWeight.w400,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorBlackSize16 = TextStyle(
  color: Colors.black,
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorBlackSize17 = TextStyle(
  color: Colors.black,
  fontSize: dimen17,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiColor303733Size16 = TextStyle(
  color: const Color(color303733),
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor303733Size18 = TextStyle(
  color: const Color(color303733),
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorBlackSize18Bold = TextStyle(
  color: Colors.black,
  fontSize: dimen18,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorBlackSize30 = TextStyle(
  color: Colors.black,
  fontSize: dimen30,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor1E232CSize22 = TextStyle(
  color: const Color(color1E232C),
  fontSize: dimen22,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorRedSize16 = TextStyle(
  color: Colors.red,
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorRedSize14 = TextStyle(
  color: Colors.red,
  fontSize: dimen14,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiWhiteSize14 = TextStyle(
  color: Colors.white,
  fontSize: dimen14,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiWhiteSize16 = TextStyle(
  color: Colors.white,
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);
TextStyle textGilroyWhiteSize16Bold = TextStyle(
  color: Colors.white,
  fontSize: dimen16,
  fontFamily: 'Gilroy-bold',
);
TextStyle textGilroyWhiteSize14 = TextStyle(
  color: Colors.white,
  fontSize: dimen14,
  height: 1.5,
  fontFamily: 'Gilroy-light',
);

TextStyle textGilroyTransparentSize14 = TextStyle(
  color: Colors.transparent,
  fontSize: dimen14,
  height: 1.5,
  fontFamily: 'Gilroy-light',
);

TextStyle textSegoeUiColor292D32Size18 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size16 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size20 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen20,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size16Light = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen16,
  fontWeight: FontWeight.w400,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size18Light = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen18,
  fontWeight: FontWeight.w400,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiColor161616Size20 = TextStyle(
  color: const Color(color161616),
  fontSize: dimen20,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor161616Size16 = TextStyle(
  color: const Color(color161616),
  fontSize: dimen16,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor161616Size18 = TextStyle(
  color: const Color(color161616),
  fontSize: dimen18,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorBlackSize18 = TextStyle(
  color: Colors.black,
  fontSize: dimen18,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorBlackSize20 = TextStyle(
  color: Colors.black,
  fontSize: dimen20,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiColorBlackSize20Bold = TextStyle(
  color: Colors.black,
  fontSize: dimen20,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorLightRedSize18 = TextStyle(
  color: const Color(colorLightRed),
  fontSize: dimen18,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorOpacityLightRedSize14 = TextStyle(
  color: const Color(colorLightRed).withOpacity(0.5),
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorOpacityLightGreenSize14 = TextStyle(
  color: const Color(colorSecondary).withOpacity(0.5),
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorLightRedSize16 = TextStyle(
  color: const Color(colorLightRed),
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiColorSecondarySize18 = TextStyle(
  color: const Color(colorSecondary),
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorSecondarySize16 = TextStyle(
  color: const Color(colorSecondary),
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorSecondarySize14 = TextStyle(
  color: const Color(colorSecondary),
  fontSize: dimen14,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiColorBlueSize18 = TextStyle(
  color: Colors.blue,
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorSecondarySize16Bold = TextStyle(
  color: const Color(colorSecondary),
  fontSize: dimen16,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);
TextStyle textSegoeUiColorE5740BSize16 = TextStyle(
  color: const Color(colorE5740B),
  fontSize: dimen16,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor4C5967Size18 = TextStyle(
  color: const Color(color4C5967),
  fontSize: dimen18,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size32 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen32,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size34 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen34,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColorSecondarySize34 = TextStyle(
  color: const Color(colorSecondary),
  fontSize: dimen34,
  fontWeight: FontWeight.w600,
  fontFamily: 'SegoeUi',
);

TextStyle textSegoeUiColor292D32Size24 = TextStyle(
  color: const Color(color292D32),
  fontSize: dimen24,
  fontWeight: FontWeight.w700,
  fontFamily: 'SegoeUi',
);
