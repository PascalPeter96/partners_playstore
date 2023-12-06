// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/model/booking_model.dart';

class BookingController extends GetxController {

  ///------model class name------------
  BookingModel? bookingModel;

  ///------empty list-----------------

  List<Booking> booking = [];

  ///-------bool var------------------

  bool isHomeLoad = false;

  ///--------------var --------------------

  var index = 0;


  @override
  onInit() {
    super.onInit();
    BookingJobs();
  }

  loading(value) {
    isHomeLoad = value;
    update(['Booking']);
  }


  ///-------------get all jobs status-----------------------

  BookingJobs() async {
    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/getAllJobsByStatus'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/getAllJobsByStatus'));

    request.fields.addAll({
      // 'professionalId': '${sp.getString("user_id")}',
      'professionalId': '5',
      // 'status': "C",
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);
    if(response.statusCode == 200){

      bookingModel = BookingModel.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {

        print("USER_ID_SET------------${sp.getString("user_id")}");
        print("int_glcode---------------${bookingModel!.data[0].intGlcode.toString()}");


        loading(false);
      }
      else if (jsonResponse['code'] == 400) {
        // showSuccessDialog(context);

        const CircularProgressIndicator();
      }
    }
    else{
      loading(false);
      print(response.reasonPhrase);
    }
  }

  // showSuccessDialog(BuildContext context) {
  //   Alert(
  //       context: context,
  //       title: "Wrong",style: const AlertStyle(
  //       titleStyle: TextStyle(
  //         fontWeight: FontWeight.w600,
  //         fontSize: 20,
  //         color: Colors.red,
  //         fontFamily: 'SEGOEUI',
  //         height: 1.3,
  //       )
  //   ),
  //       desc: "Data Not Found",
  //       image: const Icon(Icons.close,color: Colors.red,size: 50,)
  //   ).show();
  // }

}
