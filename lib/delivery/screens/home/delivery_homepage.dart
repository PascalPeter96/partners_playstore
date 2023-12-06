
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/delivery_order.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';
import 'package:wena_partners/delivery/screens/account/notifications_screen.dart';
import 'package:wena_partners/delivery/screens/job_details/nearby_delivery_jobs_details_screen.dart';
import 'package:wena_partners/delivery/screens/order_details/recent_delivery_order_details_screen.dart';
import 'package:wena_partners/delivery/widgets/delivery_order_card.dart';
import 'package:wena_partners/delivery/widgets/nearby_jobs_widget.dart';
import 'package:wena_partners/delivery/widgets/recent_jobs_widget.dart';
import 'package:wena_partners/delivery/widgets/section_title_view.dart';
import 'package:wena_partners/widgets/app_sub.dart';
import 'package:wena_partners/widgets/app_title.dart';

class DeliveryHomepage extends StatefulWidget {
  const DeliveryHomepage({Key? key}) : super(key: key);

  @override
  State<DeliveryHomepage> createState() => _DeliveryHomepageState();
}

class _DeliveryHomepageState extends State<DeliveryHomepage> {

  final orders = DeliveryOrder.orders;
  final nearbyJobs = NearbyJobs.nearbyJobs;
  final recentJobs = RecentJobs.recentJobs;
  final deliveryOrders = DeliveryOrder.orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w,),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTitle(title: 'Hello, Owomukama'),
                    Bounceable(
                      onTap: (){
                        Get.to(() => NotificationsScreen());
                      },
                      child: Container(
                        height: 4.h,
                          decoration: BoxDecoration(
                            // color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(color: AppTheme.borderColor2)
                          ),
                          child: Image.asset('assets/icons/bell.png',)),
                    ),
                  ],
                ),
                
                Text('Good Morning', style: AppTheme.sectionBigTitle,),
                AppSub(sub: '3 new shipments are available'),

                Swiper(
                  itemWidth: 82.5.w,
                  itemCount: deliveryOrders.length,
                  layout: SwiperLayout.STACK,
                  scrollDirection: Axis.horizontal,
                  loop: true,
                  viewportFraction: 0.1,
                  itemHeight: 19.h,
                  itemBuilder: (context, index){
                    var deliveryOrder = orders[index];
                    return  DeliveryOrderCard(deliveryOrder: deliveryOrder,);
                  },
                ),

                SectionTitleView(title: 'Nearby Jobs', function: (){}),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index){
                    var nearbyJob = nearbyJobs[index];
                     return Bounceable(
                         onTap: (){
                           Get.to(() => NearbyDeliveryJobsDetailsScreen(nearbyJobs: nearbyJob));
                         },
                         child: NearbyJobsWidget(nearbyJobs: nearbyJob));
                  },
                ),

                SectionTitleView(title: 'Recent Jobs', function: (){}),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index){
                    var recentJob = recentJobs[index];
                    return Bounceable(
                      onTap: (){
                        Get.to(() => RecentDeliveryOrderDetailsScreen(recentJobs: recentJob));
                      },
                        child: RecentJobsWidget(recentJobs: recentJob));
                  },
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
