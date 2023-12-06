import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/screens/delivery_location/nearby_delivery_location_map_screen.dart';

class NearbyJobsWidget extends StatefulWidget {
  final NearbyJobs nearbyJobs;

  const NearbyJobsWidget({Key? key, required this.nearbyJobs}) : super(key: key);

  @override
  State<NearbyJobsWidget> createState() => _NearbyJobsWidgetState();
}

class _NearbyJobsWidgetState extends State<NearbyJobsWidget> {

  LatLng storeLocation = LatLng(0.3858431573515069, 32.65144595438129);


  late Distance distance;

  Dio dio  = new Dio();

  String storeTime = '';

  getTime(double lat, double long) async{
    var response = await dio.get(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=0.3858431573515069,32.65144595438129&destinations=$lat,$long&key=AIzaSyDBMJHAZDTZti1Y88i8TL-kmz_7qR9Tp5I'
    );

    String time = response.data['rows'][0]['elements'][0]['duration']['text'];

    setState((){
      storeTime = time;
    });

    print(storeTime);

    // await response.data['rows'][0]['elements'][0]['duration']['text'];

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    distance = new Distance();
  }

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
                Text('#${widget.nearbyJobs.orderId}', style: AppTheme.cardTitle, ),
                Bounceable(
                  onTap: (){
                    var km = distance.as(LengthUnit.Kilometer,
                        new LatLng(widget.nearbyJobs.latitude, widget.nearbyJobs.longitude), storeLocation);
                    Get.to(() => NearbyDeliveryLocationMapScreen(nearbyJobs: widget.nearbyJobs, userDistance: km));
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLightColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                          child: Text('ACCEPT', style: AppTheme.greenButtonText,),
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
                Text(DateFormat('E, d MMM yyyy').format(widget.nearbyJobs.date), style: AppTheme.subtitleSmall, ),
                Bounceable(
                  onTap: (){
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.redFillColor20,
                          borderRadius: BorderRadius.circular(15.sp)
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                          child: Text('REJECT', style: TextStyle(
                            color: AppTheme.redFillColor2,
                            fontSize: 15.sp
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
