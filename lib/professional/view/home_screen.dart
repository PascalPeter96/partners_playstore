// ignore_for_file: prefer_const_constructors, avoid_print, unrelated_type_equality_checks, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wena_partners/professional/controller/home_controller.dart';
import 'package:wena_partners/professional/model/profile_model.dart';
import 'package:wena_partners/professional/utils/text.dart';
import 'package:wena_partners/professional/view/profile/notification_screen.dart';

import 'all_community_screen.dart';
import 'joincommunityscreen.dart';
import 'map_screen.dart';
import 'order_detail_screen.dart';
import 'order_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List commUnity = [
    {
      "cName": homeLivingText,
      "cImg": 'assets/images/homepage/1257318 1.png',
    },
    {
      "cName": electronicsText,
      "cImg": 'assets/images/homepage/2080183 1.png',
    },
    {
      "cName": cleaningText,
      "cImg": 'assets/images/homepage/3899147 1.png',
    },
    {
      "cName": gardenText,
      "cImg": 'assets/images/homepage/1518965 2.png',
    },
  ];

  ///------ recent jobs list -------
  List recent = [
    {
      "title": titleText1,
      "datetime": titleTimeText1,
      "button": '',
    },
    {
      "title": titleText2,
      "datetime": titleTimeText2,
      "button": pendingText,
    },
    {
      "title": titleText3,
      "datetime": titleTimeText3,
      "button": cancelText,
    },
  ];

  List text1 = [
    "COMPLETED",
    "PENDING",
    "CANCEL",
    "COMPLETED",
    "PENDING",
    "CANCEL",
  ];

  bool isLoading = false;

  ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: GetBuilder<HomeController>(
            id: 'home',
            init: HomeController(),
            builder: (controller) {
              return controller.isHomeLoad == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 18,
                        ),
                        // height: 40,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///------------- hello /good morning / notification ------------
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //  Text(
                                  //   // helloText,
                                  //   "${controller.profileModel!.data!.varFname}",
                                  //   style: TextStyle(
                                  //       fontSize: 22,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.black,
                                  //       fontFamily: 'SEGOEUI',
                                  //   ),
                                  // ),

                                  RichText(
                                      softWrap: true,
                                      text: TextSpan(
                                        text: 'Hello, ',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: 'SEGOEUI',
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                "${controller.profileModel?.data?.varFname}"
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontFamily: 'SEGOEUI',
                                            ),
                                          ),
                                        ],
                                      )),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NotificationScreen()));
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/homepage/notification.svg',
                                      width: 36,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: const Text(
                                  goodMorningText,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff1E232C),
                                      fontFamily: 'SEGOEUI'),
                                )),
                            // Container(
                            //   margin:
                            //   const EdgeInsets.only(top: 5, left: 15, right: 15),
                            //   child:  Text(
                            //     shipmentsText,
                            //     style: TextStyle(
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w500,
                            //         color: Color(0xff838BA1),
                            //         fontFamily: 'SEGOEUI'),
                            //   ),
                            // ),

                            ///------------ user details card -----------------
                            // controller.bookingModel!.data
                            GetBuilder<HomeController>(
                              id: 'topJob',
                              builder: (topJobController) {
                                return
                                  topJobController.bookingModel?.data.isEmpty ?? true?
                                      SizedBox()
                                      :
                                  Container(
                                  margin: const EdgeInsets.only(
                                      top: 25, left: 15, right: 15),
                                  height: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, left: 15, right: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ///------------- image -----------
                                            controller.bookingModel?.data[0]
                                                        .varImage ==
                                                    null
                                                ? Container()
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(50),
                                                    child: SizedBox(
                                                      height: 70,
                                                      width: 70,
                                                      // child: Image.asset("assets/images/homepage/man.png"),
                                                      child: Image.network(
                                                          controller.bookingModel!
                                                              .data[0].varImage!
                                                              .toString(),
                                                          fit: BoxFit.fill),
                                                    ),
                                                  ),

                                            const SizedBox(
                                              width: 10,
                                            ),

                                            ///------------ user name /detail name  ----------
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.only(top: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    controller.bookingModel?.data[0]
                                                                .varFname ==
                                                            null
                                                        ? Container()
                                                        : Text(
                                                            "${controller.bookingModel!.data[0].varFname.toString()} ",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff161616),
                                                                fontFamily:
                                                                    'SEGOEUI'),
                                                          ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    controller.bookingModel?.data[0]
                                                                .varAddress ==
                                                            null
                                                        ? Container()
                                                        : Text(
                                                            controller.bookingModel!
                                                                .data[0].varAddress
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Color(
                                                                    0xff838BA1),
                                                                fontFamily:
                                                                    'SEGOEUI'),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            ///---------- call --------
                                            GestureDetector(
                                              onTap: () {
                                                launch(
                                                    "tel://${controller.bookingModel!.data[0].varMobileno.toString()}");
                                              },
                                              child: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      const Color(0xffE8EFF3),
                                                  child: SvgPicture.asset(
                                                      'assets/images/homepage/phone.svg')),
                                            )
                                          ],
                                        ),
                                      ),

                                      ///-------- time and send view --------------------------
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, left: 25, right: 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MapScreen1()));
                                              },
                                              child: CircleAvatar(
                                                  radius: 22,
                                                  backgroundColor:
                                                      const Color(0xff149C48),
                                                  child: SvgPicture.asset(
                                                    'assets/images/homepage/send.svg',
                                                    width: 20,
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(left: 15),
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffF6F7FB),
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              alignment: Alignment.center,
                                              child: controller.bookingModel
                                                          ?.data[0].tTime ==
                                                      null
                                                  ? Container()
                                                  : Text(
                                                      "${controller.bookingModel!.data[0].tTime.toString().replaceAll(":00", "")} am",
                                                      style: TextStyle(
                                                          color: Color(0xff8391A1),
                                                          fontFamily: 'SEGOEUI'),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            ),

                            ///---------commuity and view all-----------
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    commutityText,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'SEGOEUI'),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JoinCommunity()));
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          viewAllText,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff149C48),
                                              fontFamily: 'SEGOEUI'),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xff149C48),
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///---------- commutity listview ----------
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                              ),
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.homePageCommuity.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 10, bottom: 10),
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffE8EFF3),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(controller
                                            .homePageCommuity[index].varIcon
                                            .toString()),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          width: 80,
                                          child: Text(
                                            controller.homePageCommuity[index]
                                                .varTitle
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'SEGOEUI'),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            ///----------- join commuity button -----------
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllCommunityScreen()));
                              },
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 50, right: 50, top: 10),
                                  height: 45,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff149C48),
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    joinText,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SEGOEUI'),
                                  ),
                                ),
                              ),
                            ),

                            ///---------recent and view all-----------
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    recentText,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: 'SEGOEUI'),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>OrderScreen());
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          viewAllText,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff149C48),
                                              fontFamily: 'SEGOEUI'),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xff149C48),
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///---------- recent listview ----------

                            // controller.statusCode==400?Center(child: Container()):
                            GetBuilder<HomeController>(
                                id: 'recentJobs',
                                builder: (recentJobsController) {
                                  return recentJobsController.isRecentJobs
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Color(0xFF149C48),
                                          ),
                                        )
                                      : recentJobsController
                                                  .bookingModel?.data.isEmpty ??
                                              true
                                          ? Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 48.0,bottom: 48),
                                                child: Text(
                                                  'You do not have any recent job',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF8391A1),
                                                    fontFamily: "SEGOEUI",
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              // height:350,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  // itemCount: 1,
                                                  itemCount:
                                                      recentJobsController
                                                          .bookingModel
                                                          ?.data
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    // print("Date and time ------------------->>>> ${controller.bookingModel?.data[index].dtCreateddate}");
                                                    DateTime date = DateTime.parse(
                                                        recentJobsController
                                                                .bookingModel
                                                                ?.data[index]
                                                                .dtCreateddate
                                                                .toString() ??
                                                            DateTime.now()
                                                                .toString());
                                                    // print("data====================== $date");
                                                    // bool isRequest = index == 0
                                                    //     ? true
                                                    //     : false;
                                                    bool isRequest = recentJobsController.bookingModel!.data[index].varStatus == "P"?true:false;
                                                    var data = recentJobsController.bookingModel?.data[index];
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => OrderDetailScreen(recentJobsController
                                                                        .bookingModel!
                                                                        .data[
                                                                            index]
                                                                        .intGlcode
                                                                        .toString())));
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            height: h * 0.12,
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.3),
                                                            ),
                                                            child: Center(
                                                              child: ListTile(
                                                                title: Text(
                                                                  "${recentJobsController.bookingModel!.data[index].bookingId}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        'SEGOEUI',
                                                                  ),
                                                                ),
                                                                subtitle: Text(
                                                                  "$date",
                                                                  style:
                                                                      TextStyle(
                                                                    height: 1.8,
                                                                    color: Color(
                                                                        0xFF8391A1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'SEGOEUI',
                                                                  ),
                                                                ),
                                                                trailing: isRequest
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          recentJobsController.onJobStatusChange(bookingId: data?.intGlcode??'', status: 'A',);
                                                                          debugPrint(
                                                                              'on accept');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(bottom: 25),
                                                                                height: 28,
                                                                                width: 60,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFF149C48).withOpacity(0.18),
                                                                                  border: Border.all(color: Color(0xFF149C48), width: 1),
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    'ACCEPT',
                                                                                    style: TextStyle(
                                                                                      color: Color(0xFF149C48),
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 12,
                                                                                      fontFamily: 'SEGOEUI',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  recentJobsController.onJobStatusChange(bookingId: data?.intGlcode??'', status: 'R',);
                                                                                  debugPrint('on reject');
                                                                                },
                                                                                child: Container(
                                                                                  margin: EdgeInsets.only(bottom: 25),
                                                                                  height: 28,
                                                                                  width: 60,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFFF6464).withOpacity(0.18),
                                                                                    border: Border.all(color: Color(0xFFFF6464), width: 1),
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'REJECT',
                                                                                      style: TextStyle(
                                                                                        color: Color(0xFFFF6464),
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontSize: 12,
                                                                                        fontFamily: 'SEGOEUI',
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                25),
                                                                        height:
                                                                            28,
                                                                        width:
                                                                            80,
                                                                        decoration: BoxDecoration(
                                                                            color: recentJobsController.bookingModel!.data[index].varStatus == "C"
                                                                                ? Color(0xFF149C48).withOpacity(0.18)
                                                                                : recentJobsController.bookingModel!.data[index].varStatus == "P"
                                                                                    ? Color(0xFFE5740B).withOpacity(0.18)
                                                                                    : recentJobsController.bookingModel!.data[index].varStatus == "R"
                                                                                        ? Color(0xFFFF6464).withOpacity(0.18)
                                                                                        : recentJobsController.bookingModel!.data[index].varStatus == "A"
                                                                                            ? Color(0xFFFF6464).withOpacity(0.18)
                                                                                            : Colors.white,
                                                                            borderRadius: BorderRadius.circular(12)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                                                            child:
                                                                                Text(
                                                                              recentJobsController.bookingModel!.data[index].varStatus == "A"
                                                                                  ? "Accepted"
                                                                                  : recentJobsController.bookingModel!.data[index].varStatus == "C"
                                                                                      ? "Completed"
                                                                                      : recentJobsController.bookingModel!.data[index].varStatus == "P"
                                                                                          ? "Pending"
                                                                                          : "Rejected",
                                                                              style: TextStyle(
                                                                                color: recentJobsController.bookingModel!.data[index].varStatus == "C"
                                                                                    ? Color(0xFF149C48)
                                                                                    : recentJobsController.bookingModel!.data[index].varStatus == "P"
                                                                                        ? Color(0xFFE5740B)
                                                                                        : recentJobsController.bookingModel!.data[index].varStatus == "R"
                                                                                            ? Color(0xFFFF6464)
                                                                                            : Color(0xFF149C48),
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 12,
                                                                                fontFamily: 'SEGOEUI',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            );
                                }),
                          ],
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
