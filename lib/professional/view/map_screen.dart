// ignore_for_file: library_private_types_in_public_api, unnecessary_new, avoid_print, deprecated_member_use


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'bootombar_screen.dart';


class MapScreen1 extends StatefulWidget {
  const MapScreen1({Key? key}) : super(key: key);

  @override
  _MapScreen1State createState() => _MapScreen1State();
}

class _MapScreen1State extends State<MapScreen1> {

  // final Uint8List markerIcon = await getBytesFromAsset('assets/images/flutter.png', 100);
  // final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon), markerId: null);

  GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers = {};
  late BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    getLocation();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/maker.png');
  }

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(
            markerId: const MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                markers: _markers,
                zoomControlsEnabled: true,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(72.878132, 21.2423),
                  zoom: 12.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    _markers.add(
                        Marker(
                            markerId: const MarkerId('<MARKER_ID>'),
                            icon: pinLocationIcon,
                        )
                    );
                  });
                  _controller = controller;
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: SvgPicture.asset('assets/images/location/Vector.svg'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Plot 37/45 Kampala Road",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SEGOEUI')),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          // child: Image.asset(
                          //   'assets/images/close.png',
                          //   height: 25,
                          // ),
                          child: SvgPicture.asset('assets/images/location/Shape.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.7),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 5,
                          width: 40,
                          color: const Color(0xFFABABAB).withOpacity(0.50),
                        ),
                      ),
                    ),
                    ListTile(
                        leading: Image.asset("assets/images/homepage/man.png",height: 50,),
                        title: const Text("David Thomas",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "SEGOEUI",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Text(
                          "Mchanga wa mchanga",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8391A1),
                            fontFamily: "SEGOEUI",
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        trailing: SizedBox(
                          // color: Colors.red,
                          width: 80,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0,left: 8),
                                child: Image.asset("assets/images/call.png",width: 30,),
                              ),
                              const SizedBox(width: 12,),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset("assets/images/msg.png",width: 30),
                              ),
                            ],
                          ),
                        )
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 80,
                      width: double.infinity,
                      decoration:  const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                                color: Colors.black45
                            )
                          ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          _showDialog(context);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            color: const Color(0xFF149C48),
                            child: const Center(
                              child: Text(
                                "Completed",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'SEGOEUI',
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.location_searching,color: Colors.white,),
        //   onPressed: (){
        //     getLocation();
        //   },
        // ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // title: const Text("Alert!!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/thankyou.png",height: 130,),
              const SizedBox(height: 10,),
              const Text(
                "Thank You !",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF149C48),
                  fontFamily: 'SEGOEUI',
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 20,),
              const Center(
                child: Text(
                  "your order has been completed successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF8391A1),
                    fontFamily: 'SEGOEUI',
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomBar()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    color: const Color(0xFF149C48),
                    child: const Center(
                      child: Text(
                        "Back to home",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'SEGOEUI',
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // actions: <Widget>[
          //   new FlatButton(
          //     child: const Text("OK"),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }
}
