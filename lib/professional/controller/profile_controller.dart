// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/main.dart';
import 'package:wena_partners/professional/model/ProfessionsUnitList_model.dart';
import 'package:wena_partners/professional/model/Professions_repairModel.dart';
import 'package:wena_partners/professional/model/citydata_model.dart';
import 'package:wena_partners/professional/model/selected_professions_detail.dart';
import 'package:wena_partners/professional/model/signup_model.dart';
import 'package:wena_partners/professional/model/user_detail_Model.dart';


class ProfileController extends GetxController {
  ///------model class name------------

  CityData? cityData;

  ProfessionsUnitListModel? professionsUnitListModel;

  ProfessionsModel? professionsModel;

  bool professionsError = false;

  // ProfileModel? profileModel;

  ///------empty list-----------------

  List<City> city = [];

  List<UnitList> unitList = [];

  List<Repair> repair = [];

  List<UnitList> selectedUnitList = [];

  // List<CertificateDatum> repair1 = [];

  List<ProfessionsDetailClass> professionsList = [];

  List<bool> professionsImageValidation = [];

  final List<TextEditingController> priceListController = [];

  List<SelectedProfessionsDetailClass> selectedProfessionsVal = [];

  List<int> initialSelectedItemsIndex = [];

  ///-------bool var------------------

  bool isHomeLoad = false;
  bool imageError = false;
  bool imageError1 = false;
  bool imageError2 = false;
  bool selecteditems = false;

  ///------var-----------------

  String countryCode = "256";
  String? getCity;
  List<ProfessionsDetailClass> professionsList1 = [];

  // List<ProfileModel> professionsList2 = [];

  String? image;
  String? image1;
  String? image2;
  var imageFile;
  var imageFile1;
  var imageFile2;

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

  ///--------method--------------------------

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      image = '';
      imageError = false;
      imageFile = File(pickedFile.path);
      print("IMAGE121212-------------------$imageFile");
      update();
    }
  }

  getFromGallery1() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      image1 = '';
      imageError1 = false;
      imageFile1 = File(pickedFile.path);
      update();
    }
  }

  getFromGallery2() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      image2 = '';
      imageError2 = false;
      imageFile2 = File(pickedFile.path);
      update();
    }
  }

  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    await getUserDetail();
    await cityName();
    await professions();
    await professionsRepair();
  }

  loading(value) {
    isHomeLoad = value;
    imageError = value;
    imageError1 = value;
    imageError2 = value;
    update(['profile']);
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
      print(response.request);
      print(response.body);
      String data = response.body;
      professionsUnitListModel = ProfessionsUnitListModel.fromJson(json.decode(data));
      unitList = professionsUnitListModel!.data!;
      print("professionsUnitList========>>>${professionsUnitListModel!.msg}");
    } else {
      loading(false);
      print("error cause===>>${response.reasonPhrase}");
    }
  }

  UserDetailModel? userDetailModel;
  List<CertificateDatum> selectedProfessionIdList = [];

  getUserDetail() async {
    loading(true);
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final response = await http.post(
          Uri.parse('${SERVER_ADDRESS}api/professional/getProfessionalById'),
          body: {
            'fk_professional': '${sp.getString("user_id")}',
          });

      print(response.request);
      print('print ${response.body}');

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['code'] == 200) {
        userDetailModel = UserDetailModel.fromJson(jsonResponse);

        var data = userDetailModel?.data;
        firstName.text = data?.varFname ?? '';
        surName.text = data?.varLname ?? '';
        email.text = data?.varEmail ?? '';
        password.text = data?.varPassword ?? '';
        phoneNo.text = data?.varMobileNo ?? '';
        countryCode = data?.varCountryCode ?? '';
        imageFile = data?.varImageLink;
        imageFile1 = data?.varNationalIdFrontLink;
        imageFile2 = data?.varNationalIdBackLink;
        getCity = data?.varCity.toString();
        phoneNo1.text = data?.varMobileMoneyMobileNo ?? '';
        phoneNo2.text = data?.varRegMobileMoneyMobileNo ?? '';
        accountName.text = data?.varAccountName ?? '';
        accountNumber.text = data?.varBankAccount ?? '';
        bankName.text = data?.varBankName ?? '';
        // bankCode.text = data?.varBankCode ?? '';
        branchName.text = data?.varBankBranchName ?? '';

        selectedProfessionIdList.clear();
        for (int i = 0; i < data!.certificateData!.length; i++) {
          var cerData = data.certificateData![i];
          selectedProfessionIdList.add(cerData);
        }
      }
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  Future professionsRepair() async {
    loading(true);
    var request = http.Request(
        'GET', Uri.parse("${SERVER_ADDRESS}api/professional/getServiceList"));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      loading(false);
      print(response.request);
      print(response.body);
      String data = response.body;
      professionsModel = ProfessionsModel.fromJson(json.decode(data));
      repair = professionsModel!.data!;
      professionsList.clear();
      for (var data in repair) {
        professionsList.add(
            ProfessionsDetailClass(id: data.intGlcode!, name: data.varTitle!));
      }
      initProfessionsRepair();
      print("professionsUnitList========>>>${professionsModel!.msg}");
    } else {
      loading(false);
      print("error cause===>>${response.reasonPhrase}");
    }
  }

  onWillPop() async {
    Get.delete<ProfileController>();
  }

  initProfessionsRepair() {
    for (int i = 0; i < professionsList.length; i++) {
      for (int k = 0; k < selectedProfessionIdList.length; k++) {
        if (professionsList[i].id.toString() ==
            selectedProfessionIdList[k].fkServiceId.toString()) {
          initialSelectedItemsIndex.add(i);
          priceListController.add(TextEditingController(
              text: selectedProfessionIdList[k].varPrice));
          professionsImageValidation.add(false);
          var data = selectedProfessionIdList[k];
          UnitList currentUnitList = UnitList();
          for (int j = 0; j < unitList.length; j++) {
            if (unitList[j].intGlcode.toString() ==
                selectedProfessionIdList[k].fkUnit) {
              currentUnitList = unitList[j];
            }
          }
          selectedUnitList.add(currentUnitList);
          selectedProfessionsVal.add(SelectedProfessionsDetailClass(
              id: professionsList[i].id,
              serviceName: professionsList[i].name,
              priceController: priceListController[k],
              servicePer: selectedUnitList[k],
              netImg: selectedProfessionIdList[k].varCertificateLink));
          priceListController[k].text =
              selectedProfessionIdList[k].varPrice ?? '';
        }
      }
    }
    update();
  }

  updateProfile({
    selectedImageUrl,
        selectedImageUrl1,
        selectedImageUrl2,
        chosenValue4,
        countryCode1,
        mobile,
  }) async {

    List<String> professionDetailIds = [];

    String serviceDetail = '{';

    for (int i = 0; i < selectedProfessionsVal.length; i++) {
      var data = selectedProfessionsVal[i];
      professionDetailIds.add('"${data.id}"');
      serviceDetail +=
      '"${data.id}":{"fk_unit":${data.servicePer!.intGlcode},"var_price":${data.priceController.text}}${i == selectedProfessionsVal.length - 1 ? '' : ','}';
    }
    serviceDetail += '}';

    print('service id $professionDetailIds');
    print('serviceDetail $serviceDetail');

    /// ==============
    loading(true);

    var request = http.MultipartRequest('POST', Uri.parse("${SERVER_ADDRESS}api/professional/updateProfessionalById"));
    print("-------------------update ${SERVER_ADDRESS}api/professional/updateProfessionalById");

    // print('national id f : ${selectedImageUrl1}');
    // print('national id b : ${selectedImageUrl2}');
    SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.setString("user_id", jsonResponse['data']['int_glcode'].toString());
    String userId = sp.getString('user_id')??'';

    Map<String, String> body = {
      'professional_id': userId,
      'var_fname': firstName.text,
      'var_lname': surName.text,
      'var_email': email.text,
      'var_country_code': countryCode,
      'var_mobile_no': phoneNo.text,
      'var_city': getCity.toString(),
      'fk_service_ids': professionDetailIds.toString(),
      'service_details': serviceDetail,
      'payment_mode': mobile,
      'var_bank_account': accountNumber.text,
      'var_bank_name': bankName.text,
      'var_account_name': accountName.text,
      'var_bank_code': bankCode.text,
      'var_bank_branch_name': branchName.text,
      'fk_network_id': '1',
      'var_mobile_money_mobile_no': phoneNo1.text,
      'var_reg_mobile_money_mobile_no': phoneNo2.text,
      'var_password': password.text,
    };

    if (selectedImageUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('var_image', selectedImageUrl.path));
    }

    if (selectedImageUrl1 != null) {
      request.files.add(await http.MultipartFile.fromPath('var_national_id_front', selectedImageUrl1.path));
    }

    if (selectedImageUrl2 != null) {
      request.files.add(await http.MultipartFile.fromPath('var_national_id_back', selectedImageUrl2.path));
    }

    if (selectedProfessionsVal.isNotEmpty) {
      for (int i = 0; i < selectedProfessionsVal.length; i++) {
        var data = selectedProfessionsVal[i];
        professionDetailIds.add(data.id);
        if (data.image?.path != null) {
          print('var_certificate[${data.id}]: ${data.image?.path}');
          request.files.add(await http.MultipartFile.fromPath('var_certificate[${data.id}]', data.image!.path));
        }
      }
    }

    request.fields.addAll(body);

    http.StreamedResponse response = await request.send();
    print('sign up status code is : ${response.statusCode}');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      print("=============================Signup $jsonResponse");
      print('response ${jsonResponse['msg']}');
      if (jsonResponse['code'] == 200) {
        city.clear();
        unitList.clear();
        repair.clear();
        selectedUnitList.clear();
        professionsList.clear();
        professionsImageValidation.clear();
        priceListController.clear();
        selectedProfessionsVal.clear();
        initialSelectedItemsIndex.clear();
        init();
        loading(false);
      }
      else if (jsonResponse['code'] == 400) {
        const CircularProgressIndicator();
      }
    }
    else {
      loading(false);
      print(response.reasonPhrase);
    }



  }


}
