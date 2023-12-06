// import 'package:animate_do/animate_do.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:wena_partners/app_style/app_theme.dart';
// import 'package:wena_partners/widgets/title_app_bar.dart';
//
//
// class FindStoreScreen extends StatefulWidget {
//
//    const FindStoreScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FindStoreScreen> createState() => _FindStoreScreenState();
// }
//
// class _FindStoreScreenState extends State<FindStoreScreen> {
//
//   String searchText = '';
//   TextEditingController searchController = TextEditingController();
//
//   int selectedIndex = 0;
//   List<Store> tempStores = [];
//
//   LatLng userLocation = LatLng(0.3858431573515069, 32.65144595438129);
//
//
//   late Distance distance;
//
//   Dio dio  = new Dio();
//
//   String storeTime = '';
//
//    getTime(double lat, double long) async{
//     var response = await dio.get(
//       'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=0.3858431573515069,32.65144595438129&destinations=$lat,$long&key=AIzaSyDBMJHAZDTZti1Y88i8TL-kmz_7qR9Tp5I'
//     );
//
//     String time = response.data['rows'][0]['elements'][0]['duration']['text'];
//
//     setState((){
//       storeTime = time;
//     });
//
//     print(storeTime);
//
//     // await response.data['rows'][0]['elements'][0]['duration']['text'];
//
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     distance = new Distance();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // final findStoreController = Get.put(FindStoreController());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//         ),
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         title: TitleAppBar(
//           title: 'Find Store',
//           titleWidget: Container(width: 10.w,),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5.w),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               onChanged: (value) {
//                 setState(() {
//                   searchText = value;
//                 });
//                 findStoreController.filterStore(value);
//                 print(searchText);
//               },
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: AppTheme.borderColor2,
//                 hintText: 'Enter Area Name',
//                 prefixIcon: Image.asset('assets/search.png'),
//                 suffixIcon: Padding(
//                   padding: EdgeInsets.only(right: 1.w),
//                   child: GestureDetector(
//                     onTap: () {
//                    setState((){
//                      findStoreController.results.clear();
//                      setState((){
//                        searchController.text = '';
//                      });
//                    });
//                     },
//                     child: Icon(
//                       Icons.clear_outlined, color: AppTheme.borderColor2,),
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.sp),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade300,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15.sp),
//                   borderSide: BorderSide(
//                     color: Colors.grey.shade300,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Obx(() {
//                 return ListView.builder(
//                   itemCount: findStoreController.searchStores.value.length,
//                   itemBuilder: (context, index) {
//                     var store = findStoreController.searchStores.value[index];
//                     var km = distance.as(LengthUnit.Kilometer,
//                             new LatLng(store.latitude, store.longitude), userLocation);
//                     return SlideInUp(
//                       child: Bounceable(
//                         onTap: (){
//                           // getTime(store.latitude, store.longitude);
//                           Get.to(() => FindStoreMap(store: store, storeDistance: km,));
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.sp),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 1.h, vertical: 1.h),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   child: Hero(
//                                     child: Image.network(
//                                       store.image,
//                                       width: 20.w,
//                                       height: 10.h,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     tag: store,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.sp),
//                                   ),
//                                   clipBehavior: Clip.antiAlias,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 2.w),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(store.storeName,
//                                         style: AppTheme.sectionMediumBoldTitle,),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           Text('${km} km ',
//                                             style: AppTheme.subtitleSmall,),
//                                           // Text(
//                                           //   ' - ', style: AppTheme.subtitleSmall,),
//                                           // Text(storeTime,
//                                           //   style: AppTheme.subtitleSmall,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
