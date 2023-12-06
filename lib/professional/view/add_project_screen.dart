// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/controller/add_project_controller.dart';
import 'package:wena_partners/professional/custom_widgets/commn_widgets.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // String? _chosenValue4 = "Admin";
  String? chosenValue;

  final _formKey = GlobalKey<FormState>();

  File? imageFile1;
  File? imageFile2;

  String? image1;
  String? image2;

  bool imageError1 = false;
  bool imageError2 = false;

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


  String? userId;

  id() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userId = sp.getString("user_id");
    });
    print("USER_ID----------${userId.toString()}");
  }


  @override
  void initState() {
    id();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
       child:  SafeArea(
          child: Scaffold(
            body: GetBuilder<AddProjectController>(
                id: 'project',
                init: AddProjectController(),
                builder: (controller) {
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
                              "Create Project",
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
                                 controller: titleController,
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
                               value: chosenValue,
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
                               onChanged: (salutation) => setState(() => chosenValue = salutation),
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
                                 controller: descriptionController,
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

                             imageFile1 != '' && imageFile1 != null
                             ? SizedBox(
                               height: 250,
                               width: double.infinity,
                               child: DottedBorder(
                                   borderType: BorderType.RRect,
                                   radius: const Radius.circular(20),
                                   color: Colors.grey,
                                   strokeWidth: 2,
                                   child: GestureDetector(
                                     onTap: (){
                                       _getFromGallery1();
                                     },
                                     child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(15),child: SizedBox(height: 250,child: Image.file(imageFile1!, fit: BoxFit.cover)))),
                                   )
                               ),
                             )
                              : SizedBox(
                               height: 250,
                                   width: double.infinity,
                                   child: DottedBorder(
                               borderType: BorderType.RRect,
                               radius: const Radius.circular(20),

                               color: Colors.grey,
                               strokeWidth: 2,
                                   child: GestureDetector(
                                   onTap: (){
                                     _getFromGallery1();
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
                                 ),

                              const SizedBox(
                               width: 20,
                             ),

                             const SizedBox(
                               height: 14,
                             ),

                             Row(
                               children: [
                                 imageError1 == true
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

                              // controller.addProject(
                              //   // id: userId.toString(),
                              //   id: '288',
                              //   title: titleController.text.toString(),
                              //   // service: '3',
                              //   service: _chosenValue4.toString(),
                              //   image1: imageFile1!.path,
                              //   description: descriptionController.text.toString(),
                              //   context: context,
                              // );

                              ///-------image required condition------------

                              if(imageFile1==null){
                                setState(() {
                                  imageError1 = true;
                                });
                              }

                              else{
                                controller.addProject(
                                  // id: userId.toString(),
                                  id: '288',
                                  title: titleController.text.toString(),
                                  // service: '3',
                                  service: chosenValue.toString(),
                                  image1: imageFile1!.path,
                                  description: descriptionController.text.toString(),
                                  context: context,
                                );
                              }
                            }

                            // print("User_Id-----------------${userId.toString()}");
                            print("User_Id-----------------${'288'}");
                            print("title-----------------${titleController.text}");
                            print("service-----------------${chosenValue.toString()}");
                            print("image1-----------------$imageFile1");
                            print("description-----------------${descriptionController.text}");

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              color: const Color(0xFF149C48),
                              child: const Center(
                                child: Text(
                                  "Post",
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
