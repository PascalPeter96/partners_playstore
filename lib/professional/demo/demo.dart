// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:wena/home_demo.dart';
//
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: GetBuilder<HomeController>(
//         id: 'home',
//         init: HomeController(),
//         builder: (controller) {
//           return controller.isHomeLoad == true
//               ? const Center(
//                child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.red)),
//           )
//               :  ListView.builder(padding: EdgeInsets.zero,itemBuilder: (BuildContext context,index){
//                 return Padding(
//               padding: EdgeInsets.only(left: 15,right: 15,top: 20),
//                 child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       controller.homeModel!.responseData![index].imagePath!.contains(".jpeg") || controller.homeModel!.responseData![index].imagePath!.contains(".png") ?
//                       Container(
//                         height: 150,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                             image: DecorationImage(image: NetworkImage("${controller.homeModel!.responseData![index].imagePath}"),fit: BoxFit.fill)
//                         ),
//                       ) : Container(
//                         height: 150,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                             image: DecorationImage(image: AssetImage(common.defaultImage),fit: BoxFit.fill)
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: const BoxDecoration(
//                                   color: common.white,
//                                   borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SvgPicture.asset(common.fav,fit: BoxFit.cover,height: 15),
//                                   SizedBox(width: 8),
//                                   Row(
//                                     children: [
//                                       appText(txt: "4.5",color: common.red,size: 15.0),
//                                       appText(txt: "(450 review)",size: 15.0),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 15),
//                               child: SvgPicture.asset(common.heart,fit: BoxFit.cover,height: 30),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10,bottom: 10,top: 110),
//                         child: Container(
//                           padding: EdgeInsets.all(7),
//                           decoration: BoxDecoration(color: common.pink,borderRadius: BorderRadius.circular(5)),
//                           child: appText(txt: "NEW",color: common.white,weight: FontWeight.bold),
//                         ),
//                       )
//                     ],
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.all(15),
//                     decoration: const BoxDecoration(
//                         color: common.white,
//                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
//                         boxShadow: [
//                           BoxShadow(
//                               color: common.white,
//                               blurRadius: 1
//                           )
//                         ]
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Image.asset(common.veg,height: 25,width: 25,fit: BoxFit.fill),
//                             SizedBox(width: 10),
//                             appText(txt: controller.homeModel!.responseData![index].name,weight: FontWeight.bold,size: 18.0)
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         appText(txt: "${controller.homeModel!.responseData![index].address!.streeAddress} ${controller.homeModel!.responseData![index].address!.area}, ${controller.homeModel!.responseData![index].address!.city}, ${controller.homeModel!.responseData![index].address!.state}, ${controller.homeModel!.responseData![index].address!.zipcode}, ${controller.homeModel!.responseData![index].address!.country}",size: 14.0),
//                         SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SvgPicture.asset(common.alarm,fit: BoxFit.cover,height: 20),
//                                 SizedBox(width: 8),
//                                 appText(txt: "${controller.homeModel!.responseData![index].openTime} - ${controller.homeModel!.responseData![index].closeTime}",size: 14.0)
//                               ],
//                             ),
//                             Expanded(child: Container()),
//                             Row(
//                               children: [
//                                 InkWell(child: SvgPicture.asset(common.g1,fit: BoxFit.cover,height: 35),onTap: (){
//                                   launchUrl(Uri.parse("tel://${controller.homeModel!.responseData![index].phones![0].number}"));
//                                 }),
//                                 SizedBox(width: 8),
//                                 InkWell(child: SvgPicture.asset(common.g2,fit: BoxFit.cover,height: 35),onTap: ()async{
//                                   if (await canLaunch("mailto:${controller.homeModel!.responseData![index].email}")) {
//                                     await launch("mailto:${controller.homeModel!.responseData![index].email}");
//                                   } else {
//                                     throw "Error occured sending an email";
//                                   }
//                                 }),
//                                 SizedBox(width: 8),
//                                 InkWell(child: SvgPicture.asset(common.g3,fit: BoxFit.cover,height: 35),onTap: (){}),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Divider(),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(child: Container()),
//                             TextButton(onPressed: (){}, child: appText(txt: "Quick Look",color: common.maincolor,size: 18.0)),
//                             Expanded(child: Container()),
//                             Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   color: common.boxcolor,
//                                   borderRadius: BorderRadius.circular(5)
//                               ),
//                               child: appText(txt: "Orders",color: common.maincolor,size: 18.0),
//                             ),
//                             Expanded(child: Container()),
//                             Container(
//                               padding: EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   color: common.maincolor,
//                                   borderRadius: BorderRadius.circular(5)
//                               ),
//                               child: appText(txt: "Menu",color: common.black,size: 18.0),
//                             ),
//                             Expanded(child: Container()),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },itemCount: controller.homeModel!.responseData!.length,shrinkWrap: true);
//         }
//         ),
//     );
//   }
// }
