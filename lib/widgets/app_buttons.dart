import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';



class AppButton extends StatelessWidget {
  final Widget? loader;
  final String title;
  final Color color;
  final Color? loaderColor;
  final TextStyle? textStyle;
  final VoidCallback function;
  final bool? isLoading;
  final double? width;


  const AppButton({Key? key,  this.loader,required this.title, required this.color, required this.function, this.loaderColor, this.isLoading=false, this.width, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Bounceable(
      onTap: function,
      child: Container(
          width: 90.w,
          height: 6.h,
          decoration: BoxDecoration(
              color:  color,
              borderRadius: BorderRadius.circular(15.sp)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // loader ?? Container(),
              isLoading == true ?  SpinKitSpinningLines(
                color: loaderColor ?? Colors.white,
                size: 25.sp,
                lineWidth: 0.75.w,
                itemCount: 7,
              ) : Center(
                child: width == null ? Text(
                  title,
                  style: textStyle ?? AppTheme.whiteButtonText,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ) : Container(
                  color: Colors.transparent,
                  width: width,
                  child: Text(
                    title,
                    style: textStyle ?? AppTheme.whiteButtonText,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}


//
// class AppButton extends StatelessWidget {
//   final String title;
//   final Color color;
//   final TextStyle? textStyle;
//   final double? width;
//   final VoidCallback function;
//
//   const AppButton({Key? key, required this.title, required this.color, required this.function,  this.textStyle, this.width,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Bounceable(
//       onTap: function,
//       child: Container(
//         width: width ?? 90.w,
//         height: 6.h,
//         decoration: BoxDecoration(
//             color:  color,
//             borderRadius: BorderRadius.circular(15.sp)),
//         child: Center(
//           child: Text(
//             title,
//             style: textStyle ?? AppTheme.whiteButtonText ,
//             textAlign: TextAlign.center,
//           ),
//         )
//       ),
//     );
//   }
// }
