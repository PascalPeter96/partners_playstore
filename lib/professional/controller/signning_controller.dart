// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/model/ProfessionsUnitList_model.dart';
import 'package:wena_partners/professional/model/Professions_repairModel.dart';
import 'package:wena_partners/professional/model/citydata_model.dart';
import 'package:wena_partners/professional/model/profile_model.dart';
import 'package:wena_partners/professional/model/selected_professions_detail.dart';
import 'package:wena_partners/professional/model/signup_model.dart';
import 'package:wena_partners/professional/view/auth_screen/otp_screen.dart';

class SigningController extends GetxController {
  ///------model class name------------

  CityData? cityData;

  ProfessionsUnitListModel? professionsUnitListModel;

  ProfessionsModel? professionsModel;

  ProfileModel? profileModel;

  ///-------bool var------------------

  bool isHomeLoad = false;

  ///------empty list-----------------

  List<City> city = [];

  List<UnitList> unitList = [];

  List<Repair> repair = [];

  List<ProfessionsDetailClass> professionsList = [];

  ///------var-----------------

  // String? firstname;
  String countryCode = "256";
  String? getCity;

  ///----------------------- text controller----------------------------------

  final TextEditingController firstName = TextEditingController();
  final TextEditingController surName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController phoneNo1 = TextEditingController();
  final TextEditingController phoneNo2 = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController Price = TextEditingController();
  final TextEditingController Price1 = TextEditingController();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController bankCode = TextEditingController();
  final TextEditingController branchName = TextEditingController();

  @override
  onInit() {
    super.onInit();
    cityName();
    professions();
    professionsRepair();
    editProfile();
  }

  loading(value) {
    isHomeLoad = value;
    update(['signing']);
  }

  ///----------------get city api--------------------------

  Future cityName() async {
    loading(true);
    var request = http.Request('GET',
        Uri.parse("${SERVER_ADDRESS}api/professional/getCityDataByUganda"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      print(response.body);
      String data = response.body;
      cityData = CityData.fromJson(json.decode(data));
      city = cityData!.data!;
      print("cityName===>>>${cityData!.msg}");
    } else {
      loading(false);
      print("error cause===>>${response.reasonPhrase}");
    }
  }

  ///-----------------get professionsUnit api---------------------------

  Future professions() async {
    loading(true);
    var request = http.Request(
        'GET', Uri.parse("${SERVER_ADDRESS}api/professional/getUnitList"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      print(response.body);
      String data = response.body;
      professionsUnitListModel =
          ProfessionsUnitListModel.fromJson(json.decode(data));
      unitList = professionsUnitListModel!.data!;
      print("professionsUnitList========>>>${professionsUnitListModel!.msg}");
    } else {
      loading(false);
      print("error cause===>>${response.reasonPhrase}");
    }
  }

  ///-----------------get professionsRepair api---------------------------
  Future professionsRepair() async {
    loading(true);
    var request = http.Request(
        'GET', Uri.parse("${SERVER_ADDRESS}api/professional/getServiceList"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      print(response.body);
      String data = response.body;
      professionsModel = ProfessionsModel.fromJson(json.decode(data));
      repair = professionsModel!.data!;
      for (var data in repair) {
        professionsList.add(
            ProfessionsDetailClass(id: data.intGlcode!, name: data.varTitle!));
      }
      print("professionsUnitList========>>>${professionsModel!.msg}");
    } else {
      loading(false);
      print("error cause===>>${response.reasonPhrase}");
    }
  }

  ///-------------post signup  api---------------------------------

  Future registerUser({
    required String firstName,
    required String surName,
    required String email,
    required String countryCode,
    required String phoneNo,
    required String getCity,
    required File? image,
    required File? image1,
    required File? image2,
    required String mode,
    required String accountname,
    required String bankname,
    required String Bankcode,
    required String Branchname,
    required String selectNetwork,
    required String paymentPhoneNo,
    required String countryPhone,
    required String serviceId,
    required List<SelectedProfessionsDetailClass> selectedProfessionDetailClass,
    required BuildContext context,
    required String accountNumber,
    required String password,
  }) async {
    Map data = {
      'firstName': firstName,
      'surName': surName,
      'email': email,
      'countryCode': countryCode,
      'phoneNo': phoneNo,
      'getCity': getCity,
      'image': image,
      'image1': image1,
      'image2': image2,
      'mode': mode,
      'accountname': accountname,
      'bankname': bankname,
      'Bankcode': Bankcode,
      'Branchname': Branchname,
      'selectNetwork': selectNetwork,
      'paymentPhoneNo': paymentPhoneNo,
      'countryPhone': countryPhone,
      'serviceId': serviceId,
      'selectedProfessionDetailClass': selectedProfessionDetailClass,
      'context': context,
      'accountNumber': accountNumber,
      'password': password,
    };

    loading(true);
    try {
      final response = await http.post(
          Uri.parse('${SERVER_ADDRESS}api/professional/generateOtpByMobileNo'),
          body: {
            'var_mobile_no': phoneNo,
            'var_country_code': countryCode,
            'var_type': 'S'
          });
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          loading(false);
          print('data send to otp is $data');
          Get.to(()=>OtpScreen());
        } else if (jsonResponse['code'] == 400) {
          AppToast.showToast(jsonResponse['msg']);
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

    //// --------------

  }

  // Future registerUser({
  //   required String firstName,
  //   required String surName,
  //   required String email,
  //   required String countryCode,
  //   required String phoneNo,
  //   required String getCity,
  //   required File? image,
  //   required File? image1,
  //   required File? image2,
  //   required String mode,
  //   required String accountname,
  //   required String bankname,
  //   required String Bankcode,
  //   required String Branchname,
  //   required String selectNetwork,
  //   required String paymentPhoneNo,
  //   required String countryPhone,
  //   required String serviceId,
  //   required List<SelectedProfessionsDetailClass> selectedProfessionDetailClass,
  //   required BuildContext context,
  //   required String accountNumber,
  //   required String password,
  // }) async {
  //
  //   List<String> professionDetailIds = [];
  //
  //   for (int i = 0; i < selectedProfessionDetailClass.length; i++) {
  //     var data = selectedProfessionDetailClass[i];
  //     professionDetailIds.add('"${data.id}"');
  //   }
  //
  //   String serviceDetail = '{';
  //   for (int i = 0; i < selectedProfessionDetailClass.length; i++) {
  //     var data = selectedProfessionDetailClass[i];
  //     serviceDetail +=
  //     '"${data.id}":{"fk_unit":${data.servicePer!.intGlcode},"var_price":${data.priceController.text}}${i == selectedProfessionDetailClass.length - 1 ? '' : ','}';
  //   }
  //   serviceDetail += '}';
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //
  //   print('var_fname : $firstName');
  //   print('var_lname : $surName');
  //   print('var_email : $email');
  //   print('var_country_code : $countryCode');
  //   print('var_mobile_no : $phoneNo');
  //   print('var_city : $getCity');
  //   print('fk_service_ids : $professionDetailIds');
  //   print('service_details : $serviceDetail');
  //   print('payment_mode : $mode');
  //   print('var_bank_account : $accountNumber');
  //   print('var_bank_name : $bankname');
  //   print('var_account_name : $accountname');
  //   print('var_bank_code : $Bankcode');
  //   print('var_bank_branch_name : $Branchname');
  //   print('fk_network_id : ${1}');
  //   print('var_mobile_money_mobile_no : $paymentPhoneNo');
  //   print('var_reg_mobile_money_mobile_no : $countryPhone');
  //   print('device_id : $token');
  //   print('var_password : $password');
  //   // print('var_image : ${image!.path}');
  //   // print('var_national_id_front : ${image1!.path}');
  //   // print('var_national_id_back : ${image2!.path}');
  //
  //
  //   loading(true);
  //
  //   var request = http.MultipartRequest('POST', Uri.parse("${SERVER_ADDRESS}api/professional/professional_signup"));
  //
  //   print("-------------------Signup_Api ${SERVER_ADDRESS}api/professional/professional_signup");
  //
  //
  //   Map<String, String> body = {
  //     'var_fname': firstName,
  //     'var_lname': surName,
  //     'var_email': email,
  //     'var_country_code': countryCode,
  //     'var_mobile_no': phoneNo,
  //     'var_city': getCity,
  //     'fk_service_ids': professionDetailIds.toString(),
  //     'service_details': serviceDetail,
  //     'payment_mode': mode,
  //     'var_bank_account': accountNumber,
  //     'var_bank_name': bankname,
  //     'var_account_name': accountname,
  //     'var_bank_code': Bankcode,
  //     'var_bank_branch_name': Branchname,
  //     'fk_network_id': '1',
  //     'var_mobile_money_mobile_no': paymentPhoneNo,
  //     'var_reg_mobile_money_mobile_no': countryPhone,
  //     'device_id': token,
  //     'var_password': password,
  //   };
  //
  //   print('after body service id is $professionDetailIds');
  //
  //   request.fields.addAll(body);
  //
  //   if (image != null) {
  //     request.files.add(await http.MultipartFile.fromPath('var_image', image.path));
  //   }
  //
  //   if (image1 != null) {
  //     request.files.add(await http.MultipartFile.fromPath('var_national_id_front', image1.path));
  //   }
  //
  //   if (image2 != null) {
  //     request.files.add(await http.MultipartFile.fromPath('var_national_id_back', image2.path));
  //   }
  //
  //   if(selectedProfessionDetailClass.isNotEmpty){
  //     for (int i = 0; i < selectedProfessionDetailClass.length; i++) {
  //       var data = selectedProfessionDetailClass[i];
  //       professionDetailIds.add(data.id);
  //       request.files.add(await http.MultipartFile.fromPath('var_certificate[${data.id}]', data.image!.path));
  //     }
  //   }
  //
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   print('sign up status code is : ${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(await response.stream.bytesToString());
  //     print("=============================Signup $jsonResponse");
  //
  //     if (jsonResponse['code'] == 200) {
  //
  //       SharedPreferences sp = await SharedPreferences.getInstance();
  //       sp.setString("user_id", jsonResponse['data']['int_glcode'].toString());
  //
  //       print("REGISTER_SCREEN_USER_ID_SET------------${sp.getString("user_id")}");
  //
  //       Get.to( const BottomBar());
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
  //
  //
  // }

  ///-------------post api in edit profile-----------------------

  editProfile() async {
    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST',
        Uri.parse('${SERVER_ADDRESS}api/professional/getProfessionalById'));
    print(Uri.parse('${SERVER_ADDRESS}api/professional/getProfessionalById'));

    request.fields.addAll({
      'fk_professional': '${sp.getString("user_id")}',
      'var_fname': firstName.text.toString(),
      'var_lname': surName.text.toString(),
      'var_email': email.text.toString(),
      'var_mobile_no': phoneNo.text.toString(),
      'var_password': password.text.toString(),
      'var_country_code': countryCode.toString(),
      'var_city': getCity.toString(),
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    print(jsonResponse);
    if (response.statusCode == 200) {
      profileModel = ProfileModel.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {
        print("USER_ID_SET------------${sp.getString("user_id")}");

        firstName.text = profileModel!.data!.varFname.toString();
        surName.text = profileModel!.data!.varLname.toString();
        email.text = profileModel!.data!.varEmail.toString();
        password.text = profileModel!.data!.varPassword.toString();
        phoneNo.text = profileModel!.data!.varMobileNo.toString();
        countryCode = profileModel!.data!.varCountryCode.toString();
        getCity = profileModel!.data!.varCity.toString();
        accountNumber.text = profileModel!.data!.varAccountName.toString();

        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const BottomBar()));

        print("COUNTRY_CODE------------${countryCode.toString()}");
        print("CITY_NAME------------${getCity.toString()}");

        loading(false);
      } else if (jsonResponse['code'] == 400) {
        const CircularProgressIndicator();
      }

      print("PROFILE--------------$profileModel");
    } else {
      loading(false);
      print(response.reasonPhrase);
    }
  }
}
