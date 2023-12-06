import 'dart:typed_data';
import 'dart:ui' as ui;


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/models/nearby_jobs.dart';
import 'package:wena_partners/delivery/models/recent_jobs.dart';


class RecentDeliveryLocationMapScreen extends StatefulWidget {
  final double userDistance;
  final RecentJobs recentJobs;
  const RecentDeliveryLocationMapScreen({Key? key, required this.recentJobs, required this.userDistance}) : super(key: key);

  @override
  State<RecentDeliveryLocationMapScreen> createState() => _RecentDeliveryLocationMapScreenState();
}

class _RecentDeliveryLocationMapScreenState extends State<RecentDeliveryLocationMapScreen> {



  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyDBMJHAZDTZti1Y88i8TL-kmz_7qR9Tp5I";

  Set<Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polyLines = {}; //polylines to show direction

  final CameraPosition _kGooglePlex = const CameraPosition(
    // target: LatLng(0.3858431573515069, 32.65144595438129),
    target: LatLng(0.315551782066307, 32.57849896123359),
    bearing: 90,
    tilt: 45,
    zoom: 13,
  );

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  late BitmapDescriptor storeMapMarker;
  String? mapStyle;

  void setStoreCustomMarker() async{
    final Uint8List markerIcon = await getBytesFromAsset('assets/marker.png', 100);
    storeMapMarker = BitmapDescriptor.fromBytes(markerIcon);
  }

  LatLng userLocation = LatLng(0.315551782066307, 32.57849896123359);
  late LatLng storeLocation;

  void _onMapCreated(GoogleMapController googleMapController){
    setState((){

      markers.add(Marker( //add start location marker
        markerId: MarkerId(userLocation.toString()),
        position: userLocation, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Mapeera Houser',
          snippet: 'Wena Store',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add distination location marker
        markerId: MarkerId(storeLocation.toString()),
        position: storeLocation, //position of marker
        infoWindow: InfoWindow( //popup info
          title: '${widget.recentJobs.name}',
          snippet: 'Wena User ',
        ),
        icon: storeMapMarker, //Icon for Marker
      ));

    });
  }

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

    getTime(widget.recentJobs.latitude, widget.recentJobs.longitude);

    storeLocation = LatLng(widget.recentJobs.latitude, widget.recentJobs.longitude);

    setStoreCustomMarker();
    rootBundle.loadString('assets/map_style.txt').then((string){
      mapStyle = string;
    });
    getDirections();

  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(storeLocation.latitude, storeLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppTheme.primaryColor,
      points: polylineCoordinates,
      width: 8,
    );
    polyLines[id] = polyline;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap( //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: _kGooglePlex,
            markers: markers, //markers to show on map
            polylines: Set<Polyline>.of(polyLines.values), //polylines
            mapType: MapType.terrain, //map type
            onMapCreated: _onMapCreated,
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 15.5.h,
              width: 85.w,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.sp),
                  topLeft: Radius.circular(0.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 2.w, top: 1.h, right: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recentJobs.name ,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.greenTitle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.1.h),
                              child: Text('Distance : ${widget.userDistance} km', style: AppTheme.sectionMediumBoldTitle,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.1.h),
                              child: Text('Time : $storeTime', style: AppTheme.sectionMediumBoldTitle,),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        // Container(
                        //   clipBehavior: Clip.antiAlias,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15.sp),
                        //   ),
                        //   child: Hero(
                        //     tag: widget.recentJobs,
                        //     child: Image.network(
                        //       '',
                        //       height: 7.5.h, width: 20.w,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
