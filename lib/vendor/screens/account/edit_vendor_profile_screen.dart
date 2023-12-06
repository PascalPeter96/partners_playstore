import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/account/screens/vendor_initial_screen.dart';
import 'package:wena_partners/vendor/contollers/account/vendor_profile_controller.dart';
import 'package:wena_partners/vendor/contollers/auth/register_vendor_controller.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';
import 'package:wena_partners/vendor/screens/auth/privacy_policy_screen.dart';
import 'package:wena_partners/vendor/screens/auth/vendor_phone_login.dart';
import 'package:wena_partners/widgets/app_buttons.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';
import 'package:http/http.dart' as http;

class EditVendorScreen extends StatefulWidget {
  final String businessImage;
  final String businessName;
  final String businessPhone;
  final String frontId;
  final String backId;
  const EditVendorScreen({Key? key, required this.businessImage, required this.businessName, required this.businessPhone, required this.frontId, required this.backId}) : super(key: key);

  @override
  State<EditVendorScreen> createState() => _EditVendorScreenState();
}

class _EditVendorScreenState extends State<EditVendorScreen> {

  final EditVendorController editVendorController = Get.put(EditVendorController());

  late TextEditingController businessNameCont ;
  final TextEditingController firstnameCont = TextEditingController();
  final TextEditingController surnameCont = TextEditingController();
  late TextEditingController phoneCont ;
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
    'Kampala', 'Wakiso', 'Mukono', 'Masaka', 'Mbarara', 'Fort Portal', 'Hoima', 'Gulu', 'Mbale', 'Jinja'
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
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        vendorFrontImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickVendorTradingLicenseImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        tradingLicenseImage = tempImage;
      });
    } on PlatformException {
      print('Failed to Pick Image');
    }
  }

  pickVendorBackImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final tempImage = File(image.path);
      setState((){
        vendorBackImage = tempImage;
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
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
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
    vendorCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    mobileMoneyCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    kinCountryCode = CountryCode(name: 'Uganda', code: 'UG', dialCode: '+256');
    selectedVendorValue = 'Main';

    businessNameCont = TextEditingController(text: widget.businessName);
    phoneCont = TextEditingController(text: widget.businessPhone.substring(4));
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
                  "Edit",
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

                          Center(child: Text('Store Image', style: AppTheme.sectionMediumTitle,)),
                          SizedBox(height: 1.h,),
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
                                        child: CachedNetworkImage(
                                            imageUrl: userStorage.read('vendorAvatar'),
                                          fit: BoxFit.cover,
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
                                      final code = await countryPicker.showPicker(context: context);
                                      setState((){
                                        vendorCountryCode = code!;
                                      });
                                      print(vendorCountryCode);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          vendorCountryCode.flagImage,
                                          Container(
                                            child: Text(vendorCountryCode.dialCode ),
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
                          Text('Vendor\'s National ID', style: AppTheme.sectionMediumTitle,),
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
                                        pickVendorFrontImage();
                                      },
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.sp),
                                          child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: vendorFrontImage != null?
                                              Image.file(File(vendorFrontImage!.path.toString()),fit: BoxFit.cover,):
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
                                                        pickVendorFrontImage();
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
                                  vendorFrontError=='' ?  Container() : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(vendorFrontError, style: TextStyle(
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
                                        pickVendorBackImage();
                                      },
                                      child: Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15.sp),
                                            child: SizedBox(
                                              height: 20.h,
                                              width: 43.w,
                                              child: vendorBackImage != null?
                                              Image.file(File(vendorBackImage!.path.toString()),fit: BoxFit.cover,):
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
                                                        pickVendorBackImage();
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
                                  vendorBackError=='' ?  Container() : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                                    child: Text(vendorBackError, style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red.shade800,

                                    ),),
                                  ),

                                ],
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

                          // FadeInLeft(
                          //   child: GestureDetector(
                          //     onTap: (){
                          //       pickVendorTradingLicenseImage();
                          //     },
                          //     child: Center(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(15.sp),
                          //         child: SizedBox(
                          //             height: 20.h,
                          //             width: 43.w,
                          //             child: tradingLicenseImage != null?
                          //             Image.file(File(tradingLicenseImage!.path.toString()),fit: BoxFit.cover,):
                          //             Container(
                          //               decoration: BoxDecoration(
                          //                 color: AppTheme.borderColor2,
                          //                 borderRadius: BorderRadius.circular(15.sp),
                          //                 border: Border.all(color: Colors.grey, width: 0.1),
                          //               ),
                          //               height: 20.h,
                          //               width: 43.w,
                          //               child: Column(
                          //                 children: [
                          //                   GestureDetector(
                          //                     onTap: () {
                          //                       pickVendorTradingLicenseImage();
                          //                     },
                          //                     child: Container(
                          //                       padding: const EdgeInsets.only(
                          //                           top: 15, bottom: 8),
                          //                       child: SvgPicture.asset(
                          //                         "assets/images/upload.svg",
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Text(
                          //                     "Upload License Pic",
                          //                     style: AppTheme.subtitleSmall,
                          //                   ),
                          //                 ],
                          //               ),
                          //             )
                          //         ),
                          //       ),
                          //     ),
                          //
                          //   ),
                          // ),
                          // tradingLicenseError=='' ?  Container() : Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                          //   child: Text(tradingLicenseError, style: TextStyle(
                          //     fontSize: 14.sp,
                          //     color: Colors.red.shade800,
                          //
                          //   ),),
                          // ),

                          SizedBox(
                            height: 3.h,
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

                          AppButton(
                            title: 'Update',
                            color: AppTheme.primaryColor,
                            function: () async{

                              final pickedVendorFrontFileBytes =  await vendorFrontImage!.readAsBytes();
                              final pickedVendorBackFileBytes =  await vendorBackImage!.readAsBytes();
                              final pickedKinFrontFileBytes =  await kinFrontImage!.readAsBytes();
                              final pickedKinBackFileBytes =  await kinBackImage!.readAsBytes();
                              final pickedTradingLicenseFileBytes =  await tradingLicenseImage!.readAsBytes();


                              var vFront = http.MultipartFile.fromBytes(
                                  'national_id_front', pickedVendorFrontFileBytes,
                                  filename: profileImage!.path
                                      .split('/')
                                      .last);

                              var vBack = http.MultipartFile.fromBytes(
                                  'national_id_back', pickedVendorBackFileBytes,
                                  filename: profileImage!.path
                                      .split('/')
                                      .last);


                              var tLPic = http.MultipartFile.fromBytes(
                                  'trading_license', pickedTradingLicenseFileBytes,
                                  filename: profileImage!.path
                                      .split('/')
                                      .last);

                              // final pickedFileBytes = await _image
                              //     .readAsBytes();
                              // var pic = http.MultipartFile.fromBytes(
                              //     'post_img', pickedFileBytes,
                              //     filename: _image.path
                              //         .split('/')
                              //         .last);
                              
                              
                              await editVendorController.updateVendor(
                                businessNameCont.text.trim(),
                                vFront,
                                vBack,
                                  tLPic,
                                vendorCountryCode.dialCode +
                                    phoneCont.text.trim(),
                              );


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
                          ),

                          SizedBox(
                            height: 2.h,
                          ),

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