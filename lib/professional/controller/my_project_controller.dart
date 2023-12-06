// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/model/my_project_model.dart';


class MyProjectController extends GetxController {


  ///------model class name------------

  GetMyProjectModel? getMyProjectModel;


  ///------empty list-----------------


  ///-------bool var------------------

  bool isHomeLoad = false;



  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    await GetProject();
  }

  loading(value) {
    isHomeLoad = value;
    update(['getProject']);
  }



  ///-----------------get professionsUnit api---------------------------


  GetProject() async {
    print("Test");
    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    debugPrint('user ud $userId');
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final response = await http.post(Uri.parse('${SERVER_ADDRESS}api/professional/getAllProjectByProfessionalId'),
          body: {
            'professionalId': userId,
            // 'professionalId': '288',
          });

      print('print ${response.body}');

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == 200) {

        getMyProjectModel = GetMyProjectModel.fromJson(jsonResponse);

        update(['getProject']);

        // firstName.text = data?.varFname ?? '';

      }
      loading(false);
    } catch (e) {
      loading(false);
    }
  }



}
