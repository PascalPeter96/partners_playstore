import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/delivery_order.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/app_sub.dart';
import 'package:wena_partners/widgets/app_title.dart';


class RecentOrderDeliveryLocationScreen extends StatefulWidget {
  final RecentJobs recentJobs;
  const RecentOrderDeliveryLocationScreen({Key? key, required this.recentJobs}) : super(key: key);

  @override
  State<RecentOrderDeliveryLocationScreen> createState() => _RecentOrderDeliveryLocationScreenState();
}

class _RecentOrderDeliveryLocationScreenState extends State<RecentOrderDeliveryLocationScreen> {

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(0.3858431573515069, 32.65144595438129),
    zoom: 15,
  );
  String? mapStyle;

  final Set<Marker> _markers = {};
  late BitmapDescriptor mapMarker;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }



  void setCustomMarker() async{
    final Uint8List markerIcon = await getBytesFromAsset('assets/marker.png', 100);
    mapMarker = BitmapDescriptor.fromBytes(markerIcon);
  }
  void _onMapCreated(GoogleMapController googleMapController){
    setState((){
      _markers.add(
        Marker(
          infoWindow: const InfoWindow(
              title: 'Wena Branch',
              snippet: 'Store location'
          ),
          icon: BitmapDescriptor.fromBytes(getBytesFromAsset('assets/marker.png', 100) as Uint8List),
          markerId: const MarkerId('id1'),
          position: const LatLng(0.3858431573515069, 32.65144595438129),
        ),
      );

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
    rootBundle.loadString('assets/map_style.txt').then((string){
      mapStyle = string;
    });
  }

  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            markers: _markers,
            onMapCreated: _onMapCreated,
            // onMapCreated: (GoogleMapController controller){
            //   googleMapController = controller;
            //   googleMapController!.setMapStyle(_mapStyle);
            // },
            initialCameraPosition: _kGooglePlex,

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: 25.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
                // color: Colors.red,
              ),
              child: Scaffold(
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
                  child: AppButton(
                      title: 'Completed',
                      color: AppTheme.primaryColor,
                      function: (){
                        Get.snackbar(
                            'Proceeding',
                            'Please wait..........',
                            snackPosition: SnackPosition.TOP
                        );
                      }
                  ),
                ),
                backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Container(
                        width: 12.5.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                            color: AppTheme.fillColor2,
                            borderRadius: BorderRadius.circular(10.sp)
                        ),
                      ),),


                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.sp)
                        ),
                        child: ListTile(
                          leading: CircleAvatar(

                          ),
                          title: Text(widget.recentJobs.name,
                            style: AppTheme.sectionMediumBoldTitle,
                          ),
                          subtitle: AppSub(sub: widget.recentJobs.location),
                          trailing: Container(
                            width: 20.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                    radius: 17.5.sp,
                                    backgroundColor: AppTheme.borderColor2,
                                    child: Image.asset('assets/icons/icon_call.png', height: 3.h,)),
                                SizedBox(width: 2.w,),
                                CircleAvatar(
                                    radius: 17.5.sp,
                                    backgroundColor: AppTheme.borderColor2,
                                    child: Image.asset('assets/icons/icon_play.png', height: 3.h,))
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



}
