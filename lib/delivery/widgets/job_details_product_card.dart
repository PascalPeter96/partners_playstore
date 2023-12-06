import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';

class JobProductDetailsCard extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;
  const JobProductDetailsCard({Key? key, required this.name, required this.quantity, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTheme.cardTitle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Qty : ', style: AppTheme.subtitleSmall,) ,
                    Text(quantity.toString()),
                  ],
                ) ,
              ],
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.sp)
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.primaryLightColor,
                    borderRadius: BorderRadius.circular(15.sp)
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    child: Text('UGX $price', style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 15.sp
                    ),),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
