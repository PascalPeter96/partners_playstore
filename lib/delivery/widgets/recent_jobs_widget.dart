import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';

class RecentJobsWidget extends StatelessWidget {
  final RecentJobs recentJobs;

  const RecentJobsWidget({Key? key, required this.recentJobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${recentJobs.orderId}', style: AppTheme.cardTitle, ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: recentJobs.deliveryStatus == 'PENDING' ? AppTheme.warningFillColor20
                         : recentJobs.deliveryStatus == 'CANCELED' ? AppTheme.redFillColor20 : AppTheme.primaryLightColor,
                        // borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                        child: Text(recentJobs.deliveryStatus,
                          style:  recentJobs.deliveryStatus == 'PENDING' ? AppTheme.warningButtonText :
                          recentJobs.deliveryStatus == 'CANCELED' ? AppTheme.cancelButtonText : AppTheme.greenButtonText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 0.5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('E, d MMM yyyy').format(recentJobs.date), style: AppTheme.subtitleSmall, ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
