import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wena_partners/app_style/app_theme.dart';


class ThemeService {

  final lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      primaryColor: AppTheme.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green
    )
  );

  final darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      primaryColor: AppTheme.primaryColor,
      scaffoldBackgroundColor: const Color(0xFF000000),

  );

  final _getStorage = GetStorage();
  final _isDarkThemeKey = 'isDarkTheme';

  void saveThemeData(bool isDarkTheme) async {
    await _getStorage.write(_isDarkThemeKey, isDarkTheme);
  }

  bool isSavedDarkMode(){
    return _getStorage.read(_isDarkThemeKey) ?? false;
  }

  ThemeMode getThemeMode(){
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme(){
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }

}