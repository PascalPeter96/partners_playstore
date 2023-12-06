import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/auth/delivery_initial_screen.dart';
import 'package:wena_partners/delivery/screens/auth/delivery_phone_login.dart';
import 'package:wena_partners/delivery/screens/auth/privacy_policy_screen.dart';
import 'package:wena_partners/delivery/screens/home/delivery_bottom_navbar.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class DeliveryEditProfileScreen extends StatefulWidget {
  const DeliveryEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryEditProfileScreen> createState() => _DeliveryEditProfileScreenState();
}

class _DeliveryEditProfileScreenState extends State<DeliveryEditProfileScreen> {

  final TextEditingController businessNameCont = TextEditingController();
  final TextEditingController firstnameCont = TextEditingController();
  final TextEditingController surnameCont = TextEditingController();
  final TextEditingController phoneCont = TextEditingController();
  final TextEditingController addressCont = TextEditingController();
  final TextEditingController kinFirstnameCont = TextEditingController();
  final TextEditingController kinSurnameCont = TextEditingController();
  final TextEditingController kinPhoneCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();
  final TextEditingController passwordCont = TextEditingController();
  final TextEditingController vehicleNameCont = TextEditingController();
  final TextEditingController accNumberCont = TextEditingController();
  final TextEditingController vehicleModelCont = TextEditingController();
  final TextEditingController vehicleNumberCont = TextEditingController();
  final TextEditingController companyNameCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String fnameError = '';
  String snameError = '';
  String phoneError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPassError = '';
  String addressError = '';

  String _countryCode = "+256";

  final List<String> districts = [
    'Kampala', 'Wakiso', 'Mukono', 'Masaka', 'Mbarara', 'Fort Portal', 'Hoima', 'Gulu', 'Mbale', 'Jinja'
  ];

  late String selectedDeliveryValue;
  String? selectedValue;
  String districtError = '';
  bool isChecked = false;

  bool showPass = true;
  bool showConfirmPass = true;

  final countryPicker = const FlCountryCodePicker();
  late CountryCode deliveryCountryCode;
  late CountryCode kinCountryCode;

  String password = '';

  String vehicleError = '';
  String profileError = '';
  String deliveryFrontError = '';
  String deliveryBackError = '';
  String kinFrontError = '';
  String kinBackError = '';

  File? vehicleImage;
  File? profileImage;
  File? deliveryFrontImage;
  File? deliveryBackImage;
  File? kinFrontImage;
  File? kinBackImage;

  pickDeliveryFrontImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        deliveryFrontImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }
  pickDeliveryBackImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        deliveryBackImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickKinFrontImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        kinFrontImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }
  pickKinBackImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        kinBackImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickProfileImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        profileImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }
  pickVehicleImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        vehicleImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }


  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(5, errorText: 'password must be at least 5 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'input does\'nt match email'),
  ]);

  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'first name required'),
    MinLengthValidator(2, errorText: 'first name too short'),
    MaxLengthValidator(15, errorText: 'first name too long'),
  ]);
  final surnameValidator = MultiValidator([
    RequiredValidator(errorText: 'surname required'),
    MinLengthValidator(2, errorText: 'surname too short'),
    MaxLengthValidator(15, errorText: 'surname too long'),
  ]);

  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'phone is required'),
    MinLengthValidator(9, errorText: 'phone number is short'),
    MaxLengthValidator(9, errorText: 'phone number has exceeded'),
  ]);

  final kinFirstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'first name required'),
    MinLengthValidator(2, errorText: 'first name too short'),
    MaxLengthValidator(15, errorText: 'first name too long'),
  ]);
  final kinSurnameValidator = MultiValidator([
    RequiredValidator(errorText: 'surname required'),
    MinLengthValidator(2, errorText: 'surname too short'),
    MaxLengthValidator(15, errorText: 'surname too long'),
  ]);

  final kinPhoneValidator = MultiValidator([
    RequiredValidator(errorText: 'phone is required'),
    MinLengthValidator(9, errorText: 'phone number is short'),
    MaxLengthValidator(9, errorText: 'phone number has exceeded'),
  ]);

  final vehicleNameValidator = MultiValidator([
    RequiredValidator(errorText: 'vehicle name required'),
    MinLengthValidator(4, errorText: 'vehicle name too short'),
    MaxLengthValidator(15, errorText: 'vehicle name too long'),
  ]);

  final addressValidator = MultiValidator([
    RequiredValidator(errorText: 'address required'),
    MinLengthValidator(4, errorText: 'address too short'),
    MaxLengthValidator(15, errorText: 'address too long'),
  ]);

  final vehicleModelValidator = MultiValidator([
    RequiredValidator(errorText: 'vehicle model required'),
    MinLengthValidator(4, errorText: 'vehicle model too short'),
    MaxLengthValidator(15, errorText: 'vehicle model too long'),
  ]);

  final vehicleNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'vehicle number required'),
    MinLengthValidator(4, errorText: 'vehicle number too short'),
    MaxLengthValidator(15, errorText: 'vehicle number too long'),
  ]);

  final companyNameValidator = MultiValidator([
    RequiredValidator(errorText: 'company name required'),
    MinLengthValidator(4, errorText: 'company name too short'),
    MaxLengthValidator(15, errorText: 'company name too long'),
  ]);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deliveryCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    kinCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    selectedDeliveryValue = 'Individual';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: TitleAppBar(
          title: 'Edit Profile',
          titleWidget: Container(width: 10.w,),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: FadeInUp(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.sp)
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: firstnameCont,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: AppTheme.borderColor2,
                                      hintText: 'First Name',
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),
                                    validator: firstNameValidator,
                                  ),
                                ),
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.sp)
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: surnameCont,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor: AppTheme.borderColor2,
                                      hintText: 'Surname',
                                    ),
                                    validator: surnameValidator,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 3.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Email',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: emailValidator,
                            ),
                          ),

                          SizedBox(
                            height: 3.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: passwordCont,
                              obscureText: showPass,
                              onChanged: (val){
                                password = val;
                                print(password);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Password',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                suffixIcon: Bounceable(
                                  onTap: (){
                                    setState((){
                                      showPass = !showPass;
                                    });
                                  },
                                  child: showPass ? Icon(Icons.visibility_off, color: AppTheme.primaryColor,)
                                      : Icon(Icons.visibility, color: AppTheme.primaryColor),
                                ),
                              ),
                              validator: passwordValidator,
                            ),
                          ),

                          SizedBox(
                            height: 3.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              controller: phoneCont,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Bounceable(
                                    onTap: () async {
                                      final code = await countryPicker.showPicker(context: context);
                                      setState((){
                                        deliveryCountryCode = code!;
                                      });
                                      print(deliveryCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          deliveryCountryCode.flagImage,
                                          Container(
                                            child: Text(deliveryCountryCode.dialCode ),
                                          ),
                                          Icon(Icons.keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Enter Your Phone',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: phoneValidator,
                            ),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Upload Profile Image', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInLeft(
                                child: GestureDetector(
                                  onTap: (){
                                    pickProfileImage();
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.sp),
                                      child: SizedBox(
                                          height: 20.h,
                                          width: 43.w,
                                          child: profileImage != null?
                                          Image.file(File(profileImage!.path.toString()),fit: BoxFit.cover,):
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.borderColor2,
                                              borderRadius: BorderRadius.circular(15.sp),
                                              border: Border.all(color: Colors.grey, width: 0.1),
                                            ),
                                            height: 20.h,
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    pickProfileImage();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                        top: 15, bottom: 8),
                                                    child: SvgPicture.asset(
                                                      "assets/images/upload.svg",
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Upload Profile Pic",
                                                  style: AppTheme.subtitleSmall,
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                              profileError=='' ?  Container() : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                child: Text(profileError, style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red.shade800,

                                ),),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 3.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: addressCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Address',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: addressValidator,
                            ),
                          ),



                          SizedBox(
                            height: 3.h,
                          ),


                          Container(
                            height: 5.5.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              color: AppTheme.borderColor2,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                // buttonPadding: EdgeInsets.only(left: 0.0.w),
                                alignment: Alignment.center,
                                // buttonPadding: EdgeInsets.only(right: 3.w),
                                // dropdownPadding: EdgeInsets.only(left: 2.w),
                                hint: Text(
                                  selectedValue ?? 'District*',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17.5.sp,
                                      color: Colors.black54
                                  ),
                                ),
                                items: districts
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item.toString(),
                                        style:  TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                                // buttonHeight: 40,
                                // buttonWidth: 140,
                                // itemHeight: 40,
                              ),
                            ),
                          ),

                          districtError=='' ?  Container() : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                            child: Text(districtError, style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red.shade800,

                            ),),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Driver National ID', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  FadeInLeft(
                                    child: GestureDetector(
                                      onTap: (){
                                        pickDeliveryFrontImage();
                                      },
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.sp),
                                          child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: deliveryFrontImage != null?
                                              Image.file(File(deliveryFrontImage!.path.toString()),fit: BoxFit.cover,):
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppTheme.borderColor2,
                                                  borderRadius: BorderRadius.circular(15.sp),
                                                  border: Border.all(color: Colors.grey, width: 0.1),
                                                ),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickDeliveryFrontImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload front side",
                                                      style: AppTheme.subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  deliveryFrontError=='' ?  Container() : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(deliveryFrontError, style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red.shade800,

                                    ),),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  FadeInRight(
                                    child: GestureDetector(
                                      onTap: (){
                                        pickDeliveryBackImage();
                                      },
                                      child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15.sp),
                                            child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: deliveryBackImage != null?
                                              Image.file(File(deliveryBackImage!.path.toString()),fit: BoxFit.cover,):
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppTheme.borderColor2,
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                        color: Colors.grey, width: 0.1)),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickDeliveryBackImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload back side",
                                                      style: AppTheme.subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          )),

                                    ),
                                  ),
                                  deliveryBackError=='' ?  Container() : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(deliveryBackError, style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red.shade800,

                                    ),),
                                  ),

                                ],
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                child: Container(
                                  width: 42.5.w,
                                  child: RadioListTile(
                                    activeColor: AppTheme.primaryColor,
                                    value: 'Individual',
                                    groupValue: selectedDeliveryValue.toString(),
                                    onChanged: (value){
                                      setState((){
                                        selectedDeliveryValue = value as String;
                                      });
                                    },
                                    title:  Text('Individual',  style: AppTheme.subtitleSmall),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        side: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                                child: Container(
                                  width: 42.5.w,
                                  child: RadioListTile(
                                    activeColor: AppTheme.primaryColor,
                                    value: 'Company',
                                    groupValue: selectedDeliveryValue.toString(),
                                    onChanged: (value){
                                      setState((){
                                        selectedDeliveryValue = value as String;
                                      });
                                    },
                                    title:  Text('Company', style: AppTheme.subtitleSmall,),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.sp),
                                        side: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade300
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Company', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: companyNameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Company Name',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: companyNameValidator,
                            ),
                          ),


                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Vehicle Details', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: vehicleNameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Vehicle Name',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: vehicleNameValidator,
                            ),
                          ),

                          SizedBox(
                            height: 3.h,
                          ),


                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: vehicleModelCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Vehicle Model',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: vehicleModelValidator,
                            ),
                          ),

                          SizedBox(
                            height: 3.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: vehicleNumberCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Vehicle Number',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: vehicleNumberValidator,
                            ),
                          ),

                          SizedBox(
                            height: 3.h,
                          ),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInLeft(
                                child: GestureDetector(
                                  onTap: (){
                                    pickVehicleImage();
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.sp),
                                      child: SizedBox(
                                          height: 20.h,
                                          width: 43.w,
                                          child: vehicleImage != null?
                                          Image.file(File(vehicleImage!.path.toString()),fit: BoxFit.cover,):
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.borderColor2,
                                              borderRadius: BorderRadius.circular(15.sp),
                                              border: Border.all(color: Colors.grey, width: 0.1),
                                            ),
                                            height: 20.h,
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    pickVehicleImage();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                        top: 15, bottom: 8),
                                                    child: SvgPicture.asset(
                                                      "assets/images/upload.svg",
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Upload Vehicle Pic",
                                                  style: AppTheme.subtitleSmall,
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                              vehicleError=='' ?  Container() : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                child: Text(vehicleError, style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red.shade800,

                                ),),
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Next Of Kin', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.sp)
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: kinFirstnameCont,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: AppTheme.borderColor2,
                                    hintText: 'First Name',
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                  ),
                                  validator: kinFirstNameValidator,
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.sp)
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: kinSurnameCont,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: AppTheme.borderColor2,
                                    hintText: 'Surname',
                                  ),
                                  validator: kinSurnameValidator,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 3.h,
                          ),

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              controller: kinPhoneCont,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Bounceable(
                                    onTap: () async {
                                      final code = await countryPicker.showPicker(context: context);
                                      setState((){
                                        kinCountryCode = code!;
                                      });
                                      print(kinCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          kinCountryCode.flagImage,
                                          Container(
                                            child: Text(kinCountryCode.dialCode ),
                                          ),
                                          Icon(Icons.keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Enter Your Phone',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: kinPhoneValidator,
                            ),
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Next Of Kin National ID', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  FadeInLeft(
                                    child: GestureDetector(
                                      onTap: (){
                                        pickKinFrontImage();
                                      },
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.sp),
                                          child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: kinFrontImage != null?
                                              Image.file(File(kinFrontImage!.path.toString()),fit: BoxFit.cover,):
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppTheme.borderColor2,
                                                  borderRadius: BorderRadius.circular(15.sp),
                                                  border: Border.all(color: Colors.grey, width: 0.1),
                                                ),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickKinFrontImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload front side",
                                                      style: AppTheme.subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  kinFrontError=='' ?  Container() : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(kinFrontError, style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red.shade800,

                                    ),),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  FadeInRight(
                                    child: GestureDetector(
                                      onTap: (){
                                        pickKinBackImage();
                                      },
                                      child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15.sp),
                                            child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: kinBackImage != null?
                                              Image.file(File(kinBackImage!.path.toString()),fit: BoxFit.cover,):
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppTheme.borderColor2,
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(
                                                        color: Colors.grey, width: 0.1)),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickKinBackImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload back side",
                                                      style: AppTheme.subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          )),

                                    ),
                                  ),
                                  kinBackError=='' ?  Container() : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(kinBackError, style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red.shade800,

                                    ),),
                                  ),

                                ],
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 3.h,
                          ),


                          Row(
                            children: [
                              Checkbox(
                                activeColor: AppTheme.primaryColor,
                                value: isChecked,
                                onChanged: (value){
                                  setState((){
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                              TextButton(
                                onPressed: (){
                                  Get.to(() => PrivacyPolicyScreen());
                                },
                                child: Text('Privacy policy & Terms of Service', style: AppTheme.subtitleSmall,),

                              ),
                            ],
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

                          AppButton(
                            title: 'Agree and Register',
                            color: AppTheme.primaryColor,
                            function: (){

                              if(_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                print('okay');
                              }  if(selectedValue==null){
                                setState((){
                                  districtError = 'district required';
                                });
                                // Fluttertoast.showToast(msg: 'Pick district');
                              }  if(isChecked == false){
                                Fluttertoast.showToast(
                                  msg: 'Allow policy',
                                  textColor: Colors.red,
                                );
                              } else {
                                print(deliveryCountryCode.dialCode);
                                print(phoneCont.text.trim());
                                print(deliveryCountryCode.dialCode +phoneCont.text.trim());
                                Get.snackbar('Registered', 'Account Created Successfully');
                                // Get.off(() => DeliveryPhoneLogin());
                                Get.offAll(() => DeliveryBottomNavBar());

                              }

                            },
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Already have an account?', style: AppTheme.subtitleSmall,),

                              TextButton(
                                  onPressed: (){
                                    Get.off(() => DeliveryInitialScreen());
                                  },
                                  child: Text('Log in', style: AppTheme.greenNormal,)),

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
