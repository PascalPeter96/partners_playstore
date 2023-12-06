import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/view/auth_screen/password_change_successful_screen.dart';


class ForgetPassController extends GetxController{

  bool isLoadpass = false;
  var fdata;

  loading(value) {
    isLoadpass = value;
    update(['pass']);
  }

  Future ForgetPassword({password}) async{
    print("password====>>>$password");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var professionalId = prefs.getString("professionalId");
    loading(true);
    var headers = {
      'Cookie': 'PHPSESSID=d9fdf449d1092389f662578b96cbeda6'
    };
    var request = http.MultipartRequest('POST', Uri.parse("${SERVER_ADDRESS}api/professional/changePassword"));
    request.fields.addAll({
      'professionalId': professionalId.toString(),
      'var_password': password.toString()
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      loading(false);
      print(response.body);
      String data = response.body;
      fdata = json.decode(data);
      print("send otp data is====>>>$data");
      if(fdata['code'] == 200){
        Get.to(const PasswordChangedSuccessful());
      }else{
        box(errorMsg: fdata['msg']);
      }
      // joinCommuityModel = JoinCommuityModel.fromJson(json.decode(data));
      // joinCommuiry = joinCommuityModel!.data!;
      // print("professionsUnitList========>>>${joinCommuityModel!.msg}");
    }
    else {
      loading(false);
      print(response.reasonPhrase);
      box(errorMsg: response.reasonPhrase);
    }
  }

  void box({errorMsg}) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          const Icon(Icons.close,color: Colors.red,size: 50,),
          const SizedBox(height: 15,),
          const Text(
            'Wrong',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.red,
              fontFamily: 'SEGOEUI',
              height: 1.3,
            ),
          ),
          const SizedBox(height: 15,),
          Text(
            errorMsg,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
              fontFamily: 'SEGOEUI',
              height: 1.3,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background
            ),
            onPressed: (){
              Get.back();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )

      ],
    );
  }
}