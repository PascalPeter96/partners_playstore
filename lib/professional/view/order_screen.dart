// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wena_partners/professional/controller/booking_controller.dart';

import 'order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);



  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List text = [
    "ALL",
    "COMPLETED",
    "PENDING",
    "CANCEL",
  ];

  List text1 = [
    "COMPLETED",
    "PENDING",
    "CANCEL",
    "COMPLETED",
    "PENDING",
    "CANCEL",
  ];

  List text2 = [
    "#ORD001129",
    "#ORD001129",
    "#ORD001129",
    "#ORD001129",
    "#ORD001129",
    "#ORD001129",
  ];

  List text3 = [
    "05-05-2022 07:15 AM",
    "05-05-2022 07:15 AM",
    "05-05-2022 07:15 AM",
    "05-05-2022 07:15 AM",
    "05-05-2022 07:15 AM",
    "05-05-2022 07:15 AM",
  ];

  int? checkedIndex = 0;

  bool isLoad = false;


  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<BookingController>(
            id: 'Booking',
            init: BookingController(),
            builder: (controller) {
              return controller.isHomeLoad == true?
              Center(child: CircularProgressIndicator(),):
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                            // Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/icon_back.png",
                            height: 40,
                          ),
                        ),

                        const Text(
                          "Bookings",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "SEGOEUI",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/images/homepage/notification.svg",
                          height: 40,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      height:  h * 0.10,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: text.length,
                          itemBuilder: (BuildContext context, int index) {
                            bool checked = index == checkedIndex;
                            return  Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: checked?Color(0xFF149C48).withOpacity(0.18):Colors.white,
                                        border: Border.all(
                                            color: checked?Color(0xFF149C48):Color(0xFF8391A1),
                                            width: 1.5),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    height: 34,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          checkedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 12),
                                        child: Center(
                                          child: Text("${text[index]}",
                                            style: TextStyle(
                                              // color: ,
                                              color: checked?Color(0xFF149C48):Color(0XFF8391A1),
                                              fontSize: 13,
                                              fontFamily: "SEGOEUI",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.bookingModel!.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("Date and time ---------------------->>>> ${controller.bookingModel!.data[index].dtCreateddate}");
                            DateTime date = DateTime.parse(controller.bookingModel!.data[index].dtCreateddate.toString());
                              return  Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(controller.bookingModel!.data[index].intGlcode.toString())));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      height: h*0.12,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.grey,width: 0.3),
                                      ),
                                      child: Center(
                                        child: ListTile(
                                            title: Text(
                                              "${controller.bookingModel!.data[index].bookingId}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: 'SEGOEUI',
                                              ),
                                            ),
                                            subtitle: Text(
                                              "$date",
                                              style: TextStyle(
                                                height: 1.8,
                                                color: Color(0xFF8391A1),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                fontFamily: 'SEGOEUI',
                                              ),
                                            ),
                                            trailing:  Container(
                                              margin: EdgeInsets.only(bottom: 25),
                                              height: 28,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  color: text1[index]=="COMPLETED"?Color(0xFF149C48).withOpacity(0.18):
                                                  text1[index]=="PENDING"?Color(0xFFE5740B).withOpacity(0.18):
                                                  text1[index]=="CANCEL"?Color(0xFFFF6464).withOpacity(0.18):
                                                  Colors.white,
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                                    child: Text(
                                                      "${text1[index]}",
                                                      style: TextStyle(
                                                        color: text1[index]=="COMPLETED"?Color(0xFF149C48):
                                                        text1[index]=="PENDING"?Color(0xFFE5740B):
                                                        text1[index]=="CANCEL"?Color(0xFFFF6464):
                                                        Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 12,
                                                        fontFamily: 'SEGOEUI',
                                                      ),
                                                    ),
                                                  )),
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                          }),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
