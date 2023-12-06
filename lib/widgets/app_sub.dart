import 'package:flutter/material.dart';
import 'package:wena_partners/app_style/app_theme.dart';



class AppSub extends StatelessWidget {
  final String sub;
  final TextStyle? txtStyle;
  const AppSub({Key? key, required this.sub, this.txtStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sub,
      style: AppTheme.textSegoeUiColorContentSize16,
    );
  }
}
