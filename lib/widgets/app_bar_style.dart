import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarStyle extends StatelessWidget {
  const AppBarStyle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
