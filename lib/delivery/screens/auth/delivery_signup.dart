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


class DeliverySignUpScreen extends StatefulWidget {
  const DeliverySignUpScreen({Key? key}) : super(key: key);

  @override
  State<DeliverySignUpScreen> createState() => _DeliverySignUpScreenState();
}

class _DeliverySignUpScreenState extends State<DeliverySignUpScreen> {

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
  final TextEditingController accNameCont = TextEditingController();
  final TextEditingController accNumberCont = TextEditingController();
  final TextEditingController bankNameCont = TextEditingController();
  final TextEditingController vehicleModelCont = TextEditingController();
  final TextEditingController vehicleNumberCont = TextEditingController();
  final TextEditingController companyNameCont = TextEditingController();
  final TextEditingController registeredPhoneNameCont = TextEditingController();
  final TextEditingController mobileMoneyPhoneCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String fnameError = '';
  String snameError = '';
  String phoneError = '';
  String mobileMoneyError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPassError = '';
  String addressError = '';

  String _countryCode = "+256";

  final List<String> districts = [
    'Kampala', 'Wakiso', 'Mukono', 'Masaka', 'Mbarara', 'Fort Portal', 'Hoima', 'Gulu', 'Mbale', 'Jinja'
  ];
  final List<String> networks = [
    'Airtel', 'MTN',
  ];

  late String selectedDeliveryValue;
  String? selectedValue;
  String? selectedPaymentValue;
  String districtError = '';
  String networkError = '';
  bool isChecked = false;

  bool showPass = true;
  bool showConfirmPass = true;

  final countryPicker = const FlCountryCodePicker();
  late CountryCode deliveryCountryCode;
  late CountryCode mobileMoneyCountryCode;
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


  bool isCancelBtnTapped = true;
  bool isConfirmBtnTapped = false;

  String mobile = "M";

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
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(5, errorText: 'Password must be at least 5 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'Passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Input does\'nt match email'),
  ]);

  final firstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'First name required'),
    MinLengthValidator(2, errorText: 'First name too short'),
    MaxLengthValidator(15, errorText: 'First name too long'),
  ]);
  final surnameValidator = MultiValidator([
    RequiredValidator(errorText: 'Surname required'),
    MinLengthValidator(2, errorText: 'Surname too short'),
    MaxLengthValidator(15, errorText: 'Surname too long'),
  ]);

  final registeredPhoneNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Names required'),
    MinLengthValidator(2, errorText: 'Names too short'),
    MaxLengthValidator(20, errorText: 'Names too long'),
  ]);


  final phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone is required'),
    MinLengthValidator(9, errorText: 'Phone number is short'),
    MaxLengthValidator(9, errorText: 'Phone number has exceeded'),
  ]);

  final mobileMoneyPhoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Registered phone is required'),
    MinLengthValidator(9, errorText: 'Registered phone number is short'),
    MaxLengthValidator(9, errorText: 'Registered phone number has exceeded'),
  ]);

  final kinFirstNameValidator = MultiValidator([
    RequiredValidator(errorText: 'First name required'),
    MinLengthValidator(2, errorText: 'First name too short'),
    MaxLengthValidator(15, errorText: 'First name too long'),
  ]);
  final kinSurnameValidator = MultiValidator([
    RequiredValidator(errorText: 'Surname required'),
    MinLengthValidator(2, errorText: 'Surname too short'),
    MaxLengthValidator(15, errorText: 'Surname too long'),
  ]);

  final kinPhoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone is required'),
    MinLengthValidator(9, errorText: 'Phone number is short'),
    MaxLengthValidator(9, errorText: 'Phone number has exceeded'),
  ]);

  final vehicleNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Vehicle name required'),
    MinLengthValidator(4, errorText: 'Vehicle name too short'),
    MaxLengthValidator(15, errorText: 'Vehicle name too long'),
  ]);

  final accNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Account name required'),
    MinLengthValidator(4, errorText: 'Account name too short'),
    MaxLengthValidator(15, errorText: 'Account name too long'),
  ]);

  final accNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'Account Number required'),
    MinLengthValidator(4, errorText: 'Account Number too short'),
    MaxLengthValidator(15, errorText: 'Account Numbertoo long'),
  ]);

  final bankNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Bank Name required'),
    MinLengthValidator(4, errorText: 'Bank Name too short'),
    MaxLengthValidator(15, errorText: 'Bank Name too long'),
  ]);


  final addressValidator = MultiValidator([
    RequiredValidator(errorText: 'Address required'),
    MinLengthValidator(4, errorText: 'Address too short'),
    MaxLengthValidator(15, errorText: 'Address too long'),
  ]);

  final vehicleModelValidator = MultiValidator([
    RequiredValidator(errorText: 'Vehicle model required'),
    MinLengthValidator(4, errorText: 'Vehicle model too short'),
    MaxLengthValidator(15, errorText: 'Vehicle model too long'),
  ]);

  final vehicleNumberValidator = MultiValidator([
    RequiredValidator(errorText: 'Vehicle number required'),
    MinLengthValidator(4, errorText: 'Vehicle number too short'),
    MaxLengthValidator(15, errorText: 'Vehicle number too long'),
  ]);

  final companyNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Company name required'),
    MinLengthValidator(4, errorText: 'Company name too short'),
    MaxLengthValidator(15, errorText: 'Company name too long'),
  ]);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deliveryCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    mobileMoneyCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
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
          title: '',
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
                Text(
                  "Welcome to",
                  textAlign: TextAlign.start,
                  style: AppTheme.textTahomaColor292D32Size30,
                ),
                Text(
                  "Sign Up",
                  textAlign: TextAlign.start,
                  style: AppTheme.textTahomaColor292D32Size30,
                ),

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
                                hintText: 'Enter Your Phone Number',
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
                                  selectedValue ?? 'District',
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
                            height: 2.h,
                          ),
                          Text('Driver\'s National ID', style: AppTheme.sectionMediumTitle,),
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


                          selectedDeliveryValue == 'Individual' ? Container() : SizedBox(
                            height: 2.h,
                          ),
                          selectedDeliveryValue == 'Individual' ? Container() : Text('Company', style: AppTheme.sectionMediumTitle,),
                          selectedDeliveryValue == 'Individual' ? Container() : SizedBox(
                            height: 1.h,
                          ),

                          selectedDeliveryValue == 'Individual' ? Container() : Container(
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
                          Text('Choose Payment Method', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
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
                                        height: 12.5.h,
                                        width: 40.w,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(25.0),
                                          child: Image.asset(
                                              "assets/images/mobile_money.png"),
                                        ),
                                      ),
                                      Center(
                                        child: Text('Mobile Money',
                                          style:  mobile == 'B' ? AppTheme.subtitleSmall : AppTheme.sectionMediumBoldTitle,
                                        ),
                                      ),
                                    ],
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
                                  child: Column(
                                    children: [
                                      Container(
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
                                        height: 12.5.h,
                                        width: 40.w,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(25.0),
                                          child: Image.asset(
                                              "assets/images/bank.png"),
                                        ),
                                      ),
                                      Center(
                                        child: Text('Bank',
                                          style:  mobile == 'M' ? AppTheme.subtitleSmall : AppTheme.sectionMediumBoldTitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 2.h,
                          ),
                          mobile == 'M' ? Text('Choose Payment Method', style: AppTheme.sectionMediumTitle,)
                              : Text('Bank Details', style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),
                          mobile == 'M' ? Container(
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
                                hint: Padding(
                                  padding:  EdgeInsets.only(left: 3.w),
                                  child: Text(
                                    selectedPaymentValue ?? 'Mobile Money',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17.5.sp,
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                                items: networks
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
                                value: selectedPaymentValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentValue = value as String;
                                  });
                                },
                                // buttonHeight: 40,
                                // buttonWidth: 140,
                                // itemHeight: 40,
                              ),
                            ),
                          ) : Container(),

                          mobile == 'M' ? networkError=='' ?  Container() : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                            child: Text(networkError, style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red.shade800,
                            ),),
                          ) : Container(),


                          mobile == 'M' ? SizedBox(
                            height: 3.h,
                          ) : Container(),

                          mobile == 'M' ? Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: registeredPhoneNameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Enter Phone Registered Names',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: registeredPhoneNameValidator,
                            ),
                          ) : Container(),

                          mobile == 'M' ?SizedBox(
                            height: 3.h,
                          ) : Container(),


                          mobile == 'M' ? Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              controller: mobileMoneyPhoneCont,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Bounceable(
                                    onTap: () async {
                                      final code = await countryPicker.showPicker(context: context);
                                      setState((){
                                        mobileMoneyCountryCode = code!;
                                      });
                                      print(mobileMoneyCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          mobileMoneyCountryCode.flagImage,
                                          Container(
                                            child: Text(mobileMoneyCountryCode.dialCode ),
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
                                hintText: 'Enter Registered Phone Number',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: mobileMoneyPhoneValidator,
                            ),
                          ) : Container(),
                          //
                          // SizedBox(
                          //   height: 3.h,
                          // ),


                          mobile == 'B' ? Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: accNameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Account Name',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: accNameValidator,
                            ),
                          ) : Container(),

                          mobile == 'B' ? SizedBox(
                            height: 3.h,
                          ) : Container(),


                          mobile == 'B' ? Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: accNumberCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Account Number',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: accNumberValidator,
                            ),
                          ) : Container(),

                          mobile == 'B' ? SizedBox(
                            height: 3.h,
                          ) : Container(),

                          mobile == 'B' ? Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp)
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: bankNameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Bank Name',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: bankNameValidator,
                            ),
                          ) : Container(),

                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Next of Kin National ID', style: AppTheme.sectionMediumTitle,),
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
                              }  if(selectedPaymentValue==null){
                                setState((){
                                  networkError = 'Network required';
                                });
                                // Fluttertoast.showToast(msg: 'Pick district');
                              } if(isChecked == false){
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
                                    Get.off(() => DeliveryPhoneLogin());
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
