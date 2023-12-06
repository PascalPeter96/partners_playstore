import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:wena_partners/delivery/models/delivery_order.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/screens/job_details/nearby_delivery_jobs_details_screen.dart';
import 'package:wena_partners/delivery/widgets/nearby_jobs_widget.dart';

class AllDeliveryJobsScreen extends StatefulWidget {
  const AllDeliveryJobsScreen({Key? key}) : super(key: key);

  @override
  State<AllDeliveryJobsScreen> createState() => _AllDeliveryJobsScreenState();
}

class _AllDeliveryJobsScreenState extends State<AllDeliveryJobsScreen> {

  final nearbyJobs = NearbyJobs.nearbyJobs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: nearbyJobs.length,
            itemBuilder: (context, index){
              var nearbyJob = nearbyJobs[index];
              return Bounceable(
                onTap: (){
                  Get.to(() => NearbyDeliveryJobsDetailsScreen(nearbyJobs: nearbyJob));
                },
                  child: NearbyJobsWidget(nearbyJobs: nearbyJob));

            },),
        ],
      ),
    );
  }
}
