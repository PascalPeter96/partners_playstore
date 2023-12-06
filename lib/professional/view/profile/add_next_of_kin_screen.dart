// ignore_for_file: prefer_typing_uninitialized_variables, unrelated_type_equality_checks, avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/controller/add_next_of_king_controller.dart';
import 'package:wena_partners/professional/custom_widgets/commn_widgets.dart';
import 'package:wena_partners/professional/utils/text.dart';


class AddNextOfKinScreen extends StatefulWidget {
  const AddNextOfKinScreen({Key? key}) : super(key: key);

  @override
  State<AddNextOfKinScreen> createState() => _AddNextOfKinScreenState();
}

class _AddNextOfKinScreenState extends State<AddNextOfKinScreen> {

  // final TextEditingController firstName = TextEditingController();
  // final TextEditingController surName = TextEditingController();
  // final TextEditingController phoneNo = TextEditingController();

  bool isPhone1 = false;

  // String countryCode = "256";

  final _formKey = GlobalKey<FormState>();

  String errorText = "";

  // File? imageFile1;
  // File? imageFile2;

  // String? image1;
  // String? image2;

  bool imageError1 = false;
  bool imageError2 = false;



  ///-------------------------------pick image----------------


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
      setState(() {
        image1 = '';
        selectedImageUrl1 = _listImagePaths1![0].path;
        print('image=======================>$selectedImageUrl1');
      });
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
      setState(() {
        image2 = '';
        selectedImageUrl2 = _listImagePaths2![0].path;
        print('image=======================>$selectedImageUrl2');
      });
    }else{
      print('null');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<AddNextOfKingController>(
              id: 'addNextOfKing',
              init: AddNextOfKingController(),
              builder: (controller) {
                return controller.nextOfKing == true?const Center(child: CircularProgressIndicator()):
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                "assets/icons/icon_back.png",
                                height: 40,
                              ),
                            ),
                            const Spacer(flex: 2),
                            const Text(
                              "Create Next of Kin",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "SEGOEUI",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: textField(
                                  fillColor: const Color(0xFFE8ECF4),
                                  textAlign: TextAlign.start,
                                  // hintText: "First Name",
                                  hintText: "First Name",
                                  prefix: const Icon(
                                    Icons.cabin,
                                    color: Colors.transparent,
                                    size: 8,
                                  ),
                                  controller: controller.firstName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
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
                                  prefix: const Icon(
                                    Icons.cabin,
                                    color: Colors.transparent,
                                    size: 8,
                                  ),
                                  fillColor: const Color(0xFFE8ECF4),
                                  textAlign: TextAlign.start,
                                  hintText: "Surname",
                                  controller: controller.surName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Surname is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8ECF4),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),),
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 50,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CountryCodePicker(
                                  countryFilter: const ["UG", "KE"],
                                  textStyle: const TextStyle(color: Color(0xFf8391A1)),
                                  onInit: (value) => "256",
                                  initialSelection: '256',
                                  dialogSize: const Size.fromWidth(330),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.countryCode = value.dialCode!;
                                      // print('codesign====${value.dialCode}');
                                    });
                                  },
                                  flagDecoration: BoxDecoration(
                                    color: const Color(0xFF8391A1),
                                    borderRadius: BorderRadius.circular(5),
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
                                    style: const TextStyle(
                                        fontFamily: 'SEGOEUI',
                                        fontSize: 16,
                                        letterSpacing: 0.2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    controller: controller.phoneNo,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(right: 10),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Enter your Phone',
                                      hintStyle: TextStyle(color: Color(0xFF8391A1)),
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
                        if(errorText != "")
                          Text(errorText,style: const TextStyle(color: Color(0xFFF44336),fontFamily: 'SEGOEUI',fontWeight: FontWeight.bold,fontSize: 13)),
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
                                onTap: (){
                                  pickFromCamera1();
                                },
                                child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 120,
                                        width: 180,
                                        child: selectedImageUrl1 != '' && selectedImageUrl1 != null?
                                        Image.file(File(selectedImageUrl1),fit: BoxFit.cover,):
                                        image1!=''&&image1!= null?
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFE8ECF4),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: Colors.grey, width: 0.5),
                                          ),
                                          height: 120,
                                          width: 180,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  pickFromCamera1();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      top: 15, bottom: 8),
                                                  child: SvgPicture.asset(
                                                    "assets/images/upload.svg",
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Upload front side",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    letterSpacing: 0.2,
                                                    fontFamily: 'SEGOEUI',
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF8391A1)),
                                              ),
                                            ],
                                          ),
                                        )
                                        : CachedNetworkImage(
                                          imageUrl:  "${controller.getKingDetail!.data!.varKinNationalIdFront}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                ),

                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Expanded(
                            //   child: imageFile2 != '' && imageFile2 != null
                            //       ? GestureDetector(
                            //     onTap: () {
                            //       _getFromGallery2();
                            //     },
                            //       child: Container(
                            //       // padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                            //       decoration: BoxDecoration(
                            //           color: const Color(0xFFE8ECF4),
                            //           borderRadius: BorderRadius.circular(12),
                            //           border: Border.all(
                            //               color: Colors.grey, width: 0.5)),
                            //       height: 120,
                            //       width: 180,
                            //       child: ClipRRect(
                            //           borderRadius: BorderRadius.circular(12),
                            //           child: Image.file(imageFile2!,
                            //               fit: BoxFit.cover)),
                            //     ),
                            //   )
                            //       : Container(
                            //     decoration: BoxDecoration(
                            //         color: const Color(0xFFE8ECF4),
                            //         borderRadius: BorderRadius.circular(12),
                            //         border: Border.all(
                            //             color: Colors.grey, width: 0.5)),
                            //     height: 120,
                            //     width: 180,
                            //     child: Column(
                            //       children: [
                            //         GestureDetector(
                            //           onTap: () {
                            //             _getFromGallery2();
                            //           },
                            //           child: Container(
                            //             padding: const EdgeInsets.only(
                            //                 top: 15, bottom: 8),
                            //             child: SvgPicture.asset(
                            //               "assets/images/upload.svg",
                            //             ),
                            //           ),
                            //         ),
                            //         const Text(
                            //           "Upload back side",
                            //           style: TextStyle(
                            //               fontSize: 12,
                            //               letterSpacing: 0.2,
                            //               fontFamily: 'SEGOEUI',
                            //               fontWeight: FontWeight.w600,
                            //               color: Color(0xFF8391A1)),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  pickFromCamera2();
                                },
                                child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 120,
                                        width: 180,
                                        child: selectedImageUrl2 != '' && selectedImageUrl2 != null?
                                        Image.file(File(selectedImageUrl2),fit: BoxFit.cover,):
                                        image2!=''&&image2!= null?
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFE8ECF4),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey, width: 0.5)),
                                          height: 120,
                                          width: 180,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  pickFromCamera2();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      top: 15, bottom: 8),
                                                  child: SvgPicture.asset(
                                                    "assets/images/upload.svg",
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                "Upload back side",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    letterSpacing: 0.2,
                                                    fontFamily: 'SEGOEUI',
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF8391A1)),
                                              ),
                                            ],
                                          ),
                                        )
                                            : CachedNetworkImage(
                                          imageUrl:  "${controller.getKingDetail!.data!.varKinNationalIdBack}",
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),


                                      ),
                                    )),

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
                                  color: Color(0xFFF44336),
                                  fontFamily: 'SEGOEUI',
                                  fontWeight: FontWeight.bold),
                            )
                                : Container(),
                            const Spacer(),
                            imageError2 == true
                                ? const Padding(
                              padding: EdgeInsets.only(right: 10),
                                child: Text(
                                "Back side Id is required",
                                style: TextStyle(
                                    color: Color(0xFFF44336),
                                    fontFamily: 'SEGOEUI',
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),


                        GestureDetector(
                          onTap: () async {
                            print('On register tap');
                            SharedPreferences prefs = await SharedPreferences.getInstance();

                            if (_formKey.currentState!.validate()) {

                              if(controller.phoneNo.text.isEmpty){
                                setState(() {
                                  errorText = "Enter the phone number";
                                });
                              }
                              else if(controller.phoneNo.text.length != 10){
                                setState(() {
                                  errorText = "Please enter 10 digit phone";
                                });
                              }
                              // else if(selectedImageUrl1==null){
                              //   setState(() {
                              //     imageError1 = true;
                              //
                              //   });
                              // }
                              // else if(selectedImageUrl2==null){
                              //   setState(() {
                              //     imageError2 = true;
                              //   });
                              // }

                              else{
                                errorText = "";
                                controller.addNextOfKingDetail(
                                  fName: controller.firstName.text,
                                  lName: controller.surName.text,
                                  context: context,
                                  mobileNo: controller.phoneNo.text,
                                  id:  prefs.getString('user_id').toString(),
                                  frontImage: selectedImageUrl1.toString(),
                                  backImage: selectedImageUrl2.toString(),
                                  countryCode: controller.countryCode.toString(),
                                );}
                            }
                            print('fName--------------${controller.firstName.text}');
                            print('sName--------------${controller.surName.text}');
                            print('phoneNO--------------${controller.phoneNo.text}');
                            print('userId--------------${prefs.getString('user_id').toString()}');
                            print('fImage--------------${selectedImageUrl1.toString()}');
                            print('sImage--------------${selectedImageUrl2.toString()}');
                            print('countryCode--------------${controller.countryCode.toString()}');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: const Color(0xFF149C48),
                              child: const Center(
                                child: Text(
                                  "Save",
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
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
