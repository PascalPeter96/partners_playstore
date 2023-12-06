// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wena_partners/professional/controller/review_rating_controller.dart';


class ReviewRatingScreen extends StatefulWidget {
  const ReviewRatingScreen({Key? key}) : super(key: key);

  @override
  State<ReviewRatingScreen> createState() => _ReviewRatingScreenState();
}

class _ReviewRatingScreenState extends State<ReviewRatingScreen> {
  List ratting = [
    {
      "rateCmt":
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      "rateTime": '10 August 2022 at 11:27',
    },
    {
      "rateCmt":
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      "rateTime": '10 August 2022 at 11:27',
    },
    {
      "rateCmt":
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      "rateTime": '10 August 2022 at 11:27',
    },
    {
      "rateCmt":
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      "rateTime": '10 August 2022 at 11:27',
    },
  ];

  Image? _selectedIcon;

  String rate = '4.0';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              ///----- appbar view ---------
              Container(
                margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                      "Review & Rating",
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
              GetBuilder<ReviewRatingController>(
                  init: ReviewRatingController(),
                  builder: (controller) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        // height: 160,
                        child: controller.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF149C48),
                                ),
                              )
                            : controller.reviewList.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Review not found',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xFF8391A1),
                                        fontFamily: "SEGOEUI",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.reviewList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = controller.reviewList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 10,
                                              left: 20,
                                              bottom: 10,
                                              right: 20),
                                          // height: ,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffE8EFF3),
                                                  width: 2),
                                              // color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10, left: 10, bottom: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ///------ ratting -------
                                                Row(
                                                  children: [
                                                    // RatingBar.builder(
                                                    //   // unratedColor: Color(0XFF8391A1),
                                                    //   glow: false,
                                                    //   itemSize:18.0,
                                                    //  initialRating: 4,
                                                    //  minRating: 1,
                                                    //  direction: Axis.horizontal,
                                                    //  allowHalfRating: true,
                                                    //  itemCount: 5,
                                                    //  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                    //  itemBuilder: (context, _) =>
                                                    //
                                                    //      _selectedIcon != null?SvgPicture.asset("assets/images/Union.svg"):SvgPicture.asset("assets/images/Star.svg"),
                                                    //
                                                    //  //     Icon(
                                                    //  //   Icons.star,
                                                    //  //   color: Colors.amber,
                                                    //  // ),
                                                    //  onRatingUpdate: (rating) {
                                                    //    print(rating);
                                                    //  },
                                                    // ),

                                                    RatingBar(
                                                      initialRating:
                                                          double.parse(
                                                              data.intRating ??
                                                                  '0'),
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 18.0,
                                                      // unratedColor: Color(0xff8391A1),
                                                      unratedColor:
                                                          Colors.black,
                                                      ratingWidget:
                                                          RatingWidget(
                                                        full: SvgPicture.asset(
                                                          'assets/images/Star.svg',
                                                          color:
                                                              Color(0xffFFC107),
                                                          matchTextDirection:
                                                              true,
                                                        ),
                                                        half: Text(''),
                                                        empty: SvgPicture.asset(
                                                          'assets/images/Union.svg',
                                                          // color: Colors.black,
                                                          matchTextDirection:
                                                              true,
                                                        ),
                                                      ),
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),

                                                    Text(
                                                      "(${data.intRating}.0)",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: Color(
                                                              0xff8391A1)),
                                                    ),
                                                  ],
                                                ),

                                                ///--------- rating cmt -----------
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                      data.txtReview ?? '',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff161616),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          // color: Colors.black,
                                                          fontFamily:
                                                              'SEGOEUI'),
                                                    )),

                                                ///----------- rating time --------
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                      '${DateFormat('d MMMM yyyy').format(data.dtCreateddate!)} at ${data.dtCreateddate!.hour}:${data.dtCreateddate!.minute}',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff8391A1),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          // color: Colors.black,
                                                          fontFamily:
                                                              'SEGOEUI'),
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
      ),
    );
  }
}
