
import 'package:flutter/material.dart';
import 'package:wena_partners/app_style/app_theme.dart';



class AppTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  const AppTitle({Key? key, required this.title, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: AppTheme.textTahomaColor292D32Size30,
    );
  }
}
