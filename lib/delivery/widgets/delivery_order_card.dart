import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/delivery_order.dart';
import 'package:wena_partners/delivery/screens/location/delivery_location_screen.dart';

class DeliveryOrderCard extends StatelessWidget {
  final DeliveryOrder deliveryOrder;
  // final String name;
  // final String orderId;
  // final String date;
  // final String time;
  const DeliveryOrderCard({Key? key, required this.deliveryOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(deliveryOrder.name, style: AppTheme.cardTitle,),
                Bounceable(
                  onTap: () async{
                    final Uri phoneUri = Uri(
                        scheme: 'tel',
                        path: '${deliveryOrder.phone}'
                    );
                    if(await canLaunchUrl(phoneUri)){
                      await launchUrl(phoneUri);
                    } else {
                      print('Cannot make Call');
                    }
                  },
                  child: CircleAvatar(
                    radius: 17.5.sp,
                    backgroundColor: AppTheme.borderColor2,
                      child: Image.asset('assets/icons/icon_call.png', height: 3.h,)),
                )
              ],
            ),
            Text('Order ID: #${deliveryOrder.orderId}', style: AppTheme.sectionNormalPrice,),

            Padding(
              padding:  EdgeInsets.only(top: 1.h, ),
              child: Row(
                children: [
                  Bounceable(
                    child: CircleAvatar(
                        backgroundColor: AppTheme.primaryColor,
                        child: Image.asset('assets/icons/location.png', height: 3.h,)),
                    onTap: (){
                      Get.to(() => DeliveryLocationScreen(deliveryOrder: deliveryOrder,));
                    },
                  ),
                  SizedBox(width: 5.w,),
                  Container(
                    height: 4.h,
                    width: 27.5.w,
                    decoration: BoxDecoration(
                      color: AppTheme.borderColor2,
                      borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: Center(child: Text(deliveryOrder.date, style: AppTheme.subtitleSmall,)),
                  ),
                  SizedBox(width: 5.w,),
                  Container(
                    height: 4.h,
                    width: 22.5.w,
                    decoration: BoxDecoration(
                      color: AppTheme.borderColor2,
                        borderRadius: BorderRadius.circular(15.sp)
                    ),
                    child: Center(child: Text(deliveryOrder.time, style: AppTheme.subtitleSmall,)),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
