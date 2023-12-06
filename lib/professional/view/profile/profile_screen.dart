// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_const_constructors, unrelated_type_equality_checks, prefer_typing_uninitialized_variables
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';

import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/controller/profile_controller.dart';
import 'package:wena_partners/professional/custom_widgets/commn_widgets.dart';
import 'package:wena_partners/professional/custom_widgets/custom_multi_select_drop_down.dart';
import 'package:wena_partners/professional/model/ProfessionsUnitList_model.dart';
import 'package:wena_partners/professional/model/selected_professions_detail.dart';
import 'package:wena_partners/professional/utils/text.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var imagePicker;

  final controller = Get.put(ProfileController());

  List<XFile>? imageFileList = [];

  String countryCode1 = "256";

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

  // bool professionsError = false;

  String? _chosenValue4 = "MTN";

  bool isPhone1 = false;
  bool isPhone2 = false;


  bool isCancelBtnTapped = true;
  bool isConfirmBtnTapped = false;

  String mobile = "M";

  List<Media>? _listImagePaths;
  List<Media>? _listImagePaths1;
  List<Media>? _listImagePaths2;
  var selectedImageUrl;
  var selectedImageUrl1;
  var selectedImageUrl2;
  String? image;
  String? image1;
  String? image2;

  pickFromCamera() async {
    _listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Colors.black),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));

    if (_listImagePaths!.isNotEmpty) {
      setState(() {
        image = '';
        selectedImageUrl = _listImagePaths![0];
        print('image=======================>$selectedImageUrl');
      });
    } else {
      print('null');
    }
  }

  pickFromCamera1() async {
    _listImagePaths1 = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Colors.black),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));

    if (_listImagePaths1!.isNotEmpty) {
      setState(() {
        image1 = '';
        selectedImageUrl1 = _listImagePaths1![0];
        print('image=======================>$selectedImageUrl1');
      });
    } else {
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

    if (_listImagePaths2!.isNotEmpty) {
      setState(() {
        image2 = '';
        selectedImageUrl2 = _listImagePaths2![0];
        print('image=======================>$selectedImageUrl2');
      });
    } else {
      print('null');
    }
  }

  selectImagesProfessions(index) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      controller.selectedProfessionsVal[index].image = File(pickedFile.path);
      setState(() {});
    }
  }

  final _formKey = GlobalKey<FormState>();

  String? userId;

  id() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userId = sp.getString("user_id");
    });
    print("USER_ID_Edit_Profile----------${userId.toString()}");
  }

  @override
  void initState() {
    imagePicker = ImagePicker();
    id();
    super.initState();
  }

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onWillPop();
        return true;
      },
      child: Form(
        key: _formKey,
        child: SafeArea(
          child: Scaffold(
            body: isLoaded
                ? CircularProgressIndicator()
                : GetBuilder<ProfileController>(
                id: 'profile',
                init: ProfileController(),
                builder: (controller) {
                  return controller.isHomeLoad == true
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : Padding(padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller.onWillPop();
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
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 12),
                                  child: ListTile(
                                    contentPadding:
                                    const EdgeInsets.only(
                                        right: 12),
                                    leading: Image.asset(
                                      "assets/images/homepage/man.png",
                                      height: 50,
                                    ),
                                    title: const Text(
                                      "Wilson Jonson",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: "SEGOEUI",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: const Text(
                                      "demo@domain.com",
                                      style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 0.2,
                                        color: Colors.black,
                                        fontFamily: "SEGOEUI",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing: SvgPicture.asset(
                                      "assets/images/edit.svg",
                                      height: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: textField(
                                        textInputAction: TextInputAction.next,
                                        fillColor:
                                        const Color(0xFFE8ECF4),
                                        textAlign: TextAlign.start,
                                        // hintText: "First Name",
                                        hintText: "First Name",
                                        prefix: const Icon(
                                          Icons.cabin,
                                          color: Colors.transparent,
                                          size: 8,
                                        ),
                                        controller:
                                        controller.firstName,
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
                                        fillColor:
                                        const Color(0xFFE8ECF4),
                                        textAlign: TextAlign.start,
                                        hintText: "Surname",
                                        controller:
                                        controller.surName,
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
                                  keyBoardType:
                                  TextInputType.emailAddress,
                                  prefix: const Icon(
                                    Icons.cabin,
                                    color: Colors.transparent,
                                    size: 8,
                                  ),
                                  fillColor: const Color(0xFFE8ECF4),
                                  textAlign: TextAlign.start,
                                  hintText: "Email",
                                  controller: controller.email,
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
                                  controller: controller.password,
                                  cursorColor:
                                  const Color(0xFF8391A1),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                    const Color(0xFFE8ECF4),
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
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 3),
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
                                    disabledBorder:
                                    OutlineInputBorder(
                                        borderRadius: BorderRadius
                                            .circular(12),
                                        borderSide:
                                        const BorderSide(
                                            color:
                                            Colors.grey,
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
                                  validator: (value) {
                                    RegExp regex = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    if (value!.isEmpty) {
                                      return 'Please enter password';
                                    } else {
                                      if (!regex.hasMatch(value)) {
                                        return 'password  is invalid. Enter case sensitive';
                                      } else {
                                        return null;
                                      }
                                    }
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
                                          enabled: false,
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
                                              controller.countryCode =
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
                                        // const Center(child: Text("Enter your Phone", style: TextStyle(color: Color(0xFF8391A1),fontSize: 16,fontFamily: 'SEGOEUI')))
                                        Expanded(
                                          child: TextFormField(
                                            enabled: false,
                                            style: const TextStyle(
                                                fontFamily: 'SEGOEUI',
                                                fontSize: 16,
                                                letterSpacing: 0.2,
                                                color: Colors.black,
                                                fontWeight:
                                                FontWeight.bold),
                                            controller:
                                            controller.phoneNo,
                                            keyboardType:
                                            TextInputType.number,
                                            decoration:
                                            const InputDecoration(
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
                                              hintText:
                                              'Enter your Phone',
                                              hintStyle: TextStyle(
                                                  color: Color(
                                                      0xFF8391A1)),
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
                                      fontWeight:
                                      FontWeight.bold),
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

                                ///----------image----------------------------------------
                                // controller.imageFile != '' && controller.imageFile != null
                                //     ? GestureDetector(
                                //     onTap: () {
                                //     controller.getFromGallery();
                                //     print("IMAGE--------------${controller.imageFile}");
                                //   },
                                //      child: Container(
                                //       decoration: BoxDecoration(
                                //         color: const Color(0xFFE8ECF4),
                                //         borderRadius: BorderRadius.circular(12),
                                //         border: Border.all(color: Colors.grey, width: 0.5)),
                                //        height: 120,
                                //        width: 180,
                                //
                                //       child: CachedNetworkImage(
                                //       imageUrl: "${controller.profileModel!.data!.varImageLink}",
                                //       imageBuilder: (context, imageProvider) => Container(
                                //         decoration: BoxDecoration(
                                //           image: DecorationImage(
                                //             image: imageProvider,
                                //             fit: BoxFit.cover,
                                //           ),
                                //         ),
                                //       ),
                                //       // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                //       placeholder: (context, url) => CupertinoActivityIndicator(),
                                //       errorWidget: (context, url, error) => Icon(Icons.error),
                                //     ),
                                //   ),
                                // )
                                //     : Container(
                                //     decoration: BoxDecoration(
                                //         color: const Color(0xFFE8ECF4),
                                //         borderRadius:
                                //         BorderRadius.circular(12),
                                //         border: Border.all(
                                //             color: Colors.grey,
                                //             width: 0.5)),
                                //     height: 120,
                                //     width: 180,
                                //     child: Column(
                                //       children: [
                                //         GestureDetector(
                                //           onTap: () {
                                //             controller.getFromGallery();
                                //           },
                                //           child: Container(
                                //             padding:
                                //             const EdgeInsets.only(top: 15, bottom: 8),
                                //             child: SvgPicture.asset(
                                //               "assets/images/upload.svg",
                                //             ),
                                //           ),
                                //         ),
                                //         const Text(
                                //           "Upload Image",
                                //           style: TextStyle(
                                //               fontSize: 12,
                                //               letterSpacing: 0.2,
                                //               fontFamily: 'SEGOEUI',
                                //               fontWeight:
                                //               FontWeight.w600,
                                //               color: Color(0xFF8391A1)),
                                //         ),
                                //       ],
                                //     )),

                                GestureDetector(
                                  onTap: () {
                                    pickFromCamera();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8ECF4),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5),
                                    ),
                                    height: 120,
                                    width: 180,
                                    child: selectedImageUrl != '' &&
                                        selectedImageUrl != null
                                        ? Image.file(
                                      File(selectedImageUrl.path),
                                      fit: BoxFit.cover,
                                    )
                                        : image != '' && image != null
                                        ? Container(
                                        decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFE8ECF4),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                12),
                                            border: Border.all(
                                                color: Colors
                                                    .grey,
                                                width: 0.5)),
                                        height: 120,
                                        width: 180,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                pickFromCamera();
                                              },
                                              child:
                                              Container(
                                                padding: const EdgeInsets
                                                    .only(
                                                    top: 15,
                                                    bottom:
                                                    8),
                                                child:
                                                SvgPicture
                                                    .asset(
                                                  "assets/images/upload.svg",
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "Upload Image",
                                              style: TextStyle(
                                                  fontSize:
                                                  12,
                                                  letterSpacing:
                                                  0.2,
                                                  fontFamily:
                                                  'SEGOEUI',
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                  color: Color(
                                                      0xFF8391A1)),
                                            ),
                                          ],
                                        ))
                                        : CachedNetworkImage(
                                      // imageUrl: "${controller.profileModel?.data?.varImageLink}",
                                      imageUrl:
                                      "${controller.userDetailModel?.data?.varImageLink}",
                                      imageBuilder: (context,
                                          imageProvider) =>
                                          Container(
                                            decoration:
                                            BoxDecoration(
                                              image:
                                              DecorationImage(
                                                image:
                                                imageProvider,
                                                fit: BoxFit
                                                    .cover,
                                              ),
                                            ),
                                          ),
                                      // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                      placeholder: (context,
                                          url) =>
                                          CupertinoActivityIndicator(),
                                      errorWidget: (context,
                                          url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),

                                // Stack(
                                //   clipBehavior: Clip.none, alignment: Alignment.center,
                                //   children: [
                                //     Container(
                                //       height: 180,
                                //       width: 180,
                                //       decoration: BoxDecoration(
                                //           color: Colors.red,
                                //           shape: BoxShape.circle,
                                //           image: selectedImageUrl != '' && selectedImageUrl != null
                                //               ? DecorationImage(image: FileImage(File(selectedImageUrl)),fit: BoxFit.cover):
                                //           image!=''&&image!= null? DecorationImage(image: FileImage(File(selectedImageUrl)),fit: BoxFit.cover):
                                //           DecorationImage(image: NetworkImage("${controller.profileModel!.data!.varImageLink}"),fit: BoxFit.cover)
                                //       ),
                                //     ),
                                //     Positioned(
                                //         bottom: 10,
                                //         right: -15,
                                //         child: InkWell(
                                //             onTap: (){
                                //               pickFromCamera();
                                //             },
                                //             child: Image.asset('assets/images/bank.png',height: 60,))),
                                //   ],
                                // ),

                                const SizedBox(
                                  height: 12,
                                ),
                                imageError == true
                                    ? const Text(
                                  "Profile image is required",
                                  style: TextStyle(
                                      color: Color(0xFFF44336),
                                      fontFamily: 'SEGOEUI',
                                      fontWeight:
                                      FontWeight.bold),
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

                                DropdownButtonFormField(
                                  style:  TextStyle(
                                      fontFamily: 'SEGOEUI',
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                  ),
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
                                        fontFamily: 'SEGOEUI'
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 0.6),
                                    ),
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
                                  value: controller.getCity,
                                  hint: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      // "${controller.getCity.toString()}",
                                      "please enter District",
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
                                    setState(() {
                                      controller.getCity = salutation.toString();
                                    });
                                    print("GET_CITY----------------------${controller.getCity}");
                                  },
                                  validator: (value) => value == null
                                      ? 'District is required'
                                      : null,
                                  items: controller.city.map((item) {
                                    return DropdownMenuItem(
                                      value: item.title.toString(),
                                      child: Text(item.title.toString()),
                                    );
                                  }).toList(),
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
                                      child: GestureDetector(
                                        onTap: () {
                                          pickFromCamera1();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFE8ECF4),
                                            borderRadius:
                                            BorderRadius.circular(
                                                12),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 0.5),
                                          ),
                                          height: 120,
                                          width: 180,
                                          child: selectedImageUrl1 !=
                                              '' &&
                                              selectedImageUrl1 !=
                                                  null
                                              ? Image.file(
                                            File(
                                                selectedImageUrl1.path),
                                            fit: BoxFit.cover,
                                          )
                                              : image1 != '' &&
                                              image1 != null
                                              ? Container(
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
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap:
                                                        () {
                                                      pickFromCamera1();
                                                    },
                                                    child:
                                                    Container(
                                                      padding: const EdgeInsets.only(
                                                          top:
                                                          15,
                                                          bottom:
                                                          8),
                                                      child: SvgPicture
                                                          .asset(
                                                        "assets/images/upload.svg",
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Upload front side",
                                                    style: TextStyle(
                                                        fontSize:
                                                        12,
                                                        letterSpacing:
                                                        0.2,
                                                        fontFamily:
                                                        'SEGOEUI',
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        color:
                                                        Color(0xFF8391A1)),
                                                  ),
                                                ],
                                              ))
                                              : CachedNetworkImage(
                                            // imageUrl:  "${controller.profileModel?.data?.varNationalIdFrontLink}",
                                            imageUrl:
                                            "${controller.userDetailModel?.data?.varNationalIdFrontLink}",
                                            imageBuilder:
                                                (context,
                                                imageProvider) =>
                                                Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    image:
                                                    DecorationImage(
                                                      image:
                                                      imageProvider,
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                ),
                                            // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                            placeholder: (context,
                                                url) =>
                                                CupertinoActivityIndicator(),
                                            errorWidget: (context,
                                                url,
                                                error) =>
                                                Icon(Icons
                                                    .error),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 20,
                                    ),


                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          pickFromCamera2();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFE8ECF4),
                                            borderRadius:
                                            BorderRadius.circular(
                                                12),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 0.5),
                                          ),
                                          height: 120,
                                          width: 180,
                                          child: selectedImageUrl2 !=
                                              '' &&
                                              selectedImageUrl2 !=
                                                  null
                                              ? Image.file(
                                            File(
                                                selectedImageUrl2.path),
                                            fit: BoxFit.cover,
                                          )
                                              : image2 != '' &&
                                              image2 != null
                                              ? Container(
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
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap:
                                                      () {
                                                    pickFromCamera2();
                                                  },
                                                  child:
                                                  Container(
                                                    padding: const EdgeInsets.only(
                                                        top:
                                                        15,
                                                        bottom:
                                                        8),
                                                    child: SvgPicture
                                                        .asset(
                                                      "assets/images/upload.svg",
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  "Upload back side",
                                                  style: TextStyle(
                                                      fontSize:
                                                      12,
                                                      letterSpacing:
                                                      0.2,
                                                      fontFamily:
                                                      'SEGOEUI',
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color:
                                                      Color(0xFF8391A1)),
                                                ),
                                              ],
                                            ),
                                          )
                                              : CachedNetworkImage(
                                            // imageUrl:   "${controller.profileModel?.data?.varNationalIdBackLink}",
                                            imageUrl:
                                            "${controller.userDetailModel?.data?.varNationalIdBackLink}",
                                            imageBuilder:
                                                (context,
                                                imageProvider) =>
                                                Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    image:
                                                    DecorationImage(
                                                      image:
                                                      imageProvider,
                                                      fit: BoxFit
                                                          .cover,
                                                    ),
                                                  ),
                                                ),
                                            // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                            placeholder: (context,
                                                url) =>
                                                CupertinoActivityIndicator(),
                                            errorWidget: (context,
                                                url,
                                                error) =>
                                                Icon(Icons
                                                    .error),
                                          ),
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
                                    imageError1 == true
                                        ? const Text(
                                      "Front side Id is required",
                                      style: TextStyle(
                                          color:
                                          Color(0xFFF44336),
                                          fontFamily: 'SEGOEUI',
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                        : Container(),
                                    const Spacer(),
                                    imageError2 == true
                                        ? const Padding(
                                      padding: EdgeInsets.only(
                                          right: 10),
                                      child: Text(
                                        "Back side Id is required",
                                        style: TextStyle(
                                            color: Color(
                                                0xFFF44336),
                                            fontFamily:
                                            'SEGOEUI',
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                      ),
                                    )
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
                                  initialSelectedItemsIndex:
                                  controller
                                      .initialSelectedItemsIndex,
                                  onSelect: (value) {
                                    print('value is : $value');
                                    controller.professionsError =
                                    false;
                                    controller.selectedProfessionsVal
                                        .clear();
                                    controller
                                        .professionsImageValidation
                                        .clear();
                                    controller.priceListController
                                        .clear();
                                    for (int i = 0;
                                    i < value.length;
                                    i++) {
                                      controller
                                          .professionsImageValidation
                                          .add(false);
                                      controller.priceListController
                                          .add(
                                          TextEditingController());
                                      controller
                                          .selectedProfessionsVal
                                          .add(SelectedProfessionsDetailClass(
                                          id: controller
                                              .professionsList[
                                          value[i]]
                                              .id,
                                          serviceName: controller
                                              .professionsList[
                                          value[i]]
                                              .name,
                                          priceController: controller
                                              .priceListController[i],
                                          servicePer: UnitList(),
                                          image: null));
                                    }
                                    setState(() {});
                                    print(
                                        'on select value is ${controller.selectedProfessionsVal}');
                                    print(
                                        'on select value is1 ${controller.professionsList.length}');
                                  },
                                  dropdownTitleTileText:
                                  'please selected professions',
                                  inactiveBgColor: Colors.transparent,
                                  dropdownTitleTileHintTextStyle:
                                  TextStyle(
                                      fontFamily: 'SEGOEUI',
                                      fontSize: 16,
                                      letterSpacing: 0.2,
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold),
                                  dropdownTitleTileMargin:
                                  EdgeInsets.only(
                                      top: 5,
                                      left: 0,
                                      right: 0,
                                      bottom: 5),
                                  dropdownTitleTilePadding:
                                  EdgeInsets.all(10),
                                  dropdownUnderlineBorder:
                                  const BorderSide(
                                      color: Colors.transparent,
                                      width: 2),
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
                                      fontWeight:
                                      FontWeight.bold),
                                  type: GFCheckboxType.basic,
                                  activeBgColor: GFColors.SUCCESS,
                                  activeBorderColor: GFColors.SUCCESS,
                                  inactiveBorderColor:
                                  Colors.grey.shade200,
                                ),

                                controller.professionsError
                                    ? const Padding(
                                    padding: EdgeInsets.only(
                                        right: 10),
                                    child: Text(
                                      "Professions is required",
                                      style: TextStyle(
                                          color:
                                          Color(0xFFF44336),
                                          fontFamily: 'SEGOEUI',
                                          fontWeight:
                                          FontWeight.bold),
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
                                      itemCount: controller
                                          .selectedProfessionsVal
                                          .length,
                                      itemBuilder:
                                          (BuildContext context,
                                          int index) {
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              controller
                                                  .selectedProfessionsVal[
                                              index]
                                                  .serviceName,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  fontFamily:
                                                  'SEGOEUI'),
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
                                                        .circular(
                                                        12),
                                                    child: Column(
                                                      children: [
                                                        DropdownButtonFormField<
                                                            UnitList>(
                                                          value: controller
                                                              .selectedUnitList[
                                                          index],
                                                          style: const TextStyle(
                                                              fontFamily:
                                                              'SEGOEUI',
                                                              fontSize:
                                                              16,
                                                              letterSpacing:
                                                              0.2,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                          decoration:
                                                          InputDecoration(
                                                            prefix:
                                                            const Icon(
                                                              Icons
                                                                  .cabin,
                                                              color: Colors
                                                                  .transparent,
                                                              size: 8,
                                                            ),
                                                            errorStyle: const TextStyle(
                                                                fontSize:
                                                                13,
                                                                fontWeight: FontWeight
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
                                                              BorderRadius.circular(12.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                  Colors.grey,
                                                                  width: 0.6),
                                                            ),
                                                            // disabledBorder: InputBorder.none,
                                                            contentPadding: const EdgeInsets
                                                                .fromLTRB(
                                                                0.0,
                                                                14.0,
                                                                10.0,
                                                                14.0),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(12.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                  Colors.grey,
                                                                  width: 0.6),
                                                            ),
                                                            disabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(12.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                  Colors.grey,
                                                                  width: 0.6),
                                                            ),
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(12.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                  Colors.grey,
                                                                  width: 0.6),
                                                            ),
                                                            // errorBorder: InputBorder.none,
                                                            errorBorder:
                                                            OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                  Colors.grey,
                                                                  width: 0.6),
                                                              borderRadius:
                                                              BorderRadius.circular(12.0),
                                                            ),
                                                            filled:
                                                            true,
                                                            fillColor:
                                                            const Color(
                                                                0xFFE8ECF4),
                                                          ),
                                                          dropdownColor:
                                                          Colors
                                                              .white,
                                                          hint:
                                                          const Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: 5),
                                                            child:
                                                            Text(
                                                              'Fixed Price',
                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Color(0xFF8391A1),
                                                                fontWeight:
                                                                FontWeight.w600,
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
                                                            controller
                                                                .selectedProfessionsVal[
                                                            index]
                                                                .servicePer = salutation!;
                                                          },
                                                          validator: (value) => value ==
                                                              null
                                                              ? 'Select this field'
                                                              : null,
                                                          items: controller
                                                              .unitList
                                                              .map(
                                                                  (item) {
                                                                return DropdownMenuItem(
                                                                  value:
                                                                  item,
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
                                                            Icons
                                                                .cabin,
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
                                                          hintText:
                                                          "Price",
                                                          // controller: _controllers[index],
                                                          controller: controller
                                                              .selectedProfessionsVal[
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
                                                  // child: controller.selectedProfessionsVal[index].netImg != null
                                                  child: controller.selectedProfessionsVal[index].image != null
                                                      ? GestureDetector(
                                                    onTap: () {
                                                      selectImagesProfessions(
                                                          index);
                                                    },
                                                    child:
                                                    Container(
                                                      // padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFE8ECF4),
                                                          borderRadius: BorderRadius.circular(
                                                              12),
                                                          border: Border.all(
                                                              color: Colors.grey,
                                                              width: 0.5)),
                                                      height:
                                                      120,
                                                      width:
                                                      180,
                                                      child:
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(12),
                                                        child:

                                                        // Image.network(
                                                        // controller.selectedProfessionsVal[index].netImg ??
                                                        // ""),

                                                        Image.file(
                                                          File(controller
                                                              .selectedProfessionsVal[index]
                                                              .image!
                                                              .path),
                                                          fit: BoxFit
                                                              .cover,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      : GestureDetector(
                                                    onTap: () {
                                                      selectImagesProfessions(
                                                          index);
                                                    },
                                                    child:
                                                    Container(
                                                      // padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xFFE8ECF4),
                                                          borderRadius: BorderRadius.circular(
                                                              12),
                                                          border: Border.all(
                                                              color: Colors.grey,
                                                              width: 0.5)),
                                                      height: 120,
                                                      width: 180,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(12),
                                                        child: Image.network(
                                                          controller.selectedProfessionsVal[index].netImg ??
                                                              "",
                                                          fit: BoxFit
                                                              .cover,
                                                        ),

                                                      ),
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
                                                  padding: EdgeInsets
                                                      .only(
                                                      right:
                                                      5),
                                                  child: Text(
                                                    "Certificate is required",
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFF44336),
                                                        fontFamily:
                                                        'SEGOEUI',
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                ///----------Bank detail------------------

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
                                            print("INDEX_CHANGE------------$isCancelBtnTapped");
                                            print("PAYMENT_MOOD---------------${mobile.toString()}");
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                // color: isCancelBtnTapped  || controller.userDetailModel!.data!.paymentMode=='M'?  Color(0xFF149C48) : const Color(0xffE8EFF3),
                                                color: controller.userDetailModel!.data!.paymentMode=='M'?  Color(0xFF149C48) : const Color(0xffE8EFF3),
                                                width: 2,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(15)),
                                          height: 100,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(25.0),
                                            child: Image.asset("assets/images/mobile_money.png"),
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
                                            print("INDEX_CHANGE------------$isConfirmBtnTapped");
                                            print("PAYMENT_MOOD---------------${mobile.toString()}");
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: controller.userDetailModel!.data!.paymentMode=='B'?  Color(0xFF149C48) : const Color(0xffE8EFF3),
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.circular(15)),
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
                                      child: Text(
                                          mobileMoneyText,
                                          style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              fontFamily: 'SEGOEUI',
                                              fontWeight: FontWeight.w600,
                                              // color: isCancelBtnTapped ? Colors.black : Color(0xFF8391A1))),
                                              color: controller.userDetailModel!.data!.paymentMode=='M'?  Colors.black : Color(0xFF8391A1))),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(right: 40),
                                      child: Text
                                        (bankText,
                                          style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 0.2,
                                            fontFamily: 'SEGOEUI',
                                            fontWeight: FontWeight.w600,
                                            // color: isConfirmBtnTapped ? Colors.black : Color(0xFF8391A1),
                                            color: controller.userDetailModel!.data!.paymentMode=='B' ? Colors.black : Color(0xFF8391A1),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                controller.userDetailModel!.data!.paymentMode=='B'?
                                Column(
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
                                      controller:
                                      controller.accountName,
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
                                      controller:
                                      controller.accountNumber,
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
                                      controller: controller.bankName,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'Bank name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
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
                                    //   controller: controller.bankCode,
                                    //   validator: (value) {
                                    //     if (value == null ||
                                    //         value.isEmpty) {
                                    //       return 'Bank Code is required';
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
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
                                      hintText: "Branch Name",
                                      controller:
                                      controller.branchName,
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
                                ):
                                isConfirmBtnTapped ? Column(
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
                                      controller:
                                      controller.accountName,
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
                                      controller:
                                      controller.accountNumber,
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
                                      controller: controller.bankName,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'Bank name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
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
                                    //   controller: controller.bankCode,
                                    //   validator: (value) {
                                    //     if (value == null ||
                                    //         value.isEmpty) {
                                    //       return 'Bank Code is required';
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
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
                                      hintText: "Branch Name",
                                      controller:
                                      controller.branchName,
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
                                ):
                                controller.userDetailModel!.data!.paymentMode=='M'?
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      paymentDetailText,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SEGOEUI'),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
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
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    textField(
                                      textInputAction: TextInputAction.next,
                                      enabled: false,
                                      keyBoardType: TextInputType.number,
                                      prefix: const Icon(
                                        Icons.cabin,
                                        color: Colors.transparent,
                                        size: 8,
                                      ),
                                      fillColor: const Color(0xFFE8ECF4),
                                      textAlign: TextAlign.start,
                                      // hintText: "Enter your phone",
                                      hintText: 'Enter your Phone',
                                      controller: controller.phoneNo1,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            controller.phoneNo1.text.length != 10) {
                                          return 'Please enter valid phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      registeredText,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SEGOEUI'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFE8ECF4),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          border: Border.all(color: Colors.grey)),
                                      height: 50,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            CountryCodePicker(
                                              enabled: false,
                                              countryFilter: const [
                                                "UG",
                                                "KE"
                                              ],
                                              textStyle: const TextStyle(
                                                color: Color(0xFf8391A1),
                                              ),
                                              onInit: (value) => "256",
                                              initialSelection: '256',
                                              dialogSize:
                                              const Size.fromWidth(
                                                  330),
                                              onChanged: (value) {
                                                setState(() {
                                                  countryCode1 = value.dialCode!;
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
                                                enabled: false,
                                                style: const TextStyle(
                                                    fontFamily: 'SEGOEUI',
                                                    fontSize: 16,
                                                    letterSpacing: 0.2,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold),
                                                controller: controller.phoneNo2,
                                                keyboardType:
                                                TextInputType.number,
                                                decoration:
                                                InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.only(
                                                      right: 10),
                                                  border: InputBorder.none, focusedBorder:
                                                InputBorder.none,
                                                  enabledBorder:
                                                  InputBorder.none, errorBorder:
                                                InputBorder.none, disabledBorder:
                                                InputBorder.none,
                                                  hintText: 'Enter your Phone',
                                                  hintStyle: TextStyle(
                                                    color: Color(0xFF8391A1),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                ):
                                Container(),

                                ///----------Mobile Money detail------------------


                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.start,
                                //   children: [
                                //     Checkbox(
                                //       activeColor:
                                //       const Color(0xFF149C48),
                                //       checkColor: Colors.white,
                                //       value: isChecked,
                                //       onChanged: (bool? value) {
                                //         setState(() {
                                //           isChecked = value!;
                                //         });
                                //       },
                                //     ),
                                //      Text(privacyText),
                                //   ],
                                // ),
                                //  SizedBox(
                                //   height: 10,
                                // ),
                                // showErrorMessage
                                //     ?  Text(
                                //   "Accept terms and conditions before sign up",
                                //   style: TextStyle(
                                //       color: Color(0xFFF44336),
                                //       fontFamily: 'SEGOEUI',
                                //       fontWeight:
                                //       FontWeight.bold),
                                // )
                                //     : Container(),

                                const SizedBox(
                                  height: 30,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print('On register tap');

                                    for (int i = 0;
                                    i < controller.selectedProfessionsVal.length; i++) {
                                      print('--item $i is');
                                      var data = controller.selectedProfessionsVal[i];
                                      print('----------------');
                                      if (data.image == null ||
                                          data.image == '') {
                                        controller.professionsImageValidation[i] = true;
                                      } else {
                                        controller.professionsImageValidation[i] = false;
                                      }
                                    }

                                    if (_formKey.currentState!.validate()) {


                                      isPhone1 = false;
                                      isPhone2 = false;

                                      print('update profile call');
                                      controller.updateProfile(
                                          selectedImageUrl:selectedImageUrl,
                                          selectedImageUrl1:selectedImageUrl1,
                                          selectedImageUrl2:selectedImageUrl2,
                                          chosenValue4:_chosenValue4,
                                          countryCode1:countryCode1,
                                          mobile:mobile,
                                      );

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
                                          "Upadate Profile",
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.w600,
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
      ),
    );
  }
}
