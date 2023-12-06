import 'package:flutter/material.dart';
import 'package:wena_partners/delivery/models/delivery_order.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';
import 'package:wena_partners/delivery/widgets/nearby_jobs_widget.dart';
import 'package:wena_partners/delivery/widgets/recent_jobs_widget.dart';

class PendingRecentOrdersScreen extends StatefulWidget {
  const PendingRecentOrdersScreen({Key? key}) : super(key: key);

  @override
  State<PendingRecentOrdersScreen> createState() => _PendingRecentOrdersScreenState();
}

class _PendingRecentOrdersScreenState extends State<PendingRecentOrdersScreen> {

  final recentOrders = RecentJobs.recentJobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: recentOrders.length,
              itemBuilder: (context, index){
                var recentOrder = recentOrders[index];
                return recentOrder.deliveryStatus == 'PENDING' ? RecentJobsWidget(recentJobs: recentOrder) : Container();

              },),
          ),
        ],
      ),
    );
  }
}
