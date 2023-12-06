// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/custom_widgets/app_toast.dart';
import 'package:wena_partners/professional/model/booking_model.dart';
import 'package:wena_partners/professional/model/homepagecommuity_Model.dart';
import 'package:wena_partners/professional/model/joincommuity_model.dart';
import 'package:wena_partners/professional/model/profile_model.dart';


class HomeController extends GetxController{

  ///------model class name------------

  HomePageCommuityModel? homePageCommuityModel;

  JoinCommuityModel? joinCommuityModel;


  ProfileModel? profileModel;

   BookingModel? bookingModel;



  ///-------bool var------------------

  bool isHomeLoad = false;

  bool tappedError = false;


  ///------empty list-----------------


  List<HomePageCommuity> homePageCommuity = [];

  List<JoinCommuity>? joinCommuiry;



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


  ///------var-----------------

  String countryCode = "256";
  String? getCity;


  String? image;
  String? image1;
  String? image2;
  var imageFile;
  var imageFile1;
  var imageFile2;


  @override
  onInit() {
    super.onInit();
    homepageCommunity();
    joinCommunity();
    editProfile();
    RecentJobs();
  }

  loading(value) {
    isHomeLoad = value;
    tappedError = value;
    update(['home']);
  }


  ///-----------------home page commuity api---------------------------

  Future homepageCommunity() async{
    loading(true);
    var request = http.Request('GET', Uri.parse("${SERVER_ADDRESS}api/professional/getHomePageCommunity"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      // print(response.body);
      String data = response.body;
      homePageCommuityModel = HomePageCommuityModel.fromJson(json.decode(data));
      homePageCommuity = homePageCommuityModel!.data!;
      // print("professionsUnitList========>>>${homePageCommuityModel!.msg}");
    }
    else {
      loading(false);
      // print("error cause===>>${response.reasonPhrase}");
    }
  }

  ///-----------------join community api---------------------------

  Future joinCommunity() async{
    loading(true);
    var request = http.Request('GET', Uri.parse("${SERVER_ADDRESS}api/professional/getCommunityList"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      // print(response.body);
      String data = response.body;
      joinCommuityModel = JoinCommuityModel.fromJson(json.decode(data));
      joinCommuiry = joinCommuityModel!.data!;
      // print("professionsUnitList========>>>${joinCommuityModel!.msg}");
    }
    else {
      loading(false);
      // print("error cause===>>${response.reasonPhrase}");
    }
  }

  ///--------------------------post join community selected api--------------------------

  Future joinCommunitySelect({
    required communityId,
    required  professionalId,
    required BuildContext context,
  }) async {

    loading(true);
    var request = http.MultipartRequest('POST',Uri.parse("${SERVER_ADDRESS}api/professional/joinCommunity"));
    // print("-------------------post join community Api ${SERVER_ADDRESS}api/professional/joinCommunity");

    request.fields.addAll({
      'community_ids':  communityId.toString(),
      'professional_id':  professionalId.toString(),
    });

    // print("---------------------------communityId = ${communityId.toString()}");
    // print("---------------------------professionalId = ${professionalId.toString()}");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      // print("=============================post join community $jsonResponse");

      if (jsonResponse['code'] == 200) {

        // print("Success");
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomBar()));
        // _showNewVersionAvailableDialog(context);
        _showSuccessDialog(context);

        loading(false);
      }
      else if(jsonResponse['code'] == 400){
        const CircularProgressIndicator();
      }
    }
    else {
      loading(false);
      // print(response.reasonPhrase);
    }
  }



  ///-------------post api in edit profile-----------------------

  editProfile() async {

    loading(true);
    SharedPreferences sp = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/getProfessionalById'));
    // print(Uri.parse('${SERVER_ADDRESS}api/professional/getProfessionalById'));

    // print('get professsion id ${sp.getString("user_id")}');

    request.fields.addAll({
      'fk_professional': '${sp.getString("user_id")}',
      'var_fname': firstName.text.toString(),
      'var_lname': surName.text.toString(),
      'var_email': email.text.toString(),
      'var_mobile_no': phoneNo.text.toString(),
      'var_password': password.text.toString(),
      'var_country_code':countryCode.toString(),
      'var_city': getCity.toString(),
      'var_account_name':accountName.toString(),
      'var_bank_account': accountNumber.toString(),
      'var_bank_name':bankName.toString(),
      'var_bank_code':bankCode.toString(),
      'var_bank_branch_name':branchName.toString(),
      'var_image_link': imageFile.toString(),
      'var_national_id_front_link':imageFile1.toString(),
      'var_national_id_back_link':imageFile2.toString(),
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    // print(jsonResponse);
    if(response.statusCode == 200){

      // print('call edit ${jsonResponse}');

      profileModel = ProfileModel.fromJson(jsonResponse);

      if (jsonResponse['code'] == 200) {

        // print("USER_ID_SET------------${sp.getString("user_id")}");

        firstName.text = profileModel!.data!.varFname.toString();
        surName.text = profileModel!.data!.varLname.toString();
        email.text = profileModel!.data!.varEmail.toString();
        password.text = profileModel!.data!.varPassword.toString();
        phoneNo.text = profileModel!.data!.varMobileNo.toString();
        countryCode = profileModel!.data!.varCountryCode.toString();
        getCity = profileModel!.data!.varCity.toString();
        accountName.text = profileModel!.data!.varAccountName.toString();
        accountNumber.text = profileModel!.data!.varBankAccount.toString();
        bankName.text = profileModel!.data!.varBankName.toString();
        bankCode.text = profileModel!.data!.varBankCode.toString();
        branchName.text = profileModel!.data!.varBankBranchName.toString();
        imageFile = profileModel!.data!.varImageLink;
        imageFile1 = profileModel!.data!.varNationalIdFrontLink;
        imageFile2 = profileModel!.data!.varNationalIdBackLink;

        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const BottomBar()));

        // print("FIRST_NAME------------${firstName.text}");
        // print("EMAIL------------${email.text}");
        // print("PASSWORD------------${password.text}");
        // print("PHONE_NUMBER------------${phoneNo.text}");
        // print("COUNTRY_CODE------------${countryCode.toString()}");
        // print("CITY_NAME------------${getCity.toString()}");
        // print("ACCOUNT_NAME------------${accountName.text}");
        // print("ACCOUNT_NUMBER------------${accountNumber.text}");
        // print("BANK_NAME------------${bankName.text}");
        // print("BANK_CODE------------${bankCode.text}");
        // print("BRANCH_NAME------------${branchName.text}");
        // print("IMAGE------------$imageFile");
        // print("IMAGE_Front------------$imageFile1");
        // print("IMAGE_Back------------$imageFile2");

        loading(false);
      }
      else if (jsonResponse['code'] == 400) {
        const CircularProgressIndicator();
      }
    }
    else{
      loading(false);
      // print(response.reasonPhrase);
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
      desc: "join community success",
      image: const Icon(Icons.check_circle,color: Colors.green,size: 50,)
    ).show();

  }

///---------------get all recent jobs by professional id-------------------

  bool isRecentJobs = false;

  recentJobs(bool value){
    isRecentJobs = value;
    update(['recentJobs']);
    update(['topJob']);
  }


  RecentJobs() async {
    recentJobs(true);

    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = sp.getString("user_id")??'0';
    debugPrint('user id for recent job is $userId');

    var request = http.MultipartRequest('POST', Uri.parse('${SERVER_ADDRESS}api/professional/getAllRecentJobsByProfessionalId'));
    // print(Uri.parse('${SERVER_ADDRESS}api/professional/getAllRecentJobsByProfessionalId'));

    request.fields.addAll({
      'professionalId': userId,
    });

    http.StreamedResponse response = await request.send();
    final jsonResponse = jsonDecode(await response.stream.bytesToString());
    // print(jsonResponse);
    if(response.statusCode == 200){
      if (jsonResponse['code'] == 200) {
        bookingModel = BookingModel.fromJson(jsonResponse);
        recentJobs(false);
      }
      else if (jsonResponse['code'] == 400) {
        recentJobs(false);
      }
    }
    else{
      recentJobs(false);
      print(response.reasonPhrase);
    }
  }


  onJobStatusChange({required String bookingId,required  String status}) async{
    recentJobs(true);
    try {
      final response = await http.post(
          Uri.parse('${SERVER_ADDRESS}api/professional/update_booking_status'),
          body: {'booking_id': bookingId,'status': status});
      debugPrint('request is : ${response.request}');
      debugPrint('status is : ${response.statusCode}');
      debugPrint('body is : ${response.body}');
      print('bookingId $bookingId');
      print('status $status');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          RecentJobs();
        } else if(jsonResponse['code'] == 400){
          // AppToast.showToast(jsonResponse['msg']);
          recentJobs(false);
        }else {
          AppToast.showToast('Something went to wrong');
          recentJobs(false);
        }
      }
    } catch (e) {
      AppToast.showToast('Something went to wrong');
      recentJobs(false);
    }

  }


}