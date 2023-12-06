import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';


class ProAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  const ProAppBar({Key? key, this.title, this.titleWidget}) : super(key: key);

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
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Image.asset('assets/location.png', color: Colors.black,),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, Aine Owomukama', style: AppTheme.sectionMediumTitle,),
                  Row(
                    children: [
                      Text(title ?? 'Kitoro, Entebbe' , style: AppTheme.sectionMediumBoldTitle),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Image.asset('assets/ddown.png', color: Colors.black,),
                      ),
                    ],
                  ),
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
