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
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/home/delivery_bottom_navbar.dart';
import 'package:wena_partners/vendor/account/screens/vendor_initial_screen.dart';
import 'package:wena_partners/vendor/contollers/auth/register_vendor_controller.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';
import 'package:wena_partners/vendor/screens/auth/privacy_policy_screen.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_phone_login.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';
import 'package:http/http.dart' as http;

class VendorSignUpScreen extends StatefulWidget {
  const VendorSignUpScreen({Key? key}) : super(key: key);

  @override
  State<VendorSignUpScreen> createState() => _VendorSignUpScreenState();
}

class _VendorSignUpScreenState extends State<VendorSignUpScreen> {

  final RegisterVendorController registerVendorController = Get.put(
      RegisterVendorController());

  final TextEditingController businessNameCont = TextEditingController();
  final TextEditingController firstnameCont = TextEditingController();
  final TextEditingController surnameCont = TextEditingController();
  final TextEditingController phoneCont = TextEditingController();
  final TextEditingController sharePinCont = TextEditingController();
  final TextEditingController kinFirstnameCont = TextEditingController();
  final TextEditingController kinSurnameCont = TextEditingController();
  final TextEditingController kinPhoneCont = TextEditingController();
  final TextEditingController emailCont = TextEditingController();

  final TextEditingController passwordCont = TextEditingController();
  final TextEditingController accNameCont = TextEditingController();
  final TextEditingController accNumberCont = TextEditingController();
  final TextEditingController bankNameCont = TextEditingController();
  final TextEditingController branchNameCont = TextEditingController();
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
    'Kampala',
    'Wakiso',
    'Mukono',
    'Masaka',
    'Mbarara',
    'Fort Portal',
    'Hoima',
    'Gulu',
    'Mbale',
    'Jinja'
  ];
  final List<String> networks = [
    'Airtel', 'MTN',
  ];

  String myAddress = "";
  String myAddressError = "";
  double myLatitude = 0.0;
  double myLongitude = 0.0;

  late String selectedVendorValue;
  String? selectedValue;
  String? selectedPaymentValue;
  String districtError = '';
  String networkError = '';
  bool isChecked = false;

  bool showPass = true;
  bool showConfirmPass = true;

  final countryPicker = const FlCountryCodePicker();
  late CountryCode vendorCountryCode;
  late CountryCode mobileMoneyCountryCode;
  late CountryCode kinCountryCode;

  String password = '';

  String vehicleError = '';
  String profileError = '';
  String vendorFrontError = '';
  String vendorBackError = '';
  String kinFrontError = '';
  String kinBackError = '';
  String tradingLicenseError = '';

  File? vehicleImage;
  File? profileImage;
  File? vendorFrontImage;
  File? vendorBackImage;
  File? kinFrontImage;
  File? kinBackImage;
  File? tradingLicenseImage;

  bool isCancelBtnTapped = true;
  bool isConfirmBtnTapped = false;

  String mobile = "M";

  pickVendorFrontImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        vendorFrontImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickVendorTradingLicenseImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        tradingLicenseImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickVendorBackImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        vendorBackImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickKinFrontImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        kinFrontImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickKinBackImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        kinBackImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        profileImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickVehicleImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        vehicleImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }


  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(5, errorText: 'Password must be at least 5 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
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

  final businessNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Business Name required'),
    MinLengthValidator(2, errorText: 'Business Name too short'),
    MaxLengthValidator(15, errorText: 'Business Name too long'),
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
    RequiredValidator(errorText: 'Mobile Money phone is required'),
    MinLengthValidator(9, errorText: 'Mobile Money phone number is short'),
    MaxLengthValidator(9, errorText: 'Mobile Money phone number has exceeded'),
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


  final branchNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Branch name required'),
    MinLengthValidator(4, errorText: 'Branch name too short'),
    MaxLengthValidator(15, errorText: 'Branch name too long'),
  ]);

  late PickResult pickResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickResult = PickResult();
    vendorCountryCode =
        CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    mobileMoneyCountryCode =
        CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    kinCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    selectedVendorValue = 'Main';
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
          padding: EdgeInsets.only(left: 5.w, right: 5.w),
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
                SizedBox(height: 1.h,),

                Expanded(
                  child: FadeInUp(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Padding(
                          //   padding:  EdgeInsets.only( top: 1.h),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Padding(
                          //         padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          //         child: Container(
                          //           width: 42.5.w,
                          //           child: RadioListTile(
                          //             activeColor: AppTheme.primaryColor,
                          //             value: 'Main',
                          //             groupValue: selectedVendorValue.toString(),
                          //             onChanged: (value){
                          //               setState((){
                          //                 selectedVendorValue = value as String;
                          //               });
                          //             },
                          //             title:  Text('Main',  style: AppTheme.subtitleSmall),
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(15.sp),
                          //                 side: BorderSide(
                          //                     width: 1,
                          //                     color: Colors.grey.shade300
                          //                 )
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          //         child: Container(
                          //           width: 42.5.w,
                          //           child: RadioListTile(
                          //             activeColor: AppTheme.primaryColor,
                          //             value: 'Branch',
                          //             groupValue: selectedVendorValue.toString(),
                          //             onChanged: (value){
                          //               setState((){
                          //                 selectedVendorValue = value as String;
                          //               });
                          //             },
                          //             title:  Text('Branch', style: AppTheme.subtitleSmall,),
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(15.sp),
                          //                 side: BorderSide(
                          //                     width: 1,
                          //                     color: Colors.grey.shade300
                          //                 )
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),


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
                              keyboardType: TextInputType.name,
                              controller: businessNameCont,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Business Name',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: businessNameValidator,
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
                                      final code = await countryPicker
                                          .showPicker(context: context);
                                      setState(() {
                                        vendorCountryCode = code!;
                                      });
                                      print(vendorCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          vendorCountryCode.flagImage,
                                          Container(
                                            child: Text(
                                                vendorCountryCode.dialCode),
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_down_outlined),
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

                          Container(
                            clipBehavior: Clip.antiAlias,
                            width: 90.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: AppTheme.borderColor2,
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                const kInitialPosition = LatLng(
                                    0.314436, 32.5783273);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (contex) {
                                      return PlacePicker(
                                        apiKey: 'AIzaSyAm9ovhdzPZUV_mRBjp01slypJYHz-s1Xw',
                                        onPlacePicked: (result) async {
                                          setState(() {
                                            pickResult = result;
                                            myAddress =
                                            result.formattedAddress!;
                                            sharePinCont.text = myAddress;
                                          });
                                          GeoData data = await Geocoder2
                                              .getDataFromAddress(
                                              address: myAddress,
                                              googleMapApiKey: "AIzaSyAm9ovhdzPZUV_mRBjp01slypJYHz-s1Xw");
                                          setState(() {
                                            myLatitude = data.latitude;
                                            myLongitude = data.longitude;
                                          });
                                          print(pickResult);
                                          print(pickResult.formattedAddress);
                                          print(myAddress);
                                          print(myLatitude);
                                          print(myLongitude);

                                          Navigator.of(context).pop();
                                        },
                                        initialPosition: myAddress.isEmpty
                                            ? kInitialPosition
                                            : LatLng(myLatitude, myLongitude),
                                        useCurrentLocation: true,
                                        hintText: 'Type location',
                                        resizeToAvoidBottomInset: false, // only works in page mode, less flickery, remove if wrong offset
                                      );
                                    },
                                    ));
                              },

                              keyboardType: TextInputType.none,
                              controller: sharePinCont,
                              validator: addressValidator,
                              showCursor: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.black,
                                hintText: myAddress.isEmpty
                                    ? 'Enter Store Location'
                                    : myAddress.toString(),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintStyle: const TextStyle(
                                  color: Colors.white,),
                                hintMaxLines: 1,
                              ),
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.transparent,
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
                            height: 2.h,
                          ),
                          Text('Upload Store Image and License' ,
                            style: AppTheme.sectionMediumTitle,),
                          SizedBox(
                            height: 1.h,
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FadeInLeft(
                                child: GestureDetector(
                                  onTap: () {
                                    pickProfileImage();
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15.sp),
                                      child: SizedBox(
                                          height: 20.h,
                                          width: 43.w,
                                          child: profileImage != null ?
                                          Image.file(
                                            File(profileImage!.path.toString()),
                                            fit: BoxFit.cover,) :
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.borderColor2,
                                              borderRadius: BorderRadius
                                                  .circular(15.sp),
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.1),
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
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 15, bottom: 8),
                                                    child: SvgPicture.asset(
                                                      "assets/images/upload.svg",
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Upload Store Pic",
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
                              profileError == '' ? Container() : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 0.5.h),
                                child: Text(profileError, style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red.shade800,

                                ),),
                              ),


                              SizedBox(height: 2.h,),

                              FadeInLeft(
                                child: GestureDetector(
                                  onTap: () {
                                    pickVendorTradingLicenseImage();
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.sp),
                                      child: SizedBox(
                                          height: 20.h,
                                          width: 43.w,
                                          child: tradingLicenseImage != null ?
                                          Image.file(File(
                                              tradingLicenseImage!.path.toString()),
                                            fit: BoxFit.cover,) :
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.borderColor2,
                                              borderRadius: BorderRadius.circular(
                                                  15.sp),
                                              border: Border.all(
                                                  color: Colors.grey, width: 0.1),
                                            ),
                                            height: 20.h,
                                            width: 43.w,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    pickVendorTradingLicenseImage();
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
                                                  "Upload Trading License",
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
                              tradingLicenseError == '' ? Container() : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 0.5.h),
                                child: Text(tradingLicenseError, style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red.shade800,

                                ),),
                              ),


                            ],
                          ),

                          SizedBox(
                            height: 3.h,
                          ),


                          // Container(
                          //   height: 5.5.h,
                          //   width: 90.w,
                          //   decoration: BoxDecoration(
                          //     color: AppTheme.borderColor2,
                          //     borderRadius: BorderRadius.circular(15.sp),
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButton2(
                          //       // buttonPadding: EdgeInsets.only(left: 0.0.w),
                          //       alignment: Alignment.center,
                          //       buttonPadding: EdgeInsets.only(right: 3.w),
                          //       dropdownPadding: EdgeInsets.only(left: 2.w),
                          //       hint: Text(
                          //         selectedValue ?? 'District',
                          //         textAlign: TextAlign.center,
                          //         style: TextStyle(
                          //             fontSize: 17.5.sp,
                          //             color: Colors.black54
                          //         ),
                          //       ),
                          //       items: districts
                          //           .map((item) =>
                          //           DropdownMenuItem<String>(
                          //             value: item,
                          //             child: Text(
                          //               item.toString(),
                          //               style:  TextStyle(
                          //                 fontSize: 20.sp,
                          //                 color: Colors.black,
                          //               ),
                          //             ),
                          //           ))
                          //           .toList(),
                          //       value: selectedValue,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           selectedValue = value as String;
                          //         });
                          //       },
                          //       buttonHeight: 40,
                          //       buttonWidth: 140,
                          //       itemHeight: 40,
                          //     ),
                          //   ),
                          // ),
                          //
                          // districtError=='' ?  Container() : Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                          //   child: Text(districtError, style: TextStyle(
                          //     fontSize: 14.sp,
                          //     color: Colors.red.shade800,
                          //
                          //   ),),
                          // ),
                          //
                          // SizedBox(
                          //   height: 3.h,
                          // ),
                          //

                          // Container(
                          //   clipBehavior: Clip.antiAlias,
                          //   width: 90.w,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(15.sp)
                          //   ),
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.text,
                          //     controller: sharePinCont,
                          //     decoration: InputDecoration(
                          //       border: InputBorder.none,
                          //       filled: true,
                          //       fillColor: AppTheme.borderColor2,
                          //       hintText: 'Shareable pin',
                          //       enabledBorder: InputBorder.none,
                          //       focusedBorder: InputBorder.none,
                          //       focusedErrorBorder: InputBorder.none,
                          //       errorBorder: InputBorder.none,
                          //     ),
                          //   ),
                          // ),
                          //



                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Vendor\'s National ID',
                            style: AppTheme.sectionMediumTitle,),
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
                                      onTap: () {
                                        pickVendorFrontImage();
                                      },
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              15.sp),
                                          child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: vendorFrontImage != null ?
                                              Image.file(File(
                                                  vendorFrontImage!.path
                                                      .toString()),
                                                fit: BoxFit.cover,) :
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppTheme.borderColor2,
                                                  borderRadius: BorderRadius
                                                      .circular(15.sp),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.1),
                                                ),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickVendorFrontImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload front side",
                                                      style: AppTheme
                                                          .subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  vendorFrontError == ''
                                      ? Container()
                                      : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(
                                      vendorFrontError, style: TextStyle(
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
                                      onTap: () {
                                        pickVendorBackImage();
                                      },
                                      child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                15.sp),
                                            child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: vendorBackImage != null ?
                                              Image.file(File(
                                                  vendorBackImage!.path
                                                      .toString()),
                                                fit: BoxFit.cover,) :
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppTheme
                                                        .borderColor2,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.1)),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickVendorBackImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload back side",
                                                      style: AppTheme
                                                          .subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          )),

                                    ),
                                  ),
                                  vendorBackError == '' ? Container() : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(
                                      vendorBackError, style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red.shade800,

                                    ),),
                                  ),

                                ],
                              ),
                            ],
                          ),


                          // selectedVendorValue == 'Main' ? Container() : SizedBox(
                          //   height: 2.h,
                          // ),
                          // selectedVendorValue == 'Main' ? Container() : Text('Branch', style: AppTheme.sectionMediumTitle,),
                          // selectedVendorValue == 'Main' ? Container() : SizedBox(
                          //   height: 1.h,
                          // ),
                          //
                          // selectedVendorValue == 'Main' ? Container() : Container(
                          //   clipBehavior: Clip.antiAlias,
                          //   width: 90.w,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(15.sp)
                          //   ),
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.emailAddress,
                          //     controller: branchNameCont,
                          //     decoration: InputDecoration(
                          //       border: InputBorder.none,
                          //       filled: true,
                          //       fillColor: AppTheme.borderColor2,
                          //       hintText: 'Branch Name',
                          //       enabledBorder: InputBorder.none,
                          //       focusedBorder: InputBorder.none,
                          //       focusedErrorBorder: InputBorder.none,
                          //       errorBorder: InputBorder.none,
                          //     ),
                          //     validator: branchNameValidator,
                          //   ),
                          // ),


                          SizedBox(
                            height: 2.h,
                          ),
                          Text('Choose Payment Method',
                            style: AppTheme.sectionMediumTitle,),
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
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
                                          style: mobile == 'B' ? AppTheme
                                              .subtitleSmall : AppTheme
                                              .sectionMediumBoldTitle,
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
                                          style: mobile == 'M' ? AppTheme
                                              .subtitleSmall : AppTheme
                                              .sectionMediumBoldTitle,
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
                          mobile == 'M' ? Text('Choose Network',
                            style: AppTheme.sectionMediumTitle,)
                              : Text('Bank Details',
                            style: AppTheme.sectionMediumTitle,),
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
                                  padding: EdgeInsets.only(left: 3.w),
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
                                        style: TextStyle(
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

                          mobile == 'M' ? networkError == ''
                              ? Container()
                              : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 0.5.h),
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
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.phone,
                              controller: mobileMoneyPhoneCont,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 2.w),
                                  child: Bounceable(
                                    onTap: () async {
                                      final code = await countryPicker
                                          .showPicker(context: context);
                                      setState(() {
                                        mobileMoneyCountryCode = code!;
                                      });
                                      print(mobileMoneyCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          mobileMoneyCountryCode.flagImage,
                                          Container(
                                            child: Text(mobileMoneyCountryCode
                                                .dialCode),
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Enter Mobile Money Phone Number',
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
                          Text('Next of Kin',
                            style: AppTheme.sectionMediumTitle,),
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
                                      final code = await countryPicker
                                          .showPicker(context: context);
                                      setState(() {
                                        kinCountryCode = code!;
                                      });
                                      print(kinCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          kinCountryCode.flagImage,
                                          Container(
                                            child: Text(
                                                kinCountryCode.dialCode),
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppTheme.borderColor2,
                                hintText: 'Enter Phone Number',
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
                          Text('Next of Kin National ID',
                            style: AppTheme.sectionMediumTitle,),
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
                                      onTap: () {
                                        pickKinFrontImage();
                                      },
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              15.sp),
                                          child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: kinFrontImage != null ?
                                              Image.file(File(
                                                  kinFrontImage!.path
                                                      .toString()),
                                                fit: BoxFit.cover,) :
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppTheme.borderColor2,
                                                  borderRadius: BorderRadius
                                                      .circular(15.sp),
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 0.1),
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
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload front side",
                                                      style: AppTheme
                                                          .subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                  kinFrontError == '' ? Container() : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 0.5.h),
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
                                      onTap: () {
                                        pickKinBackImage();
                                      },
                                      child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                15.sp),
                                            child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: kinBackImage != null ?
                                              Image.file(File(kinBackImage!.path
                                                  .toString()),
                                                fit: BoxFit.cover,) :
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: AppTheme
                                                        .borderColor2,
                                                    borderRadius: BorderRadius
                                                        .circular(12),
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.1)),
                                                height: 20.h,
                                                width: 43.w,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        pickKinBackImage();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: 15, bottom: 8),
                                                        child: SvgPicture.asset(
                                                          "assets/images/upload.svg",
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Upload back side",
                                                      style: AppTheme
                                                          .subtitleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          )),

                                    ),
                                  ),
                                  kinBackError == '' ? Container() : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 0.5.h),
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
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => PrivacyPolicyScreen());
                                },
                                child: Text('Privacy policy & Terms of Service',
                                  style: AppTheme.subtitleSmall,),

                              ),
                            ],
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

                          Obx(() {
                            return AppButton(
                              isLoading: registerVendorController.isLoading
                                  .value,
                              title: 'Agree and Register',
                              color: AppTheme.primaryColor,
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print('okay');
                                }
                                if (isChecked == false) {
                                  Fluttertoast.showToast(
                                    msg: 'Allow policy',
                                    textColor: Colors.red,
                                  );
                                } else {
                                  print(vendorCountryCode.dialCode);
                                  print(phoneCont.text.trim());
                                  print(vendorCountryCode.dialCode +
                                      phoneCont.text.trim());

                                  final pickedAvatorFileBytes = await profileImage!
                                      .readAsBytes();
                                  final pickedVendorFrontFileBytes = await vendorFrontImage!
                                      .readAsBytes();
                                  final pickedVendorBackFileBytes = await vendorBackImage!
                                      .readAsBytes();
                                  final pickedKinFrontFileBytes = await kinFrontImage!
                                      .readAsBytes();
                                  final pickedKinBackFileBytes = await kinBackImage!
                                      .readAsBytes();
                                  final pickedTradingLicenseFileBytes = await tradingLicenseImage!
                                      .readAsBytes();

                                  var myAvator = http.MultipartFile.fromBytes(
                                      'avator', pickedAvatorFileBytes,
                                      filename: profileImage!
                                          .path
                                          .split('/')
                                          .last);

                                  var vFront = http.MultipartFile.fromBytes(
                                      'national_id_front',
                                      pickedVendorFrontFileBytes,
                                      filename: profileImage!
                                          .path
                                          .split('/')
                                          .last);

                                  var vBack = http.MultipartFile.fromBytes(
                                      'national_id_back',
                                      pickedVendorBackFileBytes,
                                      filename: profileImage!
                                          .path
                                          .split('/')
                                          .last);

                                  var kFront = http.MultipartFile.fromBytes(
                                      'next_of_kin_national_id_front',
                                      pickedKinFrontFileBytes,
                                      filename: profileImage!
                                          .path
                                          .split('/')
                                          .last);

                                  var kBack = http.MultipartFile.fromBytes(
                                      'next_of_kin_national_id_back',
                                      pickedAvatorFileBytes,
                                      filename: profileImage!
                                          .path
                                          .split('/')
                                          .last);

                                  var tLPic = http.MultipartFile.fromBytes(
                                      'trading_license',
                                      pickedTradingLicenseFileBytes,
                                      filename: profileImage!
                                          .path
                                          .split('/')
                                          .last);

                                  // final pickedFileBytes = await _image
                                  //     .readAsBytes();
                                  // var pic = http.MultipartFile.fromBytes(
                                  //     'post_img', pickedFileBytes,
                                  //     filename: _image.path
                                  //         .split('/')
                                  //         .last);

                                  await registerVendorController
                                      .createNewVendor(
                                    emailCont.text.trim().toString(),
                                    myAvator,
                                    businessNameCont.text.trim(),
                                    vFront,
                                    vBack,
                                    tLPic,
                                    vendorCountryCode.dialCode +
                                        phoneCont.text.trim(),
                                    myAddress.toString(),
                                    firstnameCont.text.trim().toString(),
                                    surnameCont.text.trim().toString(),
                                    accNameCont.text.trim().toString(),
                                    accNumberCont.text.trim(),
                                    selectedPaymentValue.toString(),
                                    mobileMoneyCountryCode.dialCode +
                                        phoneCont.text.trim(),
                                    mobileMoneyPhoneCont.text.trim().toString(),
                                    selectedPaymentValue.toString(),
                                    kinFirstnameCont.text.trim().toString(),
                                    kinSurnameCont.text.trim().toString(),
                                    kinCountryCode.dialCode +
                                        phoneCont.text.trim(),
                                    kFront,
                                    kBack,
                                  );

                                  Get.back();

                                }


                                // if(_formKey.currentState!.validate()){
                                //   _formKey.currentState!.save();
                                //   print('okay');
                                // }  if(selectedValue==null){
                                //   setState((){
                                //     districtError = 'District required';
                                //   });
                                //   // Fluttertoast.showToast(msg: 'Pick district');
                                // } if(selectedPaymentValue==null){
                                //   setState((){
                                //     networkError = 'Network required';
                                //   });
                                //   // Fluttertoast.showToast(msg: 'Pick district');
                                // }  if(isChecked == false){
                                //   Fluttertoast.showToast(
                                //     msg: 'Allow policy',
                                //     textColor: Colors.red,
                                //   );
                                // } else {
                                //   print(vendorCountryCode.dialCode);
                                //   print(phoneCont.text.trim());
                                //   print(vendorCountryCode.dialCode +phoneCont.text.trim());
                                //   Get.snackbar('Registered', 'Account Created Successfully');
                                //   // Get.off(() => DeliveryPhoneLogin());
                                //   Get.offAll(() => DashboardScreen());
                                //
                                // }

                              },
                            );
                          }),

                          SizedBox(
                            height: 2.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Already have an account?',
                                style: AppTheme.subtitleSmall,),

                              TextButton(
                                  onPressed: () {
                                    Get.off(() => VendorPhoneLogin());
                                  },
                                  child: Text(
                                    'Log in', style: AppTheme.greenNormal,)),

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