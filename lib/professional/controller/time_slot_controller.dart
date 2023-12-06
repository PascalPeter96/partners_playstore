import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/model/time_slot_list_class.dart';


class TimeSlotController extends GetxController {
  bool isLoading = false;
  late TimeSlotListClass timeSlotListClass;
  List<TimeSlotDetailClass> timeSlotList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTimeSlot();
  }

  loading(bool value) {
    isLoading = value;
    update();
  }

  fetchTimeSlot() async {
    timeSlotList.clear();
    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    debugPrint('user ud $userId');
    try {
      final response = await http.post(
          Uri.parse(
              '${SERVER_ADDRESS}api/professional/getAllTimeSlotsByProfessionalId'),
          body: {'professionalId': userId});
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          timeSlotListClass = TimeSlotListClass.fromJson(jsonResponse);
          timeSlotList.addAll(timeSlotListClass.timeSlotDetailClass!);
          loading(false);
        } else if (jsonResponse['code'] == 400) {
          // AppToast.showToast(jsonResponse['msg']);
          loading(false);
        } else {
          AppToast.showToast('Something went to wrong');
          loading(false);
        }
      }
    } catch (e) {
      AppToast.showToast('Something went to wrong');
      loading(false);
    }
  }

  TimeOfDay startSelectedTime = TimeOfDay.now();
  TimeOfDay endSelectedTime = TimeOfDay.now();

  addTimer(context) async {
    TimeOfDay startSelectedTime = TimeOfDay.now();
    TimeOfDay endSelectedTime = TimeOfDay.now();

    TextEditingController tcStartTime = TextEditingController();
    TextEditingController tcEndTime = TextEditingController();

    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
      title: 'Select Time',
      titleStyle: const TextStyle(
        fontSize: 18,
        color: Color(0xFF149C48),
        fontFamily: "SEGOEUI",
        fontWeight: FontWeight.w600,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select start time',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF8391A1),
              fontFamily: "SEGOEUI",
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(bottom: 8, top: 8),
            height: 40,
            // width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE8EFF3), width: 1.2)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "SEGOEUI",
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: () async {
                    final TimeOfDay? pickedS = await showTimePicker(
                        helpText: 'Select start time',
                        context: context,
                        initialTime: startSelectedTime,
                        builder: (BuildContext? context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context!)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!,
                          );
                        });
                    if (pickedS != null) {
                      startSelectedTime = pickedS;
                      tcStartTime.text =
                          '${startSelectedTime.hour.toString().padLeft(2, '0')}:${startSelectedTime.minute.toString().padLeft(2, '0')}';
                      print('start time is ${tcStartTime.text}');
                    }
                  },
                  readOnly: true,
                  controller: tcStartTime,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "TO",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8391A1),
                  fontFamily: "SEGOEUI",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const Text(
            'Select end time',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF8391A1),
              fontFamily: "SEGOEUI",
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(bottom: 8, top: 8),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE8EFF3), width: 1.2)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextFormField(
                  onTap: () async {
                    final TimeOfDay? pickedS = await showTimePicker(
                        helpText: 'Select end time',
                        context: context,
                        initialTime: endSelectedTime,
                        builder: (BuildContext? context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context!)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!,
                          );
                        });
                    if (pickedS != null) {
                      endSelectedTime = pickedS;
                      tcEndTime.text =
                          '${endSelectedTime.hour.toString().padLeft(2, '0')}:${endSelectedTime.minute.toString().padLeft(2, '0')}';
                      print('end time is ${tcEndTime.text}');
                    }
                  },
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "SEGOEUI",
                    fontWeight: FontWeight.w600,
                  ),
                  readOnly: true,
                  controller: tcEndTime,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.center,
                  // alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/3,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFF149C48),
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Cancel',style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF149C48),
                    fontFamily: "SEGOEUI",
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              ),
              const SizedBox(width: 10,),
              GestureDetector(
                onTap: (){
                  if(tcStartTime.text.isEmpty){
                    AppToast.showToast('Select start time');
                  }else if(tcEndTime.text.isEmpty){
                    AppToast.showToast('Select end time');
                  }else{
                    Get.back();
                    addTimerApi(tcStartTime.text,tcEndTime.text);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width/3,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF149C48),
                    border: Border.all(
                        color: const Color(0xFF149C48),
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Ok',style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: "SEGOEUI",
                    fontWeight: FontWeight.w600,
                  ),),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );

    // bool startTime = await _startSelectTime(context);
    // if (startTime) {
    //   bool endTime = await _endSelectTime(context);
    //   if (endTime) {
    //     addTimerApi();
    //   } else {}
    // }
  }

  Future<bool> _startSelectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        helpText: 'Select start time',
        context: context,
        initialTime: startSelectedTime,
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data:
                MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null) {
      startSelectedTime = pickedS;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _endSelectTime(BuildContext context) async {
    final TimeOfDay? pickedS = await showTimePicker(
        helpText: 'Select end time',
        context: context,
        initialTime: endSelectedTime,
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data:
                MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });

    if (pickedS != null) {
      endSelectedTime = pickedS;
      return true;
    } else {
      return false;
    }
  }

  addTimerApi(startTime,endTime) async {
    // String startTime =
    //     '${startSelectedTime.hour.toString().padLeft(2, '0')}:${startSelectedTime.minute.toString().padLeft(2, '0')}';
    // String endTime =
    //     '${endSelectedTime.hour.toString().padLeft(2, '0')}:${endSelectedTime.minute.toString().padLeft(2, '0')}';

    loading(true);

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    debugPrint('user ud $userId');

    try {
      final response = await http.post(
          Uri.parse('${SERVER_ADDRESS}api/professional/add_time_slot'),
          body: {
            'professional_id': userId,
            'start_time': startTime,
            'end_time': endTime
          });
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          fetchTimeSlot();
          AppToast.showToast(jsonResponse['msg']);
          // loading(false);
        } else {
          AppToast.showToast('Something went to wrong');
          loading(false);
        }
      }
    } catch (e) {
      AppToast.showToast('Something went to wrong');
      loading(false);
    }
  }

  removeTimer(id) async {
    loading(true);
    try {
      final response = await http.post(
          Uri.parse('${SERVER_ADDRESS}api/professional/delete_time_slot_by_id'),
          body: {
            'time_slot_id': id,
          });
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          fetchTimeSlot();
          AppToast.showToast(jsonResponse['msg']);
          // loading(false);
        } else {
          AppToast.showToast('Something went to wrong');
          loading(false);
        }
      }
    } catch (e) {
      AppToast.showToast('Something went to wrong');
      loading(false);
    }
  }
}
