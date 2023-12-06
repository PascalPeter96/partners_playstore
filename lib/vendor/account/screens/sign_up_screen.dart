import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wena_partners/vendor/account/models/cityModel.dart';
import 'package:wena_partners/vendor/account/models/vendor_model.dart';
import 'package:wena_partners/vendor/account/repository/city_repository.dart';
import 'package:wena_partners/vendor/account/repository/singup_repository.dart';
import 'package:wena_partners/vendor/account/repository/vendors_list_repository.dart';
import 'package:wena_partners/vendor/account/screens/otp_screen.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/common_input_widget.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/file_upload_widget.dart';
import 'package:wena_partners/vendor/widget/image_upload_widget.dart';

class SignupScreen extends StatefulWidget {
  String mobileNo;
  String countryCode;
  SignupScreen({required this.mobileNo, required this.countryCode});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  final TextEditingController _controllerMobile = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerBusinessName = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final TextEditingController _controllerAccountName = TextEditingController();
  final TextEditingController _controllerNamAccountNumber = TextEditingController();
  final TextEditingController _controllerBankName = TextEditingController();
  final TextEditingController _controllerBankCode = TextEditingController();
  final TextEditingController _controllerBranchName = TextEditingController();
  final TextEditingController _controllerStoreName = TextEditingController();

  final FocusNode _focusNodeBusinessName = FocusNode();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeSurname = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassowrd = FocusNode();

  final FocusNode _focusNodeAccountName = FocusNode();
  final FocusNode _focusNodeAccountNumber = FocusNode();
  final FocusNode _focusNodeBankName = FocusNode();
  final FocusNode _focusNodeBankCode = FocusNode();
  final FocusNode _focusNodeBranchName = FocusNode();
  final FocusNode _focusNodeStoreName = FocusNode();

  String _errDistrict = "";
  String _errMobile = "";

  String _errProfileImage = "";
  String _errIdFrontImage = "";
  String _errIdBackImage = "";

  var profileImage;
  var idFrontImage;
  var idBackImage;

  bool privacyPolicyChecked = false;
  String selectedUserType = "Branch";
  String countryCode = "";
  List<VendorModel> vendors = [];
  VendorModel selectedVendor = VendorModel();

  List<CityModel> cities = [];
  CityModel selectedCity = CityModel();
  SignupRepository signupRepository = SignupRepository();

  @override
  void initState() {
    VendorListRepository().getVendors(stateChange: () {
      if (mounted) {
        setState(() {});
      }
    }).then((value) {
      vendors = value["body"]['data']
          .map<VendorModel>((json) => VendorModel.fromJson(json))
          .toList();
    });

    CityListRepository().getCity(stateChange: () {
      if (mounted) {
        setState(() {});
      }
    }).then((value) {
      cities = value["body"]['data']
          .map<CityModel>((json) => CityModel.fromJson(json))
          .toList();
    });
    // TODO: implement initState
    _controllerMobile.text = widget.mobileNo;
    countryCode = widget.countryCode;

    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          toolbarHeight: 0.0,
          shadowColor: Colors.transparent,

        ),
        body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppBar().preferredSize.height),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: dimen20,
                                      right: dimen20,
                                      bottom: dimen10),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: dimen12,
                                              right: 5.0,
                                              bottom: dimen08,
                                              top: dimen08),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: const Color(colorE8ECF4)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(dimen10))),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.black,
                                            size: dimen24,
                                          )))),
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Container(
                                margin: EdgeInsets.only(
                                    left: dimen20, right: dimen20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: dimen30,
                                      ),
                                      Text(
                                        "Get Started",
                                        textAlign: TextAlign.start,
                                        style: textTahomaColor292D32Size30,
                                      ),
                                      SizedBox(
                                        height: dimen10,
                                      ),
                                      Text(
                                        "Please enter your mobile number to login or create an account",
                                        style: textSegoeUiColorContentSize16,
                                      ),
                                      SizedBox(
                                        height: dimen40,
                                      ),
                                      CommonInputWidget(
                                        _controllerBusinessName,
                                        hint: "Business Name",
                                        focusNode: _focusNodeBusinessName,
                                        nextFocusNode: _focusNodeFirstName,
                                        isValidator: true,
                                        validatorString:
                                            "Business Name is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Container(
                                        child: Row(children: [
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CommonInputWidget(
                                                    _controllerFirstName,
                                                    hint: "First Name",
                                                    focusNode:
                                                        _focusNodeFirstName,
                                                    nextFocusNode:
                                                        _focusNodeSurname,
                                                    isValidator: true,
                                                    validatorString:
                                                        "First name is required",
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            width: dimen10,
                                          ),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CommonInputWidget(
                                                    _controllerSurname,
                                                    hint: "Surname",
                                                    focusNode:
                                                        _focusNodeSurname,
                                                    nextFocusNode:
                                                        _focusNodeStoreName,
                                                    isValidator: true,
                                                    validatorString:
                                                        "Surname is required",
                                                  ),
                                                ]),
                                          )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerStoreName,
                                        hint: "Store Name",
                                        inputType: TextInputType.text,
                                        focusNode: _focusNodeStoreName,
                                        nextFocusNode: _focusNodeEmail,
                                        isValidator: true,
                                        validatorString:
                                            "Store name is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerEmail,
                                        hint: "Email",
                                        inputType: TextInputType.emailAddress,
                                        focusNode: _focusNodeEmail,
                                        nextFocusNode: _focusNodePassowrd,
                                        isValidator: true,
                                        validatorString: "Email is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerPassword,
                                        hint: "Password",
                                        isSecure: true,
                                        focusNode: _focusNodePassowrd,
                                        nextFocusNode: _focusNodePassowrd,
                                        isValidator: true,
                                        validatorString: "Password is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      MobileInputWidget(
                                        controller: _controllerMobile,
                                        isEnabled: true,
                                        isError:
                                            _errMobile == "" ? false : true,
                                        onCountryCodeChange: (code) {
                                          countryCode = code;
                                        },
                                        contentPadding:
                                            const EdgeInsets.only(left: 5),
                                      ),
                                      if (_errMobile != "")
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: dimen10, left: dimen20),
                                          child: Text(
                                            _errMobile,
                                            style: textSegoeUiColorRedSize16,
                                          ),
                                        ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Text(
                                        "Upload profile Image",
                                        style: textSegoeUiColor292D32Size16,
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Container(
                                          child: Row(children: [
                                        Expanded(
                                            child: ImageUploadWidget(
                                          "Upload Image",
                                          isError: _errProfileImage != ""
                                              ? true
                                              : false,
                                          (image) {
                                            profileImage = image;
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          },
                                          image: profileImage,
                                        )),
                                        Expanded(child: Container())
                                      ])),
                                      if (_errProfileImage != "")
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: dimen10, left: dimen20),
                                          child: Text(
                                            _errProfileImage,
                                            style: textSegoeUiColorRedSize16,
                                          ),
                                        ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Text(
                                        "Note :- please upload clear face image",
                                        style: textSegoeUiColorRedSize14,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: dimen20,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: dimen10,
                                            right: dimen10,
                                            bottom: dimen05,
                                            top: dimen05),
                                        decoration: BoxDecoration(
                                            color: const Color(colorF7F8F9),
                                            border: Border.all(
                                                width: 2.0,
                                                color: _errDistrict != ""
                                                    ? Colors.red
                                                    : const Color(colorDADADA)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(dimen10))),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              dimen50,
                                          child: Stack(
                                            alignment: FractionalOffset.center,
                                            children: [
                                              Container(
                                                  alignment: FractionalOffset
                                                      .bottomLeft,
                                                  child: Text(
                                                      selectedCity.intGlCode !=
                                                              null
                                                          ? selectedCity.title!
                                                          : "District",
                                                      style: selectedCity
                                                                  .intGlCode !=
                                                              null
                                                          ? textSegoeUiColorBlackSize16
                                                          : textSegoeUiColorContentSize16)),
                                              Container(
                                                  alignment: FractionalOffset
                                                      .centerRight,
                                                  child:
                                                      DropdownButton<CityModel>(
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    icon: Image.asset(
                                                      "assets/icons/arrow_down.png",
                                                      width: dimen16,
                                                      height: dimen16,
                                                    ),
                                                    items: cities
                                                        .map((CityModel value) {
                                                      return DropdownMenuItem<
                                                          CityModel>(
                                                        value: value,
                                                        child:
                                                            Text(value.title!),
                                                      );
                                                    }).toList(),
                                                    onChanged: (_) {
                                                      selectedCity = _!;
                                                      setState(() {});
                                                    },
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (_errDistrict != "")
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: dimen10, left: dimen20),
                                          child: Text(
                                            _errDistrict,
                                            style: textSegoeUiColorRedSize16,
                                          ),
                                        ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Text(
                                        "National ID file",
                                        style: textSegoeUiColor292D32Size16,
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Container(
                                          child: Row(children: [
                                        Expanded(
                                            child: Column(children: [
                                          FileUploadWidget(
                                            "Upload front side",
                                            isError: _errIdFrontImage != ""
                                                ? true
                                                : false,
                                            (image) {
                                              idFrontImage = image;
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                            file: idFrontImage,
                                          ),
                                          if (_errIdFrontImage != "")
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: dimen10),
                                              child: Text(
                                                _errIdFrontImage,
                                                style:
                                                    textSegoeUiColorRedSize16,
                                              ),
                                            ),
                                        ])),
                                        SizedBox(
                                          width: dimen10,
                                        ),
                                        Expanded(
                                            child: Column(children: [
                                          FileUploadWidget(
                                            "Upload back Side",
                                            isError: _errIdBackImage != ""
                                                ? true
                                                : false,
                                            (image) {
                                              idBackImage = image;
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                            file: idBackImage,
                                          ),
                                          if (_errIdBackImage != "")
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: dimen10),
                                              child: Text(
                                                _errIdBackImage,
                                                style:
                                                    textSegoeUiColorRedSize16,
                                              ),
                                            ),
                                        ])),
                                      ])),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Text(
                                        "Bank Details",
                                        style: textSegoeUiColor292D32Size16,
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerAccountName,
                                        hint: "Account Name",
                                        inputType: TextInputType.text,
                                        focusNode: _focusNodeAccountName,
                                        nextFocusNode: _focusNodeAccountNumber,
                                        isValidator: true,
                                        validatorString:
                                            "Account name is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerNamAccountNumber,
                                        hint: "Account Number",
                                        inputType: TextInputType.number,
                                        focusNode: _focusNodeAccountNumber,
                                        nextFocusNode: _focusNodeBankName,
                                        isValidator: true,
                                        validatorString:
                                            "Account number is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerBankName,
                                        hint: "Bank Name",
                                        inputType: TextInputType.text,
                                        focusNode: _focusNodeBankName,
                                        nextFocusNode: _focusNodeBankCode,
                                        validatorString:
                                            "Bank name is required",
                                        isValidator: true,
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerBankCode,
                                        hint: "Bank Code",
                                        inputType: TextInputType.text,
                                        focusNode: _focusNodeBankCode,
                                        nextFocusNode: _focusNodeBranchName,
                                        validatorString:
                                            "Bank code is required",
                                        isValidator: true,
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      CommonInputWidget(
                                        _controllerBranchName,
                                        hint: "Branch Name",
                                        inputType: TextInputType.text,
                                        focusNode: _focusNodeBranchName,
                                        nextFocusNode: _focusNodeBranchName,
                                        actionType: TextInputAction.done,
                                        isValidator: true,
                                        validatorString:
                                            "Branch name is required",
                                      ),
                                      SizedBox(
                                        height: dimen20,
                                      ),
                                      Container(
                                        child: Row(children: [
                                          Checkbox(
                                            value: privacyPolicyChecked,
                                            activeColor: const Color(colorSecondary),
                                            onChanged: (value) {
                                              privacyPolicyChecked = value!;
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          Expanded(
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    String url =
                                                        "https://www.google.in";
                                                    if (!await launchUrl(
                                                        Uri.parse(url))) {
                                                      throw 'Could not launch $url';
                                                    }
                                                  },
                                                  child: Text(
                                                    "Terms and conditions of Service",
                                                    style:
                                                        textSegoeUiColorContentSize16,
                                                  )))
                                        ]),
                                      ),
                                      if (!privacyPolicyChecked &&
                                          signupRepository
                                                  .accountResp.message !=
                                              null)
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: dimen10),
                                          child: Text(
                                            signupRepository
                                                .accountResp.message!,
                                            style: textSegoeUiColorRedSize16,
                                          ),
                                        ),
                                      GestureDetector(
                                          onTap: () {
                                            _formKey.currentState!.save();
                                            _errDistrict = "";

                                            _errProfileImage = "";
                                            _errIdFrontImage = "";
                                            _errIdBackImage = "";
                                            if (mounted) {
                                              setState(() {});
                                            }

                                            if (!_formKey.currentState!
                                                    .validate() ||
                                                selectedCity.intGlCode ==
                                                    null ||
                                                profileImage == null ||
                                                idFrontImage == null ||
                                                !mobileNumberValidator(
                                                    _controllerMobile.text) ||
                                                idBackImage == null) {
                                              if (_controllerMobile.text ==
                                                  "") {
                                                _errMobile =
                                                    "Mobile number is required";
                                              }
                                              if (!mobileNumberValidator(
                                                  _controllerMobile.text)) {
                                                _errMobile =
                                                    "Mobile number is invalid";
                                              }
                                              if (selectedCity.intGlCode ==
                                                  null) {
                                                _errDistrict =
                                                    "District is required";
                                              }
                                              if (profileImage == null) {
                                                _errProfileImage =
                                                    "Profile image is required";
                                              }
                                              if (idBackImage == null) {
                                                _errIdBackImage =
                                                    "Back side Id is required";
                                              }
                                              if (idFrontImage == null) {
                                                _errIdFrontImage =
                                                    "Front side Id is required";
                                              }
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            } else {
                                              if (privacyPolicyChecked) {
                                                if (signupRepository
                                                        .accountResp.status !=
                                                    Status.LOADING) {
                                                  signUp();
                                                }
                                              } else {
                                                signupRepository
                                                        .accountResp.message =
                                                    "Accept terms and conditions before sign up";
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(top: dimen30),
                                              height: dimen50,
                                              child:
                                                  CustomButtonColorSecondaryWidget(
                                                      "Sign Up",
                                                      signupRepository
                                                              .accountResp
                                                              .status ==
                                                          Status.LOADING))),
                                      SizedBox(
                                        height: dimen40,
                                      ),
                                    ]),
                              )))
                            ]))))));
  }

  signUp() {
    var data = <String, dynamic>{};
    data['var_business_name'] = _controllerBusinessName.text;
    data['var_name'] = _controllerFirstName.text;
    data['var_surname'] = _controllerSurname.text;

    data['var_email'] = _controllerEmail.text;
    data['var_password'] = _controllerPassword.text;
    data['var_country_code'] = widget.countryCode;
    data['isVendorOrBranch'] = "0";
    data['var_mobile_no'] = _controllerMobile.text;
    data['int_city'] = selectedCity.intGlCode;
    data['fk_vendor'] = "0";

    data['var_bank_account'] = _controllerNamAccountNumber.text;
    data['var_account_name'] = _controllerAccountName.text;
    data['var_bank_name'] = _controllerBankName.text;

    data['var_bank_code'] = _controllerBankCode.text;
    data['var_bank_branch_name'] = _controllerBranchName.text;
    data['var_device_token'] = FCM_TOKEN;
    final Map<String, XFile> files = {};
    final Map<String, File> idfiles = {};
    if (idFrontImage != null) {
      {
        idfiles["var_national_id_front"] = idFrontImage;
      }
    }
    if (idBackImage != null) {
      idfiles["var_national_id_back"] = idBackImage;
    }

    if (idBackImage != null) {
      idfiles["var_image"] = profileImage;
    }

    signupRepository
        .signup(
            data: data,
            fileData: files,
            files: idfiles,
            stateChange: () {
              if (mounted) {
                setState(() {});
              }
            })
        .then((value) {
      if (value["body"]["status"] == 200) {
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(
                      mobileNumber: _controllerMobile.text,
                      vendorId: value["body"]["data"]["int_glcode"])));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value["body"]["message"])));
        }
      }
    });
  }
}
