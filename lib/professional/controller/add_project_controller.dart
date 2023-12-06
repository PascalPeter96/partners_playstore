// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/controller/my_project_controller.dart';
import 'package:wena_partners/professional/view/profile/myproject_screen.dart';


class AddProjectController extends GetxController {
  ///-------bool var------------------

  bool isHomeLoad = false;

  loading(value) {
    isHomeLoad = value;
    update(['project']);
  }

  ///-------------post add project  api---------------------------------

  // Future addProject({
  //   required String id,
  //   required String title,
  //   required String service,
  //   required File? image1,
  //   required File? image2,
  //   required String description,
  //   required BuildContext context,
  // })
  // async {
  //
  //   loading(true);
  //
  //   var request = http.MultipartRequest('POST',Uri.parse("${SERVER_ADDRESS}api/professional/add_project"));
  //
  //   print("-------------------Add Project api ${SERVER_ADDRESS}api/professional/add_project");
  //
  //   request.fields.addAll({
  //     'professional_id': id.toString(),
  //     'var_title':  title.toString(),
  //     'fk_service': service.toString(),
  //     'var_image[0]': image1!.path,
  //     'var_image[1]': image2!.path,
  //     'txt_description': description.toString(),
  //   });
  //
  //   http.StreamedResponse response = await request.send();
  //
  //
  //   if (image1 != null) {
  //     request.files.add(await http.MultipartFile.fromPath('var_image[0]', image1.path));
  //   }
  //
  //   if (image2 != null) {
  //     request.files.add(await http.MultipartFile.fromPath('var_image[1]', image2.path));
  //   }
  //
  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(await response.stream.bytesToString());
  //     print("=============================register $jsonResponse");
  //
  //     if (jsonResponse['code'] == 200) {
  //
  //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProjectScreen()));
  //
  //       // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OtpScreen(phoneNo.toString(),jsonResponse['data']['var_otp'])), (Route<dynamic> route) => false);
  //
  //       _showSuccessDialog(context);
  //
  //       loading(false);
  //     }
  //     else if(jsonResponse['code'] == 400){
  //       const CircularProgressIndicator();
  //     }
  //   }
  //   else {
  //     loading(false);
  //     print(response.reasonPhrase);
  //   }
  // }

  Future addProject({
    required String id,
    required String title,
    required String service,
    required String image1,
    required String description,
    required BuildContext context,
  }) async {
    print('id : $id');
    print('title : $title');
    print('service : $service');
    print('image1 : $image1');
    print('description : $description');

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString('user_id')??'0';
    debugPrint('user ud $userId');

    loading(true);

    var request = http.MultipartRequest(
        'POST', Uri.parse("${SERVER_ADDRESS}api/professional/add_project"));

    print(
        "-------------------Add Project Api ${SERVER_ADDRESS}api/professional/add_project");

    request.fields.addAll({
      'professional_id': userId,
      'var_title': title.toString(),
      'fk_service': service.toString(),
      'txt_description': description.toString(),
    });

    if (image1.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('var_image', image1));
    }

    http.StreamedResponse response = await request.send();

    print('add project status code is : ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("=============================addProject $jsonResponse");

      if (jsonResponse['code'] == 200) {
        box1();

        loading(false);
        update(['project']);
      } else if (jsonResponse['code'] == 400) {
        const CircularProgressIndicator();
      }
    } else {
      loading(false);
      print(response.reasonPhrase);
    }
  }


}

void box1() {
  Get.defaultDialog(
    title: '',
    content:  Column(
      children: const [
        Icon(Icons.check_circle,color: Colors.green,size: 50,),
         SizedBox(height: 15,),
         Text(
           'Success',
           style: TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 20,
             color: Colors.green,
             fontFamily: 'SEGOEUI',
             height: 1.3,
           ),
         ),
        SizedBox(height: 15,),
         Text(
           'Add Project success',
           style: TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 20,
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
          Get.back();
          Get.delete<MyProjectController>();
          Get.off(const MyProject());
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
