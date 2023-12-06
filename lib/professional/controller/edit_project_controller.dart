// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/model/edit_project_model.dart';
import 'package:wena_partners/professional/view/profile/myproject_screen.dart';
import 'my_project_controller.dart';


class EditProjectController extends GetxController{

  ///-------bool var------------------

  bool isHomeLoad = false;

  List<Edit>? edit = [];

  EditProjectModel? editProjectModel;

  String? intglcode;

  EditProjectController(this.intglcode,{Key? key});


  loading(value) {
    isHomeLoad = value;
    update(['Edit']);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    editProject();
    super.onInit();
  }



  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? chosenValue = 'Admin';


  var imageFile1;

  String? image1;

  bool imageError1 = false;

  getFromGallery1() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // setState(() {
        image1 = '';
        imageError1 = false;
        imageFile1 = File(pickedFile.path);
        update();
      // });
    }
  }





  // updateProject({
  //   selectedImageUrl1,
  //   chosenValue4,
  // }) async {
  //
  //   loading(true);
  //
  //   var request = http.MultipartRequest('POST', Uri.parse("${SERVER_ADDRESS}api/professional/getProjectById"));
  //   print("-------------------update ${SERVER_ADDRESS}api/professional/getProjectById");
  //
  //
  //   Map<String, String> body = {
  //     'var_title': titleController.text,
  //     'fk_service': chosenValue4.toString(),
  //     'txt_description': descriptionController.text,
  //   };
  //
  //
  //   if (selectedImageUrl1 != null) {
  //     request.files.add(await http.MultipartFile.fromPath('var_image_link', selectedImageUrl1.path));
  //   }
  //
  //
  //   request.fields.addAll(body);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   print('sign up status code is : ${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(await response.stream.bytesToString());
  //     print("=============================Edit Project $jsonResponse");
  //     print('response ${jsonResponse['msg']}');
  //     if (jsonResponse['code'] == 200) {
  //
  //       loading(false);
  //     }
  //     else if (jsonResponse['code'] == 400) {
  //       const CircularProgressIndicator();
  //     }
  //   }
  //   else {
  //     loading(false);
  //     print(response.reasonPhrase);
  //   }
  //
  // }

///-------------- edit project api===========
  editProject() async {

    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/getProjectById'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/getProjectById'));

    request.fields.addAll({
      // 'fk_professional': '${sp.getString("user_id")}',
      // 'project_id': '59',
      'project_id': intglcode.toString(),
      'var_title': titleController.text,
      'fk_service': chosenValue.toString(),
      'txt_description': descriptionController.text,
      'var_image_link':  imageFile1.toString(),
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);

    if(response.statusCode == 200){

      editProjectModel = EditProjectModel.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {

        print("USER_ID_SET------------${sp.getString("user_id")}");

        titleController.text = editProjectModel!.data!.first.varTitle.toString();
        // chosenValue = editProjectModel!.data!.first.varTitle.toString();
        // chosenValue = editProjectModel!.data!.first.varTitle.toString();
        descriptionController.text = editProjectModel!.data!.first.txtDescription.toString();
        imageFile1 = editProjectModel!.data!.first.varImageLink;


        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const BottomBar()));

        print("title------------${titleController.text}");
        print("Description------------${descriptionController.text}");
        print("fk_service------------${chosenValue.toString()}");
        print("project_id------------${intglcode.toString()}");
        print("var_image_link------------${imageFile1.toString()}");
        // print("IMAGE_Front------------$imageFile1");

        loading(false);
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


///------------------ update project api----------------




  updateProject({selectedImageUrl}) async {
    loading(true);

    SharedPreferences sp = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/update_project'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/update_project'));

    request.fields.addAll({
      'fk_professional': '${sp.getString("user_id")}',
      // 'professional_id': '288',
      'var_title': titleController.text,
      'fk_service': chosenValue.toString(),
      'txt_description': descriptionController.text,
      'project_id': intglcode.toString(),
    });


    if (selectedImageUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('var_image', selectedImageUrl.toString()));
    }

    http.StreamedResponse response = await request.send();

    print('add project status code is : ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("=============================addProject $jsonResponse");

      if (jsonResponse['code'] == 200) {

        box();
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

void box() {
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
          'Add Project update success',
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