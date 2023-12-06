// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/model/cancel_booking_id_model.dart';
import 'package:wena_partners/professional/model/completed_booking_model.dart';
import 'package:wena_partners/professional/model/get_booking_id_model.dart';


class GetBookingIdController extends GetxController {

  ///------model class name------------

  GetBookingModel? getBookingModel;

  CancelBookingIdModel? cancelBookingIdModel;

  CompleteBookingIdModel? completeBookingIdModel;


  ///-------bool var------------------

  bool isHomeLoad = false;

  String? glCode;

  GetBookingIdController(this.glCode,{Key? key});

  @override
  onInit() {
    super.onInit();
    GetBookingId();
  }

  loading(value) {
    isHomeLoad = value;
    update(['GetBooking']);
  }



  ///-------------get booking id-----------------------


  GetBookingId() async {

    loading(true);

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/getBookingById'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/getBookingById'));

    request.fields.addAll({
      'booking_id': glCode.toString(),
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);
    if(response.statusCode == 200){

      if (jsonResponse['code'] == 200) {
        getBookingModel = GetBookingModel.fromJson(jsonResponse);
        // getBookingModel!.data!.varServiceArr!.add(VarServiceArr(
        //   serviceTitle: 'Ac Repair',
        //     unitTitle: 'Per Dat',
        //     varPrice: 400
        // ));
        // getBookingModel!.data!.varServiceArr!.add(VarServiceArr(
        //     serviceTitle: 'Ac Repair',
        //     unitTitle: 'Per Dat',
        //     varPrice: 400
        // ));
        // getBookingModel!.data!.varServiceArr!.add(VarServiceArr(
        //     serviceTitle: 'Ac Repair',
        //     unitTitle: 'Per Dat',
        //     varPrice: 400
        // ));
        // getBookingModel!.data!.varServiceArr!.add(VarServiceArr(
        //     serviceTitle: 'Ac Repair',
        //     unitTitle: 'Per Dat',
        //     varPrice: 400
        // ));
        print("BOOKING_ID----------------------${glCode.toString()}");

        loading(false);
      }
      else if (jsonResponse['code'] == 400) {
        AppToast.showToast(jsonResponse['msg']);
        loading(false);
        // const CircularProgressIndicator();
      }
    }
    else{
      loading(false);
      print(response.reasonPhrase);
    }
  }


  ///--------------cancel booking id------------


  CancelBookingID(BuildContext context) async {

    loading(true);

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/cancelBookingById'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/cancelBookingById'));

    request.fields.addAll({
      'booking_id': glCode.toString(),
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);
    if(response.statusCode == 200){

      cancelBookingIdModel = CancelBookingIdModel.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {

        print("CANCEL_BOOKING_ID----------------------${glCode.toString()}");

        loading(false);

        // Get.put(const OrderScreen());
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const OrderScreen()), (Route<dynamic> route) => false);

        _showSuccessDialog(context);



      }
      else if (jsonResponse['code'] == 400) {
        const CircularProgressIndicator();
      }
    }
    else{
      loading(false);
      print(response.reasonPhrase);
    }
  }

  ///--------------complete booking id------------

  CompletedBookingID(BuildContext context) async {

    loading(true);

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/completedBookingById'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/completedBookingById'));

    request.fields.addAll({
      'booking_id': glCode.toString(),
    });

    http.StreamedResponse response = await request.send();

    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);
    if(response.statusCode == 200){

      completeBookingIdModel = CompleteBookingIdModel.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {

        print("COMPLETED_BOOKING_ID----------------------${glCode.toString()}");

        loading(false);

        // Get.put(const OrderScreen());

        // Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderScreen()));

        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const OrderScreen()), (Route<dynamic> route) => false);
        // _showSuccessDialog(context);

      }
      else if (jsonResponse['code'] == 400) {

        const CircularProgressIndicator();
      }
    }
    else{
      loading(false);
      print(response.reasonPhrase);
    }
  }
  _showSuccessDialog(BuildContext context) {
    Alert(
        context: context,
        title: "Success",style: const AlertStyle(
        titleStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.green,
          fontFamily: 'SEGOEUI',
          height: 1.3,
        )
    ),
        desc: "completed BookingBy Id",
        image: const Icon(Icons.check_circle,color: Colors.green,size: 50,)
    ).show();
  }

}
