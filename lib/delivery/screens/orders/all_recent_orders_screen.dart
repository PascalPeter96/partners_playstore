import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:wena_partners/delivery/models/delivery_order.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';
import 'package:wena_partners/delivery/screens/order_details/recent_delivery_order_details_screen.dart';
import 'package:wena_partners/delivery/widgets/nearby_jobs_widget.dart';
import 'package:wena_partners/delivery/widgets/recent_jobs_widget.dart';

class AllRecentOrdersScreen extends StatefulWidget {
  const AllRecentOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllRecentOrdersScreen> createState() => _AllRecentOrdersScreenState();
}

class _AllRecentOrdersScreenState extends State<AllRecentOrdersScreen> {

  final recentOrders = RecentJobs.recentJobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: recentOrders.length,
            itemBuilder: (context, index){
              var recentOrder = recentOrders[index];
              return Bounceable(
                onTap: (){
                  Get.to(() => RecentDeliveryOrderDetailsScreen(recentJobs:  recentOrder,));
                },
                  child: RecentJobsWidget(recentJobs: recentOrder));

            },),
        ],
      ),
    );
  }
}
