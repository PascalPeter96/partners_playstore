// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_pickers/image_pickers.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/model/get_king_of_detail_model.dart';
import 'package:wena_partners/professional/view/profile/add_next_of_kin_screen.dart';


class AddNextOfKingController extends GetxController {

  ///-------bool var------------------

  bool nextOfKing = false;

  GetKingDetail? getKingDetail;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController surName = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();

  bool isPhone1 = false;

  String countryCode = "256";

  String errorText = "";

  @override
  void onInit() {
    // TODO: implement onInit
    nextOfDetail();
    super.onInit();
  }


  ///-------pick image---------------

  List<Media>? _listImagePaths1;

  List<Media>? _listImagePaths2;

  var selectedImageUrl1;
  var selectedImageUrl2;

  String? image1;
  String? image2;

  pickFromCamera1() async {
    _listImagePaths1 = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Colors.black),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));

    if(_listImagePaths1!.isNotEmpty){

        image1 = '';
        selectedImageUrl1 = _listImagePaths1![0].path;
        update(['addNextOfKing']);
        print('image=======================>$selectedImageUrl1');

    }else{
      print('null');
    }
  }

  pickFromCamera2() async {
    _listImagePaths2 = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Colors.black),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));

    if(_listImagePaths2!.isNotEmpty){

        image2 = '';
        selectedImageUrl2 = _listImagePaths2![0].path;
        update(['addNextOfKing']);
        print('image=======================>$selectedImageUrl2');

    }else{
      print('null');
    }
  }


  loading(value) {
    nextOfKing = value;
    update(['addNextOfKing']);
  }


  ///-------------post add NextOfKING  api---------------------------------


  Future addNextOfKingDetail({
    required String id,
    required String fName,
    required String lName,
    required String countryCode,
    required String mobileNo,
    required String frontImage,
    required String backImage,
    required BuildContext context,
  }) async {
    print('id : $id');
    print('fName : $fName');
    print('lName : $lName');
    print('countryCode : $countryCode');
    print('mobileNo : $mobileNo');
    print('frontImage : $frontImage');
    print('backImage : $backImage');

    loading(true);

    var request = http.MultipartRequest('POST', Uri.parse("${SERVER_ADDRESS}api/professional/add_kin_of_details"));

    print("-------------------Add Next Of King Api ${SERVER_ADDRESS}api/professional/add_kin_of_details");

    request.fields.addAll({
      'professionalId': id.toString(),
      'var_kin_fname': fName.toString(),
      'var_kin_lname': lName.toString(),
      'var_kin_country_code': countryCode.toString(),
      'var_kin_mobile_no': mobileNo.toString(),
    });

    request.files.add(await http.MultipartFile.fromPath('var_kin_national_id_front', frontImage.toString()));

    request.files.add(await http.MultipartFile.fromPath('var_kin_national_id_back', backImage.toString()));

    http.StreamedResponse response = await request.send();

    print('add project status code is : ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("=============================addProject $jsonResponse");

      if (jsonResponse['code'] == 200) {

        // box1('Add King_of_details success','success',Icon(Icons.check_circle,size: 50,color: Colors.green,),Colors.green);
        box1('Record Updated Successfully.','success',Colors.green);

        loading(false);
        update(['addNextOfKing']);
      } else if (jsonResponse['code'] == 400) {

        // box1('Data Not Add','Wrong',Icon(Icons.close,size: 50,color: Colors.red,),Colors.red);
        box1('Data Not Add','Wrong',Colors.red);
        loading(false);
        update(['addNextOfKing']);
        // const CircularProgressIndicator();
      }
    } else {
      // box1(response.reasonPhrase,'Wrong',Icon(Icons.close,size: 50,color: Colors.red,),Colors.red);
      box1(response.reasonPhrase,'Wrong',Colors.red);
      loading(false);
      print(response.reasonPhrase);
    }
  }


  ///----------get_kin_details_by_professionalId-----------------------------------

  nextOfDetail() async {

    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/get_kin_details_by_professional_id'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/get_kin_details_by_professional_id'));

    request.fields.addAll({
      'professionalId': '${sp.getString("user_id")}',
      'var_kin_fname': firstName.text,
      'var_kin_lname': surName.text,
      'var_kin_country_code': countryCode,
      'var_kin_mobile_no': phoneNo.text,
      'var_kin_national_id_front':  selectedImageUrl1.toString(),
      'var_kin_national_id_back':  selectedImageUrl2.toString(),
    });

    // if (selectedImageUrl1.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('var_kin_national_id_front', selectedImageUrl1));
    // }
    //
    // if (selectedImageUrl2.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('var_kin_national_id_back', selectedImageUrl2));
    // }

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);

    if(response.statusCode == 200){

      getKingDetail = GetKingDetail.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {

        print("USER_ID_SET------------${sp.getString("user_id")}");

        firstName.text = getKingDetail!.data!.varKinFname.toString();
        surName.text = getKingDetail!.data!.varKinLname.toString();
        countryCode = getKingDetail!.data!.varKinCountryCode.toString();
        phoneNo.text = getKingDetail!.data!.varKinMobileNo.toString();
        selectedImageUrl1 = getKingDetail!.data!.varKinNationalIdFront;
        selectedImageUrl2 = getKingDetail!.data!.varKinNationalIdBack;


        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const BottomBar()));

        print("firstName------------${firstName.text}");
        print("surName------------${surName.text}");
        print("countryCode------------${countryCode.toString()}");
        print("phoneNo------------${phoneNo.text}");
        print("imageFile1------------${selectedImageUrl1.toString()}");
        print("imageFile2------------${selectedImageUrl2.toString()}");

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


}

void box1(error,error1,color) {
  Get.defaultDialog(
    title: '',
    content:  Column(
      children:  [
       Icon(Icons.check_circle,size: 50,color: Colors.green,),
        SizedBox(height: 15,),
        Text(
          '$error1',
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
          '$error',
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
            primary: color, // background
          ),
          onPressed: (){
            Get.back();
            // Get.back();
            Get.delete<AddNextOfKingController>();
            Get.off(const AddNextOfKinScreen());
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
