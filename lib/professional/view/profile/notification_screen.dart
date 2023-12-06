// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wena_partners/professional/controller/notification_controller.dart';
import 'package:wena_partners/professional/view/order_detail_screen.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notification = [
    {
      "notificationImg": 'assets/images/man2.png',
      "notificationCmt": 'You have received new order request',
      "notificationTime": 'Today 2:30',
    },
    {
      "notificationImg": 'assets/images/man2.png',
      "notificationCmt": 'You have received new order request',
      "notificationTime": 'Today 2:30',
    },
    {
      "notificationImg": 'assets/images/man2.png',
      "notificationCmt": 'You have received new order request',
      "notificationTime": 'Today 2:30',
    },
    {
      "notificationImg": 'assets/images/man2.png',
      "notificationCmt": 'You have received new order request',
      "notificationTime": 'Today 2:30',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ///----- appbar view ---------
            Container(
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/icons/icon_back.png",
                      height: 40,
                    ),
                  ),
                  const Spacer(flex: 2),
                  const Text(
                    "Notifications",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "SEGOEUI",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),

            ///----------- list view -------
            GetBuilder<NotificationController>(
                init: NotificationController(),
                builder: (controller) {
                  return Expanded(
                    child: controller.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF149C48),
                            ),
                          )
                        : controller.notificationDetail.isEmpty
                            ? const Center(
                                child: Text(
                                  'Notification not found',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xFF8391A1),
                                    fontFamily: "SEGOEUI",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                ),
                                // height: 160,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        controller.notificationDetail.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data =
                                          controller.notificationDetail[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(controller.bookingModel!.data[index].intGlcode.toString())));
                                          Get.to(() => OrderDetailScreen(
                                              data.fkBooking.toString()));
                                        },
                                        child: Container(
                                          // color: Colors.red,
                                          margin: const EdgeInsets.only(
                                              top: 10,
                                              left: 0,
                                              bottom: 10,
                                              right: 0),
                                          // width: 120,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, left: 20, bottom: 0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            data.varImageLink ??
                                                                '',
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                      // Image.network(data.varImageLink??'',fit: BoxFit.fill,width: 48,),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ///--------- notification cmt -----------
                                                          Container(
                                                              width: 200,
                                                              child: Text(
                                                                // notification[index]['notificationCmt'],
                                                                data.varMessage ??
                                                                    '',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Color(
                                                                            0xff292D32),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        // color: Colors.black,
                                                                        fontFamily:
                                                                            'SEGOEUI'),
                                                              )),

                                                          ///----------- notification time --------
                                                          Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8),
                                                              child: Text(
                                                                // notification[index]['notificationTime'],
                                                                data.dtCreateddate
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Color(
                                                                            0xff8391A1),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        // color: Colors.black,
                                                                        fontFamily:
                                                                            'SEGOEUI'),
                                                              )),

                                                          ///------- all three button view --------------
                                                          // Container(
                                                          //   margin:
                                                          //       EdgeInsets.only(top: 10),
                                                          //   child: Row(
                                                          //     mainAxisAlignment:
                                                          //         MainAxisAlignment
                                                          //             .spaceAround,
                                                          //     crossAxisAlignment:
                                                          //         CrossAxisAlignment.start,
                                                          //     children: [
                                                          //       ///------view button ------
                                                          //       Container(
                                                          //         height: 30,
                                                          //         width: 70,
                                                          //         decoration: BoxDecoration(
                                                          //             color:
                                                          //                 Color(0xff52B46B),
                                                          //             borderRadius:
                                                          //                 BorderRadius
                                                          //                     .circular(
                                                          //                         12)),
                                                          //         alignment:
                                                          //             Alignment.center,
                                                          //         child: const Text(
                                                          //           'VlEW',
                                                          //           style: TextStyle(
                                                          //               fontSize: 14,
                                                          //               color: Colors.white,
                                                          //               fontWeight:
                                                          //                   FontWeight.w600,
                                                          //               letterSpacing: 1,
                                                          //               // color: Colors.black,
                                                          //               fontFamily:
                                                          //                   'SEGOEUI'),
                                                          //         ),
                                                          //       ),
                                                          //
                                                          //       ///------ accept button -----
                                                          //       Container(
                                                          //         margin: EdgeInsets.only(
                                                          //             left: 10),
                                                          //         height: 30,
                                                          //         width: 75,
                                                          //         decoration: BoxDecoration(
                                                          //             color: Color(
                                                          //                     0xff149C48)
                                                          //                 .withOpacity(0.1),
                                                          //             border: Border.all(
                                                          //                 color: Color(
                                                          //                     0xff149C48)),
                                                          //             borderRadius:
                                                          //                 BorderRadius
                                                          //                     .circular(
                                                          //                         10)),
                                                          //         alignment:
                                                          //             Alignment.center,
                                                          //         child: const Text(
                                                          //           'ACCEPT',
                                                          //           style: TextStyle(
                                                          //               fontSize: 14,
                                                          //               color: Color(
                                                          //                   0xff149C48),
                                                          //               fontWeight:
                                                          //                   FontWeight.w600,
                                                          //               // color: Colors.black,
                                                          //               fontFamily:
                                                          //                   'SEGOEUI'),
                                                          //         ),
                                                          //       ),
                                                          //
                                                          //       ///------ reject button --------
                                                          //       Container(
                                                          //         margin: EdgeInsets.only(
                                                          //             left: 10),
                                                          //         height: 30,
                                                          //         width: 75,
                                                          //         decoration: BoxDecoration(
                                                          //             color: Color(
                                                          //                     0xffFF6464)
                                                          //                 .withOpacity(0.1),
                                                          //             border: Border.all(
                                                          //                 color: Color(
                                                          //                     0xffFF6464)),
                                                          //             borderRadius:
                                                          //                 BorderRadius
                                                          //                     .circular(
                                                          //                         10)),
                                                          //         alignment:
                                                          //             Alignment.center,
                                                          //         child: const Text(
                                                          //           'REJECT',
                                                          //           style: TextStyle(
                                                          //               fontSize: 14,
                                                          //               color: Color(
                                                          //                   0xffFF6464),
                                                          //               fontWeight:
                                                          //                   FontWeight.w600,
                                                          //               // color: Colors.black,
                                                          //               fontFamily:
                                                          //                   'SEGOEUI'),
                                                          //         ),
                                                          //       ),
                                                          //     ],
                                                          //   ),
                                                          // )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        top: 10, right: 15),
                                                    child: Divider(
                                                      // indent: 0.3,
                                                      color: Color(0xffEBEBEB),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
