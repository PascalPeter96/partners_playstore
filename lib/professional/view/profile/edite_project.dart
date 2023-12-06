// ignore_for_file: unrelated_type_equality_checks, avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:wena_partners/professional/controller/edit_project_controller.dart';
import 'package:wena_partners/professional/custom_widgets/commn_widgets.dart';


class EditProject extends StatefulWidget {

  String? intglcode;

  EditProject(this.intglcode,{Key? key}) : super(key: key);

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {

  // final TextEditingController titleController = TextEditingController();
  // final TextEditingController descriptionController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  // File? imageFile1;
  // File? imageFile2;
  //
  // String? image1;
  // String? image2;
  //
  // bool imageError1 = false;
  // bool imageError2 = false;
  //
  // _getFromGallery1() async {
  //   XFile? pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       image1 = '';
  //       imageError1 = false;
  //       imageFile1 = File(pickedFile.path);
  //     });
  //   }
  // }
  //
  // _getFromGallery2() async {
  //   XFile? pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       image2 = '';
  //       imageError2 = false;
  //       imageFile2 = File(pickedFile.path);
  //     });
  //   }
  // }


  List<Media>? _listImagePaths1;

  var selectedImageUrl1;

  String? image;
  String? image1;

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


  @override
  void initState() {
    // TODO: implement initState
    widget.intglcode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:  SafeArea(
        child: Scaffold(
          body: GetBuilder<EditProjectController>(
              id: 'Edit',
              init: EditProjectController(widget.intglcode),
              builder: (controller) {
                print("DROPDOWN_VALUE==================${controller.chosenValue.toString()}");
                return controller.isHomeLoad == true?
                const Center(child: CircularProgressIndicator(),):
                Padding(
                  padding: const EdgeInsets.all(15),
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
                            "Edit Project",
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
                      ///------------old view--------------
                      // Expanded(
                      //   child: SingleChildScrollView(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 30),
                      //         child: textField(
                      //           fillColor: const Color(0xFFE8ECF4),
                      //           textAlign: TextAlign.start,
                      //           hintText: "Title",
                      //           prefix: const Icon(
                      //             Icons.cabin,
                      //             color: Colors.transparent,
                      //             size: 8,
                      //           ),
                      //           controller: controller.titleController,
                      //           validator: (value) {
                      //             if (value == null || value.isEmpty) {
                      //               return 'Title is required';
                      //             }
                      //             return null;
                      //           },
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 22,
                      //       ),
                      //       DropdownButtonFormField<String>(
                      //         style: const TextStyle(
                      //             fontFamily: 'SEGOEUI',
                      //             fontSize: 16,
                      //             letterSpacing: 0.2,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold),
                      //         decoration: InputDecoration(
                      //           prefix: const Icon(
                      //             Icons.cabin,
                      //             color: Colors.transparent,
                      //             size: 8,
                      //           ),
                      //           errorStyle: const TextStyle(
                      //               fontSize: 13,
                      //               fontWeight: FontWeight.bold,
                      //               color: Color(0xFFF44336),
                      //               letterSpacing: 0.2,
                      //               fontFamily: 'SEGOEUI'),
                      //           border: OutlineInputBorder(
                      //             borderRadius:
                      //             BorderRadius.circular(12.0),
                      //             borderSide: const BorderSide(
                      //                 color: Colors.grey,
                      //                 width: 0.6),
                      //           ),
                      //           // disabledBorder: InputBorder.none,
                      //           contentPadding:
                      //           const EdgeInsets.fromLTRB(
                      //               0.0, 14.0, 10.0, 14.0),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius:
                      //             BorderRadius.circular(12.0),
                      //             borderSide: const BorderSide(
                      //                 color: Colors.grey,
                      //                 width: 0.6),
                      //           ),
                      //           disabledBorder:
                      //           OutlineInputBorder(
                      //             borderRadius:
                      //             BorderRadius.circular(12.0),
                      //             borderSide: const BorderSide(
                      //                 color: Colors.grey,
                      //                 width: 0.6),
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius:
                      //             BorderRadius.circular(12.0),
                      //             borderSide: const BorderSide(
                      //                 color: Colors.grey,
                      //                 width: 0.6),
                      //           ),
                      //           // errorBorder: InputBorder.none,
                      //           errorBorder: OutlineInputBorder(
                      //             borderSide: const BorderSide(
                      //                 color: Colors.grey,
                      //                 width: 0.6),
                      //             borderRadius:
                      //             BorderRadius.circular(12.0),
                      //           ),
                      //           filled: true,
                      //           fillColor:
                      //           const Color(0xFFE8ECF4),
                      //         ),
                      //         dropdownColor: Colors.white,
                      //         value: _chosenValue4,
                      //         hint: const Padding(
                      //           padding: EdgeInsets.only(top: 5),
                      //           child: Text(
                      //             'Select Network',
                      //             style: TextStyle(
                      //               color: Color(0xFF8391A1),
                      //               fontWeight: FontWeight.w600,
                      //               fontFamily: 'SEGOEUI',
                      //               fontSize: 14,
                      //               letterSpacing: 0.2,
                      //             ),
                      //           ),
                      //         ),
                      //         onChanged: (salutation) => setState(() => _chosenValue4 = salutation),
                      //         validator: (value) => value == null
                      //             ? 'Select Network is required'
                      //             : null,
                      //         items: [
                      //           'Admin',
                      //           'Demo',
                      //           'Test',
                      //         ].map<DropdownMenuItem<String>>(
                      //                 (String value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Text(value),
                      //               );
                      //             }).toList(),
                      //       ),
                      //       const SizedBox(
                      //         height: 22,
                      //       ),
                      //        const Text(
                      //         nationalIdText,
                      //         style: TextStyle(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.w600,
                      //             fontFamily: 'SEGOEUI'),
                      //       ),
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                      //       GestureDetector(
                      //         onTap: (){
                      //           pickFromCamera1();
                      //         },
                      //         child:  Container(
                      //           decoration: BoxDecoration(
                      //             color: const Color(0xFFE8ECF4),
                      //             borderRadius: BorderRadius.circular(12),
                      //             border: Border.all(color: Colors.grey, width: 0.5),
                      //           ),
                      //           height: 120,
                      //           width: 180,
                      //           child: selectedImageUrl1 != '' && selectedImageUrl1 != null?
                      //           Image.file(File(selectedImageUrl1),fit: BoxFit.cover,):
                      //           image1!=''&&image1!= null?
                      //           Container(
                      //               decoration: BoxDecoration(
                      //                 color: const Color(0xFFE8ECF4),
                      //                 borderRadius: BorderRadius.circular(12),
                      //                 border: Border.all(color: Colors.grey, width: 0.5),
                      //               ),
                      //               height: 120,
                      //               width: 180,
                      //               child: Column(
                      //                 children: [
                      //                   GestureDetector(
                      //                     onTap: () {
                      //                       pickFromCamera1();
                      //                     },
                      //                     child: Container(
                      //                       padding:
                      //                       const EdgeInsets
                      //                           .only(
                      //                           top: 15,
                      //                           bottom: 8),
                      //                       child:
                      //                       SvgPicture.asset(
                      //                         "assets/images/upload.svg",
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   const Text(
                      //                     "Upload front side",
                      //                     style: TextStyle(
                      //                         fontSize: 12,
                      //                         letterSpacing: 0.2,
                      //                         fontFamily:
                      //                         'SEGOEUI',
                      //                         fontWeight:
                      //                         FontWeight.w600,
                      //                         color: Color(
                      //                             0xFF8391A1)),
                      //                   ),
                      //                 ],
                      //               )):
                      //           CachedNetworkImage(
                      //             imageUrl:  "${controller.editProjectModel!.data![0].varImageLink}",
                      //             imageBuilder: (context, imageProvider) => Container(
                      //               decoration: BoxDecoration(
                      //                 image: DecorationImage(
                      //                   image: imageProvider,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //             // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                      //             placeholder: (context, url) => const CupertinoActivityIndicator(),
                      //             errorWidget: (context, url, error) => const Icon(Icons.error),
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 14,
                      //       ),
                      //       Row(
                      //         children: [
                      //           controller.imageError1 == true
                      //               ? const Text(
                      //             "Front side Id is required",
                      //             style: TextStyle(
                      //                 color: Color(0xFFF44336),
                      //                 fontFamily: 'SEGOEUI',
                      //                 fontWeight: FontWeight.bold),
                      //           )
                      //               : Container(),
                      //
                      //           const Spacer(),
                      //           controller.imageError2 == true
                      //               ? const Padding(
                      //             padding: EdgeInsets.only(right: 10),
                      //               child: Text(
                      //               "Back side Id is required",
                      //               style: TextStyle(
                      //                   color: Color(0xFFF44336),
                      //                   fontFamily: 'SEGOEUI',
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           )
                      //               : Container(),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 5,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 12,bottom: 20),
                      //         child: textField(
                      //           fillColor: const Color(0xFFE8ECF4),
                      //           textAlign: TextAlign.start,
                      //           hintText: "Description",
                      //           prefix: const Icon(
                      //             Icons.cabin,
                      //             color: Colors.transparent,
                      //             size: 8,
                      //           ),
                      //           controller: controller.descriptionController,
                      //           validator: (value) {
                      //             if (value == null || value.isEmpty) {
                      //               return 'Description is required';
                      //             }
                      //             return null;
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // ),

                      ///------new view--------------
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: textField(
                                  textInputAction: TextInputAction.next,
                                  fillColor: const Color(0xFFE8ECF4),
                                  textAlign: TextAlign.start,
                                  hintText: "Project Name",
                                  prefix: const Icon(
                                    Icons.cabin,
                                    color: Colors.transparent,
                                    size: 8,
                                  ),
                                  controller: controller.titleController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Title is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 22,
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
                                value: controller.chosenValue,
                                hint: const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Select Service',
                                    style: TextStyle(
                                      color: Color(0xFF8391A1),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'SEGOEUI',
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                onChanged: (salutation) => setState(() => controller.chosenValue = salutation),
                                validator: (value) => value == null
                                    ? 'Select Network is required'
                                    : null,
                                items: [
                                  'Admin',
                                  'Demo',
                                  'Test',
                                ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12,bottom: 20),
                                child: textField(
                                  maxLines: 4,
                                  fillColor: const Color(0xFFE8ECF4),
                                  textAlign: TextAlign.start,
                                  hintText: "Description",

                                  prefix: const Icon(
                                    Icons.cabin,
                                    color: Colors.transparent,
                                    size: 8,
                                  ),
                                  controller: controller.descriptionController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Description is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 22,
                              ),

                              // imageFile1 != '' && imageFile1 != null
                              //     ? SizedBox(
                              //   height: 250,
                              //   width: double.infinity,
                              //   child: DottedBorder(
                              //       borderType: BorderType.RRect,
                              //       radius: const Radius.circular(20),
                              //       color: Colors.grey,
                              //       strokeWidth: 2,
                              //       child: GestureDetector(
                              //         onTap: (){
                              //           _getFromGallery1();
                              //         },
                              //         child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Container(height: 250,child: Image.file(imageFile1!, fit: BoxFit.cover)))),
                              //       )
                              //   ),
                              // )
                              //     : SizedBox(
                              //   height: 250,
                              //   width: double.infinity,
                              //   child: DottedBorder(
                              //       borderType: BorderType.RRect,
                              //       radius: const Radius.circular(20),
                              //
                              //       color: Colors.grey,
                              //       strokeWidth: 2,
                              //       child: GestureDetector(
                              //         onTap: (){
                              //           _getFromGallery1();
                              //         },
                              //         child: Column(
                              //           mainAxisAlignment: MainAxisAlignment.center,
                              //           crossAxisAlignment: CrossAxisAlignment.center  ,
                              //           children: [
                              //             Center(child: Image.asset("assets/images/alubam.png")),
                              //             const SizedBox(height: 12,),
                              //             const Text(
                              //               "Add Photos",
                              //               style: TextStyle(
                              //                 fontSize: 18,
                              //                 letterSpacing: 0.2,
                              //                 fontFamily: 'SEGOEUI',
                              //                 fontWeight: FontWeight.w700,
                              //                 color: Color(0xFF8391A1),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       )
                              //   ),
                              // ),

                              // GestureDetector(
                              //   onTap: (){
                              //     pickFromCamera1();
                              //   },
                              //   child:  Container(
                              //     decoration: BoxDecoration(
                              //       color: const Color(0xFFE8ECF4),
                              //       borderRadius: BorderRadius.circular(12),
                              //       border: Border.all(color: Colors.grey, width: 0.5),
                              //     ),
                              //     height: 120,
                              //     width: 180,
                              //     child: selectedImageUrl1 != '' && selectedImageUrl1 != null?
                              //     Image.file(File(selectedImageUrl1),fit: BoxFit.cover,):
                              //     image1!=''&&image1!= null?
                              //     Container(
                              //         decoration: BoxDecoration(
                              //           color: const Color(0xFFE8ECF4),
                              //           borderRadius: BorderRadius.circular(12),
                              //           border: Border.all(color: Colors.grey, width: 0.5),
                              //         ),
                              //         height: 120,
                              //         width: 180,
                              //         child: Column(
                              //           children: [
                              //             GestureDetector(
                              //               onTap: () {
                              //                 pickFromCamera1();
                              //               },
                              //               child: Container(
                              //                 padding:
                              //                 const EdgeInsets
                              //                     .only(
                              //                     top: 15,
                              //                     bottom: 8),
                              //                 child:
                              //                 SvgPicture.asset(
                              //                   "assets/images/upload.svg",
                              //                 ),
                              //               ),
                              //             ),
                              //             const Text(
                              //               "Upload front side",
                              //               style: TextStyle(
                              //                   fontSize: 12,
                              //                   letterSpacing: 0.2,
                              //                   fontFamily:
                              //                   'SEGOEUI',
                              //                   fontWeight:
                              //                   FontWeight.w600,
                              //                   color: Color(
                              //                       0xFF8391A1)),
                              //             ),
                              //           ],
                              //         )):
                              //     CachedNetworkImage(
                              //       imageUrl:  "${controller.editProjectModel!.data![0].varImageLink}",
                              //       imageBuilder: (context, imageProvider) => Container(
                              //         decoration: BoxDecoration(
                              //           image: DecorationImage(
                              //             image: imageProvider,
                              //             fit: BoxFit.cover,
                              //           ),
                              //         ),
                              //       ),
                              //       // placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                              //       placeholder: (context, url) => const CupertinoActivityIndicator(),
                              //       errorWidget: (context, url, error) => const Icon(Icons.error),
                              //     ),
                              //   ),
                              //
                              //
                              // ),


                              SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(20),
                                    color: Colors.grey,
                                    strokeWidth: 2,
                                    child: GestureDetector(
                                      onTap: (){
                                        pickFromCamera1();
                                      },
                                      child: Center(
                                          child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                           child: SizedBox(
                                               height: 250,
                                           child: selectedImageUrl1 != '' && selectedImageUrl1 != null?
                                           Image.file(File(selectedImageUrl1),fit: BoxFit.cover,):
                                           image1!=''&&image1!= null?
                                           SizedBox(
                                             height: 250,
                                             width: double.infinity,
                                             child: DottedBorder(
                                                 borderType: BorderType.RRect,
                                                 radius: const Radius.circular(20),

                                                 color: Colors.grey,
                                                 strokeWidth: 2,
                                                 child: GestureDetector(
                                                   onTap: (){
                                                     pickFromCamera1();
                                                   },
                                                   child: Column(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     crossAxisAlignment: CrossAxisAlignment.center  ,
                                                     children: [
                                                       Center(child: Image.asset("assets/images/alubam.png")),
                                                       const SizedBox(height: 12,),
                                                       const Text(
                                                         "Add Photos",
                                                         style: TextStyle(
                                                           fontSize: 18,
                                                           letterSpacing: 0.2,
                                                           fontFamily: 'SEGOEUI',
                                                           fontWeight: FontWeight.w700,
                                                           color: Color(0xFF8391A1),
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 )
                                             ),
                                           ):
                                           CachedNetworkImage(
                                             imageUrl:  "${controller.editProjectModel?.data![0].varImageLink}",
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

                                    )
                                ),
                              ),


                              const SizedBox(
                                width: 20,
                              ),

                              const SizedBox(
                                height: 14,
                              ),

                              Row(
                                children: [
                                  controller.imageError1 == true
                                      ? const Text(
                                    "Image is required",
                                    style: TextStyle(
                                        color: Color(0xFFF44336),
                                        fontFamily: 'SEGOEUI',
                                        fontWeight: FontWeight.bold),
                                  )
                                      : Container(),
                                ],
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                            ],
                          ),
                        ),),



                      GestureDetector(
                        onTap: () async {

                          print('On add project');

                          if (_formKey.currentState!.validate()) {
                            controller.updateProject(selectedImageUrl:selectedImageUrl1);

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
                                "Upadate",
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
                );
              }
          ),
        ),
      ),

    );
  }
}
