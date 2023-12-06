// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:wena_partners/professional/controller/get_booking_id_conroller.dart';

import 'map_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  String? glCode;

  OrderDetailScreen(this.glCode, {Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<GetBookingIdController>(
            id: 'GetBooking',
            init: GetBookingIdController(widget.glCode),
            builder: (controller) {
              print("GL_CODE--------------${widget.glCode}");
              return controller.isHomeLoad == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                  Text(
                                    // "#ORD001129",
                                    "${controller.getBookingModel?.data?.bookingId.toString()}",
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
                              const SizedBox(
                                height: 25,
                              ),
                              Divider(
                                thickness: 1,
                                indent: 7,
                                endIndent: 7,
                                color: Color(0xFFEBEBEB),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                  leading: Image.asset(
                                    "assets/images/man.png",
                                    height: 50,
                                  ),
                                  // title: const Text(
                                  //   "David Thomas",
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     color: Colors.black,
                                  //     fontFamily: "SEGOEUI",
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                  title: RichText(
                                      softWrap: true,
                                      text: TextSpan(
                                        text:
                                            '${controller.getBookingModel?.data?.userFname} '
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '${controller.getBookingModel?.data?.userSurname}'
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: "SEGOEUI",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )),
                                  subtitle: Text(
                                    "${controller.getBookingModel?.data?.userMobileNo}"
                                        .toString(),
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
                                          padding: const EdgeInsets.only(
                                              bottom: 0, left: 8),
                                          child: Image.asset(
                                            "assets/icons/icon_call.png",
                                            width: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          child: Image.asset(
                                              "assets/images/msg.png",
                                              width: 30),
                                        ),
                                      ],
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Wrap(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            controller.getBookingModel!.data!
                                                .varServiceArr!.length;
                                        i++)
                                      Text(
                                        '${controller.getBookingModel!.data!.varServiceArr![i].serviceTitle}${controller.getBookingModel!.data!.varServiceArr!.length - 1 == i ? '' : ', '}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "SEGOEUI",
                                            color: Color(0xFF838BA1),
                                            fontWeight: FontWeight.w600,
                                            height: 1.6,
                                            letterSpacing: 0.2),
                                      ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 15, vertical: 10),
                              //   child: Text(
                              //     // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry  standard dummy text ever since theLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text...',
                              //     'Fan Service',
                              //     style: TextStyle(
                              //         fontSize: 15,
                              //         fontFamily: "SEGOEUI",
                              //         color: Color(0xFF838BA1),
                              //         fontWeight: FontWeight.w600,
                              //         height: 1.6,
                              //         letterSpacing: 0.2),
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                thickness: 1,
                                indent: 7,
                                endIndent: 7,
                                color: Color(0xFFEBEBEB),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: SvgPicture.asset(
                                  "assets/images/map.svg",
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "Location",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF8391A1),
                                      fontFamily: "SEGOEUI",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  "${controller.getBookingModel?.data?.varAddress}"
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: "SEGOEUI",
                                      fontWeight: FontWeight.w600,
                                      height: 1.5),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Divider(
                                thickness: 1,
                                indent: 7,
                                endIndent: 7,
                                color: Color(0xFFEBEBEB),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                    ),
                                    Text(
                                      // "ORD001129",
                                      "${controller.getBookingModel?.data?.bookingId}"
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF292D32),
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                indent: 7,
                                endIndent: 7,
                                color: Color(0xFFEBEBEB),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF292D32),
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                    ),
                                    Text(
                                      "${controller.getBookingModel?.data?.dDate!}"
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF292D32),
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                indent: 7,
                                endIndent: 7,
                                color: Color(0xFFEBEBEB),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Time",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF292D32),
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                    ),
                                    Text(
                                      // "07:15 AM",
                                      "${controller.getBookingModel?.data?.tTime}"
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF292D32),
                                          fontFamily: "SEGOEUI",
                                          fontWeight: FontWeight.w600,
                                          height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.CancelBookingID(context);
                                        controller.CompletedBookingID(context);
                                      },
                                      child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFF6464)
                                                .withOpacity(0.25),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Color(0xFFFF6464))),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color(0xFfFF6464)
                                                  .withOpacity(0.85),
                                              fontFamily: 'SEGOEUI',
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MapScreen1()));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 48,
                                          width: double.infinity,
                                          color: const Color(0xFF149C48),
                                          child: Center(
                                            child: const Text(
                                              "Go to Map",
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
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
