import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';

class LocationAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  const LocationAppBar({Key? key, this.title, this.titleWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {

                },
                child: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor,
                  child: Center(
                    child: Image.asset('assets/location.png'),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('Deliver to', style: AppTheme.sectionMediumTitle,),
                  Text(title ?? 'Kitoro, Entebbe' , style: AppTheme.sectionMediumTitle),
                ],
              ),
            ),
          ],
        ),
        titleWidget ?? const SizedBox(),
      ],
    );
  }
}
