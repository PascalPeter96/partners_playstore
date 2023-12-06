import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';

class SectionTitleView extends StatelessWidget {
  final String title;
  final VoidCallback function;
  const SectionTitleView({Key? key, required this.title, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTheme.sectionMediumBoldTitle,),
        GestureDetector(
          onTap: function,
          child: Row(
            children: [
              Text('View all', style: AppTheme.greenNormal,),
              Icon(Icons.arrow_forward_ios_outlined, color: AppTheme.primaryColor, size: 15.sp,),
            ],
          ),
        )
      ],
    );
  }
}
