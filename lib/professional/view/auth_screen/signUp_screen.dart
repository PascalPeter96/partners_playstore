// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_null_comparison, file_names, must_be_immutable, prefer_const_constructors, invalid_use_of_visible_for_testing_member, unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wena_partners/professional/controller/signning_controller.dart';
import 'package:wena_partners/professional/custom_widgets/commn_widgets.dart';
import 'package:wena_partners/professional/main.dart';
import 'package:wena_partners/professional/model/ProfessionsUnitList_model.dart';
import 'package:wena_partners/professional/model/selected_professions_detail.dart';
import 'package:wena_partners/professional/utils/text.dart';

class SignUpScreen extends StatefulWidget {

  SignUpScreen( {Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<SelectedProfessionsDetailClass> selectedProfessionsVal = [];

  final List<TextEditingController> priceListController = [];

  List<bool> professionsImageValidation = [];

  var imagePicker;

  List<XFile>? imageFileList = [];

  String countryCode = "256";
  String countryCode1 = "256";

  String? _getCity;

  File? imageFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  File? imageFile4;

  bool imageError = false;
  bool imageError1 = false;
  bool imageError2 = false;
  bool imageError3 = false;
  bool imageError4 = false;
  bool professionsError = false;

  bool isPhone1 = false;
  bool isPhone2 = false;

  bool isChecked = false;

  bool showErrorMessage = false;

  bool isCancelBtnTapped = true;
  bool isConfirmBtnTapped = false;

  String mobile = "M";

  bool isObscureText = true;

  String? image;
  String? image1;
  String? image2;

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image = '';
        imageError = false;
        imageFile = File(pickedFile.path);
        // print("ImageFile------$imageFile");
        // print("IMAGE_PROFILE-----------------------------${SERVER_ADDRESS}public/assets/images/site_imges/$image");
      });
    }
  }

  _getFromGallery1() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image1 = '';
        imageError1 = false;
        imageFile1 = File(pickedFile.path);
        // print("ImageFile------$imageFile1");
        // print("IMAGE_PROFILE-----------------------------${SERVER_ADDRESS}public/assets/images/site_imges/$image1");
      });
    }
  }

  _getFromGallery2() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image2 = '';
        imageError2 = false;
        imageFile2 = File(pickedFile.path);
        // print("ImageFile------$imageFile2");
        // print("IMAGE_PROFILE-----------------------------${SERVER_ADDRESS}public/assets/images/site_imges/$image2");
      });
    }
  }

  selectImagesProfessions(index) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      selectedProfessionsVal[index].image = File(pickedFile.path);
      setState(() {});
    }
  }

  String? _chosenValue4 = "MTN";

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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    imagePicker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<SigningController>(
              id: 'signing',
              init: SigningController(),
              builder: (controller) {
                return controller.isHomeLoad == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Image.asset(
                                    "assets/icons/icon_back.png",
                                    height: 42,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: h * .035),
                                      child: const Text(
                                        getStartedText,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                            fontFamily: 'Tahoma'),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: h * .015),
                                      child: const Text(
                                        pleaseEnterText,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color(0xFF7B8295),
                                          fontFamily: 'SEGOEUI',
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: textField(
                                            textInputAction: TextInputAction.next,
                                            fillColor: const Color(0xFFE8ECF4),
                                            textAlign: TextAlign.start,
                                            hintText: "First Name",
                                            prefix: const Icon(
                                              Icons.cabin,
                                              color: Colors.transparent,
                                              size: 8,
                                            ),
                                            controller: firstName,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'First name is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: textField(
                                            textInputAction: TextInputAction.next,
                                            prefix: const Icon(
                                              Icons.cabin,
                                              color: Colors.transparent,
                                              size: 8,
                                            ),
                                            fillColor: const Color(0xFFE8ECF4),
                                            textAlign: TextAlign.start,
                                            hintText: "Surname",
                                            controller: surName,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Surname is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    textField(
                                      textInputAction: TextInputAction.next,
                                      keyBoardType: TextInputType.emailAddress,
                                      prefix: const Icon(
                                        Icons.cabin,
                                        color: Colors.transparent,
                                        size: 8,
                                      ),
                                      fillColor: const Color(0xFFE8ECF4),
                                      textAlign: TextAlign.start,
                                      hintText: "Email",
                                      controller: email,
                                      validator: (value) {
                                        String pattern =
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                            r"{0,253}[a-zA-Z0-9])?)*$";
                                        RegExp regex = RegExp(pattern);
                                        if (value == null ||
                                            value.isEmpty ||
                                            !regex.hasMatch(value)) {
                                          return 'Email is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),

                                    TextFormField(
                                      controller: password,
                                      cursorColor: const Color(0xFF8391A1),
                                      obscureText: isObscureText,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFE8ECF4),
                                        prefix: const Icon(
                                          Icons.cabin,
                                          color: Colors.transparent,
                                          size: 8,
                                        ),
                                        errorStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF44336),
                                          letterSpacing: 0.2,
                                          fontFamily: 'SEGOEUI',
                                        ),
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 14.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isObscureText =
                                                      !isObscureText;
                                                });
                                              },
                                              child: Icon(
                                                  isObscureText
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color:
                                                      const Color(0xFF8391A1))),
                                        ),
                                        // suffix: Padding(
                                        //   padding: const EdgeInsets.only(right: 14.0),
                                        //   child: GestureDetector(
                                        //       onTap: (){
                                        //         setState(() {
                                        //           isObscureText = !isObscureText;
                                        //         });
                                        //       },
                                        //       child: Icon(isObscureText?Icons.visibility_off:Icons.visibility,color: const Color(0xFF8391A1),size: 20,)),
                                        // ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 3),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.6)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.6)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.6)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.6)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 0.6)),
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                          color: Color(0xFF8391A1),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SEGOEUI',
                                          fontSize: 14,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                      // validator: (value) {
                                      //   if (value == null || value.isEmpty) {
                                      //     return 'Enter your password';
                                      //   }
                                      //   return null;
                                      // },
                                      validator: (value) {
                                        RegExp regex = RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                        if (value!.isEmpty || value == null) {
                                          return 'Please enter password';
                                        } else {
                                          if (!regex.hasMatch(value)) {
                                            return 'Enter case sensitive \nPassword must contain special character \nPassword must contain number';
                                          } else {
                                            return null;
                                          }
                                        }
                                        // if (value == null || value.isEmpty ||!regex.hasMatch(value)) {
                                        //   return 'password  is invalid. Enter case sensitive';
                                        // }
                                        // return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE8ECF4),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      // margin: const EdgeInsets.symmetric(horizontal: 5),
                                      height: 50,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            CountryCodePicker(
                                              countryFilter: const ["UG", "KE"],
                                              textStyle: const TextStyle(
                                                  color: Color(0xFf8391A1)),
                                              onInit: (value) => "256",
                                              initialSelection: '256',
                                              dialogSize:
                                                  const Size.fromWidth(330),
                                              onChanged: (value) {
                                                setState(() {
                                                  countryCode = value.dialCode!;
                                                  // print('codesign====${value.dialCode}');
                                                });
                                              },
                                              flagDecoration: BoxDecoration(
                                                color: const Color(0xFF8391A1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              flagWidth: 40,
                                              padding: const EdgeInsets.all(0),
                                              showCountryOnly: false,
                                              showOnlyCountryWhenClosed: false,
                                              alignLeft: false,
                                            ),

                                            const VerticalDivider(
                                              indent: 7,
                                              endIndent: 7,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            // const Center(child: Text("Enter your Phone", style: TextStyle(color: Color(0xFF8391A1),fontSize: 16,fontFamily: 'SEGOEUI')))
                                            Expanded(
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp("[0-9]")),
                                                ],
                                                style: const TextStyle(
                                                    fontFamily: 'SEGOEUI',
                                                    fontSize: 16,
                                                    letterSpacing: 0.2,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                controller: phoneNo,
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 10,
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          right: 10),
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: 'Enter your Phone',
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFF8391A1)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    isPhone1
                                        ? Text(
                                            "Enter the phone number",
                                            style: TextStyle(
                                                color: Color(0xFFF44336),
                                                fontFamily: 'SEGOEUI',
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    const Text(
                                      uploadProfileText,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SEGOEUI'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    imageFile != '' && imageFile != null
                                        ? GestureDetector(
                                            onTap: () {
                                              _getFromGallery();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFE8ECF4),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.5)),
                                              height: 120,
                                              width: 180,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.file(
                                                    imageFile!,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          )
                                        : image != '' && image != null
                                            ? Image.network(
                                                "${SERVER_ADDRESS}public/assets/images/site_imges/$image",
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFE8ECF4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.5)),
                                                height: 120,
                                                width: 180,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _getFromGallery();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 15,
                                                                bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Upload Image",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          letterSpacing: 0.2,
                                                          fontFamily: 'SEGOEUI',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color(
                                                              0xFF8391A1)),
                                                    ),
                                                  ],
                                                )),

                                    const SizedBox(
                                      height: 12,
                                    ),
                                    imageError == true
                                        ? const Text(
                                            "Profile image is required",
                                            style: TextStyle(
                                                color: Color(0xFFF44336),
                                                fontFamily: 'SEGOEUI',
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      "Note :- please upload clear face image",
                                      style: TextStyle(
                                          color: Color(0xFFF44336),
                                          fontFamily: 'SEGOEUI',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    /// ---------------city dropdown button---------------------

                                    DropdownButtonFormField<String>(
                                      style: const TextStyle(
                                          fontFamily: 'SEGOEUI',
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        prefix: const Icon(
                                          Icons.cabin,
                                          color: Colors.transparent,
                                          size: 8,
                                        ),
                                        errorStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFF44336),
                                            letterSpacing: 0.2,
                                            fontFamily: 'SEGOEUI'),
                                        // border: InputBorder.none,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.6),
                                        ),
                                        // disabledBorder: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                0.0, 14.0, 10.0, 14.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.6),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.6),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.6),
                                        ),
                                        // errorBorder: InputBorder.none,
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 0.6),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFE8ECF4),
                                      ),
                                      dropdownColor: Colors.white,
                                      value: _getCity,
                                      hint: Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "District",
                                          // '${_chosenValue3=="Gujarat"}',
                                          style: TextStyle(
                                            color: Color(0xFF8391A1),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'SEGOEUI',
                                            fontSize: 14,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ),
                                      onChanged: (salutation) {
                                        _getCity = salutation;
                                        // print("City_name----$_getCity");
                                      },
                                      // onChanged: (salutation) => setState(() =>  _mySelection  = salutation),

                                      validator: (value) => value == null
                                          ? 'District is required'
                                          : null,
                                      items: controller.city.map((item) {
                                        return DropdownMenuItem(
                                          value: item.title.toString(),
                                          child: Text(item.title.toString()),
                                        );
                                      }).toList(),
                                      // items: [
                                      //   // controller.cityData!.data![0].title
                                      //   'Ahmedabad',
                                      //   'Amreli',
                                      //   'Anand',
                                      //   'Aravalli',
                                      //   'Banaskantha',
                                      //   'Bharuch',
                                      //   'Bhavnagar',
                                      //   'Botad',
                                      //   'Dahod',
                                      //   'Gandhinagar',
                                      //   'Narmada',
                                      //   'Navsari',
                                      //   'Surat',
                                      //   'Vadodara',
                                      //   'Valsad',
                                      //   'Tapi',
                                      // ].map<DropdownMenuItem<String>>((String value) {
                                      //   return DropdownMenuItem<String>(
                                      //     value: value,
                                      //     child: Text(value),
                                      //   );
                                      // }).toList(),
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    const Text(
                                      nationalIdText,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SEGOEUI'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: imageFile1 != '' &&
                                                  imageFile1 != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    _getFromGallery1();
                                                  },
                                                  child: Container(
                                                    // padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFE8ECF4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5)),
                                                    height: 120,
                                                    width: 180,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.file(
                                                            imageFile1!,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFE8ECF4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5)),
                                                  height: 120,
                                                  width: 180,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _getFromGallery1();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15,
                                                                  bottom: 8),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/upload.svg",
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Upload front side",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            letterSpacing: 0.2,
                                                            fontFamily:
                                                                'SEGOEUI',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF8391A1)),
                                                      ),
                                                    ],
                                                  )),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: imageFile2 != '' &&
                                                  imageFile2 != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    _getFromGallery2();
                                                  },
                                                  child: Container(
                                                    // padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFE8ECF4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5)),
                                                    height: 120,
                                                    width: 180,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Image.file(
                                                            imageFile2!,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFE8ECF4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.5)),
                                                  height: 120,
                                                  width: 180,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          _getFromGallery2();
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15,
                                                                  bottom: 8),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/upload.svg",
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "Upload back side",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            letterSpacing: 0.2,
                                                            fontFamily:
                                                                'SEGOEUI',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF8391A1)),
                                                      ),
                                                    ],
                                                  )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      children: [
                                        imageError1 == true
                                            ? const Text(
                                                "Front side Id is required",
                                                style: TextStyle(
                                                    color: Color(0xFFF44336),
                                                    fontFamily: 'SEGOEUI',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Container(),
                                        const Spacer(),
                                        imageError2 == true
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Text(
                                                  "Back side Id is required",
                                                  style: TextStyle(
                                                      color: Color(0xFFF44336),
                                                      fontFamily: 'SEGOEUI',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                            : Container(),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 22,
                                    ),

                                    const Text(
                                      professionsText,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SEGOEUI'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    GFMultiSelect(
                                      items: controller.professionsList,
                                      onSelect: (value) {
                                        professionsError = false;
                                        selectedProfessionsVal.clear();
                                        professionsImageValidation.clear();
                                        priceListController.clear();
                                        for (int i = 0; i < value.length; i++) {
                                          professionsImageValidation.add(false);
                                          priceListController
                                              .add(TextEditingController());
                                          selectedProfessionsVal.add(
                                              SelectedProfessionsDetailClass(
                                                  id: controller
                                                      .professionsList[value[i]]
                                                      .id,
                                                  serviceName: controller
                                                      .professionsList[value[i]]
                                                      .name,
                                                  priceController:
                                                      priceListController[i],
                                                  servicePer: UnitList(),
                                                  image: null));
                                        }
                                        setState(() {});
                                        print(
                                            'on select value is $selectedProfessionsVal');
                                        print(
                                            'on select value is1 ${controller.professionsList.length}');
                                      },
                                      dropdownTitleTileText:
                                          'Please select professions',
                                      inactiveBgColor: Colors.transparent,
                                      dropdownTitleTileHintTextStyle: TextStyle(
                                          fontFamily: 'SEGOEUI',
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      dropdownTitleTileMargin: EdgeInsets.only(
                                          top: 5, left: 0, right: 0, bottom: 5),
                                      dropdownTitleTilePadding:
                                          EdgeInsets.all(10),
                                      dropdownUnderlineBorder: const BorderSide(
                                          color: Colors.transparent, width: 2),
                                      dropdownTitleTileBorder: Border.all(
                                          color: Colors.grey, width: 0.6),
                                      dropdownTitleTileBorderRadius:
                                          BorderRadius.circular(12),
                                      expandedIcon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black54,
                                      ),
                                      collapsedIcon: const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.black54,
                                      ),
                                      size: 25,
                                      dropdownTitleTileTextStyle:
                                          const TextStyle(
                                              fontFamily: 'SEGOEUI',
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                      type: GFCheckboxType.basic,
                                      activeBgColor: GFColors.SUCCESS,
                                      activeBorderColor: GFColors.SUCCESS,
                                      inactiveBorderColor: Colors.grey.shade200,
                                    ),
                                    professionsError
                                        ? const Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text(
                                              "Professions is required",
                                              style: TextStyle(
                                                  color: Color(0xFFF44336),
                                                  fontFamily: 'SEGOEUI',
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : Container(),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    SizedBox(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              selectedProfessionsVal.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // _controllers.add(TextEditingController());
                                            // for (int i = 0; i < val.length; i++) {
                                            //   selectedItemValue.add("NONE");
                                            //   break;
                                            // }
                                            // print("val length-----------------${val[index]}");
                                            // print("CONTROLLER---------------${_controllers[index]}");
                                            // print("DROUPDOWNVALUE-----------------$selectedItemValue");

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  selectedProfessionsVal[index]
                                                      .serviceName,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SEGOEUI'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: Column(
                                                          children: [
                                                            DropdownButtonFormField<
                                                                UnitList>(
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'SEGOEUI',
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.2,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              decoration:
                                                                  InputDecoration(
                                                                prefix:
                                                                    const Icon(
                                                                  Icons.cabin,
                                                                  color: Colors
                                                                      .transparent,
                                                                  size: 8,
                                                                ),
                                                                errorStyle: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xFFF44336),
                                                                    letterSpacing:
                                                                        0.2,
                                                                    fontFamily:
                                                                        'SEGOEUI'),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  borderSide: const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                ),
                                                                // disabledBorder: InputBorder.none,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0.0,
                                                                        14.0,
                                                                        10.0,
                                                                        14.0),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  borderSide: const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                ),
                                                                disabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  borderSide: const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  borderSide: const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                ),
                                                                // errorBorder: InputBorder.none,
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    const Color(
                                                                        0xFFE8ECF4),
                                                              ),
                                                              dropdownColor:
                                                                  Colors.white,
                                                              hint:
                                                                  const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                child: Text(
                                                                  'Fixed Price',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF8391A1),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        'SEGOEUI',
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        0.2,
                                                                  ),
                                                                ),
                                                              ),
                                                              onChanged:
                                                                  (salutation) {
                                                                // _getUnit = salutation;
                                                                // print("getUnit----$_getUnit");
                                                                // print("getUnit----$salutation");
                                                                selectedProfessionsVal[
                                                                            index]
                                                                        .servicePer =
                                                                    salutation!;
                                                              },
                                                              validator: (value) =>
                                                                  value == null
                                                                      ? 'Select this field'
                                                                      : null,
                                                              items: controller
                                                                  .unitList
                                                                  .map((item) {
                                                                return DropdownMenuItem(
                                                                  value: item,
                                                                  child: Text(item
                                                                      .title
                                                                      .toString()),
                                                                );
                                                              }).toList(),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            textField(
                                                              textInputAction: TextInputAction.next,
                                                              prefix:
                                                                  const Icon(
                                                                Icons.cabin,
                                                                color: Colors
                                                                    .transparent,
                                                                size: 8,
                                                              ),
                                                              keyBoardType:
                                                                  TextInputType
                                                                      .number,
                                                              // obscureText: true,
                                                              fillColor:
                                                                  const Color(
                                                                      0xFFE8ECF4),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              hintText: "Price",
                                                              // controller: _controllers[index],
                                                              controller:
                                                                  selectedProfessionsVal[
                                                                          index]
                                                                      .priceController,
                                                              // controller: Price,
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Price is required';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child: selectedProfessionsVal[
                                                                          index]
                                                                      .image ==
                                                                  null ||
                                                              selectedProfessionsVal[
                                                                          index]
                                                                      .image ==
                                                                  ''
                                                          ? Column(
                                                              children: [
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFE8ECF4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                12),
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .grey,
                                                                            width:
                                                                                0.5)),
                                                                    height: 120,
                                                                    width: 180,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            // _getImage();
                                                                            // _getFromGallery3(index);
                                                                            // selectImages(index);
                                                                            selectImagesProfessions(index);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 15, bottom: 8),
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              "assets/images/upload.svg",
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const Text(
                                                                          "Upload Certificate",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              letterSpacing: 0.2,
                                                                              fontFamily: 'SEGOEUI',
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xFF8391A1)),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                professionsImageValidation[
                                                                        index]
                                                                    ? const Padding(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          "This image  is required",
                                                                          style: TextStyle(
                                                                              color: Color(0xFFF44336),
                                                                              fontFamily: 'SEGOEUI',
                                                                              fontWeight: FontWeight.bold),
                                                                        ))
                                                                    : SizedBox(),
                                                              ],
                                                            )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                // print("index?? is====>>>>>$index");
                                                                // _getImage();
                                                                // _getFromGallery3(index);
                                                                selectImagesProfessions(
                                                                    index);
                                                              },
                                                              child: Container(
                                                                // padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                                                                decoration: BoxDecoration(
                                                                    color: const Color(
                                                                        0xFFE8ECF4),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            0.5)),
                                                                height: 120,
                                                                width: 180,
                                                                child:
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                12),
                                                                        child: Image
                                                                            .file(
                                                                          // File(imageFileList![index].path),
                                                                          File(selectedProfessionsVal[index]
                                                                              .image!
                                                                              .path),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                                // child: ClipRRect(borderRadius: BorderRadius.circular(12),child: Image.file(
                                                                //   File(_imageList[index].path),
                                                                //   fit: BoxFit.cover,
                                                                // )
                                                                // ),
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 14,
                                                ),
                                                Row(
                                                  children: [
                                                    const Spacer(),
                                                    imageError3 == true
                                                        ? const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Text(
                                                              "Certificate is required",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFFF44336),
                                                                  fontFamily:
                                                                      'SEGOEUI',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ))
                                                        : Container(),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }),
                                    ),

                                    /// ---------------- new end --------------------------

                                    const Center(
                                      child: Text(
                                        choosePaymentText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'SEGOEUI'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                mobile = 'M';
                                                isCancelBtnTapped = true;
                                                isConfirmBtnTapped = false;
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: isCancelBtnTapped
                                                        ? const Color(
                                                            0xFF149C48)
                                                        : const Color(
                                                            0xffE8EFF3),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(25.0),
                                                child: Image.asset(
                                                    "assets/images/mobile_money.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 25,
                                          color: const Color(0xFFDADADA),
                                          height: 1,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "OR",
                                          style: TextStyle(
                                              color: Color(0xFFDADADA),
                                              fontFamily: 'SEGOEUI',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 25,
                                          color: const Color(0xFFDADADA),
                                          height: 1,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                mobile = 'B';
                                                isConfirmBtnTapped = true;
                                                isCancelBtnTapped = false;
                                                // print("INDEX_CHANGE------------$isConfirmBtnTapped");
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: isConfirmBtnTapped
                                                        ? const Color(
                                                            0xFF149C48)
                                                        : const Color(
                                                            0xffE8EFF3),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(25.0),
                                                child: Image.asset(
                                                    "assets/images/bank.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(mobileMoneyText,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  letterSpacing: 0.2,
                                                  fontFamily: 'SEGOEUI',
                                                  fontWeight: FontWeight.w600,
                                                  color: isCancelBtnTapped
                                                      ? Colors.black
                                                      : Color(0xFF8391A1))),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(right: 40),
                                          child: Text(bankText,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  letterSpacing: 0.2,
                                                  fontFamily: 'SEGOEUI',
                                                  fontWeight: FontWeight.w600,
                                                  color: isConfirmBtnTapped
                                                      ? Colors.black
                                                      : Color(0xFF8391A1))),
                                        ),
                                      ],
                                    ),

                                    isCancelBtnTapped == true
                                        ? SizedBox(
                                            height: 30,
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? const Text(
                                            paymentDetailText,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'SEGOEUI'),
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? SizedBox(
                                            height: 10,
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? DropdownButtonFormField<String>(
                                            style: const TextStyle(
                                                fontFamily: 'SEGOEUI',
                                                fontSize: 16,
                                                letterSpacing: 0.2,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              prefix: const Icon(
                                                Icons.cabin,
                                                color: Colors.transparent,
                                                size: 8,
                                              ),
                                              errorStyle: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFF44336),
                                                  letterSpacing: 0.2,
                                                  fontFamily: 'SEGOEUI'),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.6),
                                              ),
                                              // disabledBorder: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      0.0, 14.0, 10.0, 14.0),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.6),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.6),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.6),
                                              ),
                                              // errorBorder: InputBorder.none,
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.6),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFE8ECF4),
                                            ),
                                            dropdownColor: Colors.white,
                                            value: _chosenValue4,
                                            hint: const Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Text(
                                                'Select Network',
                                                style: TextStyle(
                                                  color: Color(0xFF8391A1),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'SEGOEUI',
                                                  fontSize: 14,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            ),
                                            onChanged: (salutation) => setState(
                                                () =>
                                                    _chosenValue4 = salutation),
                                            validator: (value) => value == null
                                                ? 'Select Network is required'
                                                : null,
                                            items: [
                                              'MTN',
                                              'Airtel',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? SizedBox(
                                            height: 22,
                                          )
                                        : Container(),

                                    isCancelBtnTapped == true
                                        ? textField(
                                      textInputAction: TextInputAction.next,
                                            keyBoardType: TextInputType.number,
                                            prefix: const Icon(
                                              Icons.cabin,
                                              color: Colors.transparent,
                                              size: 8,
                                            ),
                                            fillColor: const Color(0xFFE8ECF4),
                                            textAlign: TextAlign.start,
                                            // hintText: "Enter your phone",
                                            hintText:'Enter your Names',
                                            controller: phoneNo1,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  phoneNo1.text.length != 10) {
                                                return 'Please enter valid phone number';
                                              }
                                              return null;
                                            },
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? SizedBox(
                                            height: 22,
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? Text(
                                            registeredText,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'SEGOEUI'),
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? SizedBox(
                                            height: 22,
                                          )
                                        : Container(),
                                    isCancelBtnTapped == true
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFE8ECF4),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            // margin: const EdgeInsets.symmetric(horizontal: 5),
                                            height: 50,
                                            child: IntrinsicHeight(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  CountryCodePicker(
                                                    countryFilter: const [
                                                      "UG",
                                                      "KE"
                                                    ],
                                                    textStyle: const TextStyle(
                                                        color:
                                                            Color(0xFf8391A1)),
                                                    onInit: (value) => "256",
                                                    initialSelection: '256',
                                                    dialogSize:
                                                        const Size.fromWidth(
                                                            330),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        countryCode1 =
                                                            value.dialCode!;
                                                        // print('codesign====${value.dialCode}');
                                                      });
                                                    },
                                                    flagDecoration:
                                                        BoxDecoration(
                                                      color: const Color(
                                                          0xFF8391A1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    flagWidth: 40,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    showCountryOnly: false,
                                                    showOnlyCountryWhenClosed:
                                                        false,
                                                    alignLeft: false,
                                                  ),
                                                  const VerticalDivider(
                                                    indent: 7,
                                                    endIndent: 7,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                      ],
                                                      maxLength: 10,
                                                      style: const TextStyle(
                                                          fontFamily: 'SEGOEUI',
                                                          fontSize: 16,
                                                          letterSpacing: 0.2,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      controller: phoneNo2,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        counterText: '',
                                                        // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        hintText: 'Enter your Phone',
                                                        hintStyle: TextStyle(
                                                          color:
                                                              Color(0xFF8391A1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    isCancelBtnTapped == true
                                        ? isPhone2
                                            ? Text(
                                                "Enter the phone number",
                                                style: TextStyle(
                                                    color: Color(0xFFF44336),
                                                    fontFamily: 'SEGOEUI',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Container()
                                        : Container(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    isConfirmBtnTapped == true
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                bankDetailText,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'SEGOEUI'),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              textField(
                                                textInputAction: TextInputAction.next,
                                                prefix: const Icon(
                                                  Icons.cabin,
                                                  color: Colors.transparent,
                                                  size: 8,
                                                ),
                                                fillColor:
                                                    const Color(0xFFE8ECF4),
                                                textAlign: TextAlign.start,
                                                hintText: "Account Name",
                                                controller: accountName,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Account name is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              textField(
                                                textInputAction: TextInputAction.next,
                                                prefix: const Icon(
                                                  Icons.cabin,
                                                  color: Colors.transparent,
                                                  size: 8,
                                                ),
                                                keyBoardType:
                                                    TextInputType.number,
                                                fillColor:
                                                    const Color(0xFFE8ECF4),
                                                textAlign: TextAlign.start,
                                                hintText: "Account Number",
                                                controller: accountNumber,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Account number is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              textField(
                                                textInputAction: TextInputAction.next,
                                                prefix: const Icon(
                                                  Icons.cabin,
                                                  color: Colors.transparent,
                                                  size: 8,
                                                ),
                                                fillColor:
                                                    const Color(0xFFE8ECF4),
                                                textAlign: TextAlign.start,
                                                hintText: "Bank Name",
                                                controller: bankName,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Bank name is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),

                                              ///------------bank code filed-----------
                                              // textField(
                                              //   prefix: const Icon(
                                              //     Icons.cabin,
                                              //     color: Colors.transparent,
                                              //     size: 8,
                                              //   ),
                                              //   fillColor:
                                              //   const Color(0xFFE8ECF4),
                                              //   textAlign: TextAlign.start,
                                              //   hintText: "Bank Code",
                                              //   controller: bankCode,
                                              //   validator: (value) {
                                              //     if (value == null ||
                                              //         value.isEmpty) {
                                              //       return 'Bank Code is required';
                                              //     }
                                              //     return null;
                                              //   },
                                              // ),
                                              // const SizedBox(
                                              //   height: 20,
                                              // ),
                                              textField(
                                                textInputAction: TextInputAction.next,
                                                prefix: const Icon(
                                                  Icons.cabin,
                                                  color: Colors.transparent,
                                                  size: 8,
                                                ),
                                                fillColor:
                                                    const Color(0xFFE8ECF4),
                                                textAlign: TextAlign.start,
                                                hintText: "Branch Name",
                                                controller: branchName,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Branch name is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          activeColor: const Color(0xFF149C48),
                                          checkColor: Colors.white,
                                          value: isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          },
                                        ),
                                        const Text(privacyText),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    showErrorMessage
                                        ? const Text(
                                            "Accept terms and conditions before sign up",
                                            style: TextStyle(
                                                color: Color(0xFFF44336),
                                                fontFamily: 'SEGOEUI',
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Container(),

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // isChecked==false? const Text("Accept terms and condition before sign up",style: TextStyle(color: Color(0xFFF44336),fontFamily: 'SEGOEUI',fontWeight: FontWeight.bold),):Container(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('On register tap');
                                        for (int i = 0;
                                            i < selectedProfessionsVal.length;
                                            i++) {
                                          print('--item $i is');
                                          var data = selectedProfessionsVal[i];
                                          print('----------------');
                                          if (data.image == null ||
                                              data.image == '') {
                                            professionsImageValidation[i] =
                                                true;
                                          } else {
                                            professionsImageValidation[i] =
                                                false;
                                          }
                                        }

                                        if (_formKey.currentState!.validate()) {
                                          if (selectedProfessionsVal.isEmpty) {
                                            setState(() {
                                              professionsError = true;
                                            });
                                          } else if (professionsImageValidation
                                              .contains(true)) {
                                            setState(() {});
                                          } else if (isChecked != true) {
                                            setState(
                                                () => showErrorMessage = true);
                                          } else {
                                            isPhone1 = false;
                                            isPhone2 = false;

                                            controller.registerUser(
                                              image: imageFile,
                                              countryCode:
                                                  countryCode.toString(),
                                              email: email.text,
                                              firstName: firstName.text,
                                              getCity: _getCity.toString(),
                                              image1: imageFile1,
                                              image2: imageFile2,
                                              phoneNo: phoneNo.text,
                                              surName: surName.text,
                                              mode: mobile.toString(),
                                              accountname: accountName.text,
                                              // accountnumber: accountNumber.text,
                                              bankname: bankName.text,
                                              Bankcode: "121211",
                                              Branchname: branchName.text,
                                              selectNetwork:
                                                  _chosenValue4.toString(),
                                              paymentPhoneNo: phoneNo1.text,
                                              // countryPhone: phoneNo2.text,
                                              countryPhone:
                                                  '$countryCode1${phoneNo2.text}',
                                              serviceId: selectedProfessionsVal
                                                  .toString(),
                                              selectedProfessionDetailClass:
                                                  selectedProfessionsVal,
                                              context: context,
                                              accountNumber: accountNumber.text,
                                              password: password.text,
                                            );
                                          }
                                        }
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 48,
                                          width: double.infinity,
                                          color: const Color(0xFF149C48),
                                          child: const Center(
                                            child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontFamily: 'SEGOEUI',
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
