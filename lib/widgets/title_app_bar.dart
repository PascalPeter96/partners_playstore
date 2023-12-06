import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/app_style/colors.dart';
import 'package:wena_partners/app_style/sizes.dart';


class TitleAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  const TitleAppBar({Key? key, this.title, this.titleWidget, this.leadingWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingWidget ?? GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
                padding: EdgeInsets.only(
                    left: 3.w,
                    right: 1.w,
                    bottom: 1.h,
                    top: dimen08),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: const Color(colorE8ECF4)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(15.sp))),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: dimen24,
                ))),
        Text(title ?? '' , style: AppTheme.sectionMediumBoldTitle),
        titleWidget ?? const SizedBox(),
      ],
    );
  }
}
