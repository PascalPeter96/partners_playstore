/*
import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController{

  // HomeModel? homeModel;
  bool isHomeLoad = false;

  @override
  onInit() {
    super.onInit();
    HomeApi();
  }

  loading(value) {
    isHomeLoad = value;
    update(['home']);
  }

  Future HomeApi() async{
    loading(true);
    var request = http.Request('GET', Uri.parse("http://utcit.in/wena/api/professional/getCityDataByUganda"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      print(response.body);
      String data = response.body;
    }
    else {
      loading(false);
      print("error cause===>>${response.reasonPhrase}");
    }
  }
}
*/
