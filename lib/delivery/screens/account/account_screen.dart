
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/account/edit_profile.dart';
import 'package:wena_partners/delivery/screens/account/faq_screen.dart';
import 'package:wena_partners/delivery/screens/account/help_center_screen.dart';
import 'package:wena_partners/delivery/screens/account/help_center_service_options_screen.dart';
import 'package:wena_partners/delivery/screens/account/notifications_screen.dart';
import 'package:wena_partners/delivery/screens/auth/privacy_policy_screen.dart';
import 'package:wena_partners/initial/initial_screen.dart';
import 'package:wena_partners/widgets/app_buttons.dart';


import 'find_local_store.dart';


class DeliveryAccountScreen extends StatefulWidget {
  const DeliveryAccountScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAccountScreen> createState() => _DeliveryAccountScreenState();
}

class _DeliveryAccountScreenState extends State<DeliveryAccountScreen> {


  List name = [
    "Order History",
    // "Booking History",
    // "Your Account",
    // "Community",
    // "Material Calculator",
    // "Find Store",
    // "Buy in Bulk",
    "Notifications",
    "Help Center",
    "Frequently Asked Questions",
    "Privacy Policy",
    "Settings",
    // "Logout",
  ];
  List subName = [
    "Wallet",
    "WishList",
    "Manage Address",
    "Next of Kin",
  ];

  List image = [
    "assets/images/account/Booking History.svg",
    // "assets/images/account/Booking History.svg",
    // "assets/images/account/account.svg",
    // "assets/images/account/Community.svg",
    // "assets/images/account/Material Calculator.svg",
    // "assets/images/account/Find a Local store.svg",
    // "assets/images/Cube.svg",
    "assets/images/account/Notification.svg",
    "assets/images/account/Help center.svg",
    "assets/images/account/FAQ.svg",
    "assets/images/account/Privacy.svg",
    "assets/images/account/Setting.svg",
  ];
  List subImage = [
    "assets/images/account/Wallet.svg",
    "assets/images/account/Time slot.svg",
    "assets/images/account/My Project.svg",
    "assets/images/account/Next to kin.svg",
  ];

  int? selected;
  int? selected1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
          child: FadeInUp(
            child: Column(
              children: [
                 ListTile(
                  leading:  CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/dman.jpg',),
                    radius: 20.sp,
                  ),
                  title: Text(
                    "Mr. Quick Delivery",
                    style: AppTheme.appTitle,
                  ),
                  subtitle: Text(
                    "quickdelivery@gmail.com",
                    style: AppTheme.subtitleSmall,
                  ),
                  trailing: GestureDetector(
                    onTap: (){
                      Get.to(() => DeliveryEditProfileScreen());
                    },
                    child: CircleAvatar(
                      radius: 15.sp,
                      backgroundColor: AppTheme.primaryColor,
                      child: Icon(Icons.edit, color: Colors.white, size: 15.sp,),
                    ),
                  ),

                ),



                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: name.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  const Divider(indent: 20,endIndent: 20,height: 0.5),
                                  Theme(
                                    data: ThemeData().copyWith(dividerColor: Colors.transparent,),
                                    child: ExpansionTile(
                                      key: Key(index.toString()),
                                      initiallyExpanded: index==selected,
                                      onExpansionChanged: ((newState){

                                        if(index==1){
                                          print('Notifications');
                                          Get.to(() => const NotificationsScreen());
                                        } else if(index == 3) {
                                          print('Faq Screen');
                                          Get.to(()=>  FaqScreen());
                                        } else if(index == 5) {
                                          print('Settings');
                                          // Get.to(()=>  FindStoreScreen());
                                        } else if(index == 2) {
                                          print('Help Center');
                                          Get.to(()=>  HelpCenterServiceOptionsScreen());
                                        } else if(index == 0) {
                                          print('Order History');
                                          // Get.to(()=>  OrderHistoryScreen());
                                        } else if(index == 4) {
                                          print('Privacy Policy');
                                          Get.to(()=>  PrivacyPolicyScreen());
                                        }
                                      }),
                                      trailing: selected == index?const Icon(Icons.keyboard_arrow_down,color: Colors.black):const Icon(Icons.navigate_next,color: Colors.black,),
                                      title: Text(
                                        "${name[index]}",
                                        style:  TextStyle(
                                          fontSize: 18.sp,
                                          letterSpacing: 0.2,
                                          color: name[index]=="Logout"?const Color(0xFFFF0000):const Color(0xFF4C5967),
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      leading: SvgPicture.asset(image[index],fit: BoxFit.cover,),
                                      children:  <Widget> [
                                        // index == 2? Column(
                                        //   children: [
                                        //     Padding(
                                        //       padding: EdgeInsets.only(top: 1.h),
                                        //       child: ClipRRect(
                                        //         borderRadius: BorderRadius.circular(12),
                                        //         child: Container(
                                        //           color: const Color(0xFFE29547).withOpacity(0.25),
                                        //           height: 10.h,
                                        //           width: 75.w,
                                        //           child:  Center(
                                        //             child: Padding(
                                        //               padding: EdgeInsets.only(top: 1.h,bottom: 8,left: 2.w,right: 2.w),
                                        //               child: Text(
                                        //                 "kindly fill in your next of kin details to activate your wallet",
                                        //                 style: TextStyle(
                                        //                   fontSize: 12,
                                        //                   color: const Color(0xFFE29547).withOpacity(0.70),
                                        //                   fontFamily: "SEGOEUI",
                                        //                   fontWeight: FontWeight.w600,
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       height: MediaQuery.of(context).size.height * 0.3,
                                        //       child: ListView.builder(
                                        //           physics: const BouncingScrollPhysics(),
                                        //           itemCount: subName.length,
                                        //           itemBuilder: (BuildContext context, int index) {
                                        //             // print("INDEX-------$index");
                                        //             return Column(
                                        //               children: [
                                        //                 const Divider(indent: 20,endIndent: 20,height: 0.1),
                                        //                 Padding(
                                        //                   padding:  EdgeInsets.only(left: 5.w),
                                        //                   child: Theme(
                                        //                     data: ThemeData().copyWith(dividerColor: Colors.transparent,),
                                        //                     child: ExpansionTile(
                                        //                       key: Key(index.toString()),
                                        //                       initiallyExpanded: index==selected1,
                                        //                       onExpansionChanged: ((newState){
                                        //
                                        //                         if(index==0){
                                        //                           // Get.to(() => const WalletScreen());
                                        //                         }
                                        //                         if(index==2){
                                        //                           // Get.to(() => const ManageAddress());
                                        //
                                        //                         }
                                        //                         if(index==3){
                                        //                           // Get.to(() => const NextOfKinScreen());
                                        //
                                        //                         }
                                        //                         if(index==4){
                                        //
                                        //                         }
                                        //                       }),
                                        //                       trailing: selected1 == index?const Icon(Icons.keyboard_arrow_down,color: Colors.black,):const Icon(Icons.navigate_next,color: Colors.black,),
                                        //                       title: Text(
                                        //                         "${subName[index]}",
                                        //                         style:  TextStyle(
                                        //                           fontSize: 17.5.sp,
                                        //                           letterSpacing: 0.2,
                                        //                           color: Color(0xFF4C5967),
                                        //                           fontFamily: "SEGOEUI",
                                        //                           fontWeight: FontWeight.w600,
                                        //                         ),
                                        //                       ),
                                        //                       leading: Padding(
                                        //                         padding:  EdgeInsets.only(top: 1.h,left: 5.w),
                                        //                         child: SvgPicture.asset(subImage[index],fit: BoxFit.cover,),
                                        //                       ),
                                        //                       children:  const <Widget>[
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //
                                        //               ],
                                        //             );
                                        //           }),
                                        //     )
                                        //   ],
                                        // ) :Container(),
                                      ],
                                    ),
                                  ),
                                  
                                  index==5?  SizedBox(height: 15.h, ):Container(height: 15,),
                                  index==5? Bounceable(
                                    onTap:() async{
                                      SharedPreferences sp = await SharedPreferences.getInstance();
                                      sp.remove('user_id');

                                      Get.bottomSheet(
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20.sp),
                                                topLeft: Radius.circular(20.sp)
                                            )
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                                          child: Container(
                                              height: 20.h,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 1.h),
                                                    child: Container(
                                                      height: 0.75.h,
                                                      width: 20.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15.sp),
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 1.h),
                                                    child: Text('Sure want to logout?', style: AppTheme.sectionMediumBoldTitle),
                                                  ),

                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                     Padding(
                                                       padding: EdgeInsets.only(top: 3.h),
                                                       child: SizedBox(
                                                         width: 35.w,
                                                         child: AppButton(
                                                             title: 'Cancel',
                                                             color: Colors.red.shade700,
                                                             function: (){
                                                               Get.back();
                                                             }),
                                                       ),
                                                     ),


                                                     Padding(
                                                       padding: EdgeInsets.only(top: 3.h),
                                                       child: SizedBox(
                                                         width: 35.w,
                                                         child: AppButton(
                                                             title: 'LogOut',
                                                             color: AppTheme.primaryColor,
                                                             function: (){
                                                               Get.back();
                                                               Get.offAll(() => InitialScreeen());
                                                             }),
                                                       ),
                                                     ),
                                                   ],
                                                 )

                                                ],
                                              )),
                                        ),
                                      );

                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Image.asset('assets/images/account/logout.png',height: 25,width: 20,),
                                        ),
                                         Padding(
                                          padding: EdgeInsets.only(left: 38),
                                          child: Text(
                                            "Logout",
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              letterSpacing: 0.2,
                                              color: Color(0xFFFF0000),
                                              fontFamily: "SEGOEUI",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):Container(),

                                ],
                              );
                            }),

                        const SizedBox(height: 15,),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
