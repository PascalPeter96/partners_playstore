import 'package:flutter/material.dart';
import 'package:wena_partners/app_style/colors.dart';
import 'package:wena_partners/app_style/sizes.dart';


class AppBack extends StatelessWidget {
  const AppBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
            padding: EdgeInsets.only(
                left: dimen12,
                right: 5.0,
                bottom: dimen08,
                top: dimen08),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color: const Color(colorE8ECF4)),
                borderRadius: BorderRadius.all(
                    Radius.circular(dimen10))),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: dimen24,
            )));
  }
}
