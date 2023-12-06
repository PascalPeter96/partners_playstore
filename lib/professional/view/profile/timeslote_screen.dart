import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wena_partners/professional/controller/time_slot_controller.dart';


class TimeSlot extends StatefulWidget {
  const TimeSlot({Key? key}) : super(key: key);

  @override
  State<TimeSlot> createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TimeSlotController>(
          init: TimeSlotController(),
          builder: (controller) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xFF149C48),
                child: const Icon(Icons.add),
                onPressed: () {
                  controller.addTimer(context);
                },
              ),
              body: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
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
                        const Text(
                          "Time Slot",
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
                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(
                      indent: 5,
                      endIndent: 5,
                      color: Color(0xFFD9D9D9),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: controller.isLoading
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF149C48),
                        ),
                      )
                          : controller.timeSlotList.isEmpty
                          ? const Center(
                        child: Text('No time slot found',style:TextStyle(
                          fontSize: 17,
                          color: Color(0xFF8391A1),
                          fontFamily: "SEGOEUI",
                          fontWeight: FontWeight.w600,
                        ),),
                      )
                          : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.timeSlotList.length,
                          itemBuilder:
                              (BuildContext context, int index) {
                            var data = controller.timeSlotList[index];
                            var startHour =
                            data.startTime?.split(':')[0];
                            var startMin =
                            data.startTime?.split(':')[1];
                            var starTime = DateFormat("h:mm a").format(
                                DateTime(
                                    2022,
                                    01,
                                    01,
                                    int.parse(startHour ?? '0'),
                                    int.parse(startMin ?? '0')));

                            var endHour = data.endTime?.split(':')[0];
                            var endMin = data.endTime?.split(':')[1];
                            var endTime = DateFormat("h:mm a").format(
                                DateTime(
                                    2022,
                                    01,
                                    01,
                                    int.parse(endHour ?? '0'),
                                    int.parse(endMin ?? '0')));
                            print('start time : $starTime');
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 8, top: 8),
                                        height: 40,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                8),
                                            border: Border.all(
                                                color: const Color(
                                                    0xFFE8EFF3),
                                                width: 1.2)),
                                        child: Center(
                                          child: Text(
                                            starTime,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontFamily: "SEGOEUI",
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin:
                                        const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: const Text(
                                          "TO",
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xFF8391A1),
                                            fontFamily: "SEGOEUI",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 10),
                                        height: 40,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          border: Border.all(
                                              color: const Color(
                                                  0xFFE8EFF3),
                                              width: 1.2),
                                        ),
                                        child: Center(
                                            child: Text(
                                              // "02:00 PM",
                                              endTime,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontFamily: "SEGOEUI",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.removeTimer(
                                            data.intGlcode ?? '0');
                                      },
                                      child: Container(
                                        margin:
                                        const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5),
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                50),
                                            border: Border.all(
                                                color: const Color(
                                                    0xFFFF6464),
                                                width: 1)),
                                        child: const Center(
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Color(0xFFFF6464),
                                                  fontSize: 18),
                                            )),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
