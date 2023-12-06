import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wena_partners/vendor/account/models/cityModel.dart';
import 'package:wena_partners/vendor/account/models/profile_model.dart';
import 'package:wena_partners/vendor/account/models/vendor_model.dart';
import 'package:wena_partners/vendor/account/repository/city_repository.dart';
import 'package:wena_partners/vendor/account/repository/profile_repository.dart';
import 'package:wena_partners/vendor/account/repository/profile_update_repository.dart';
import 'package:wena_partners/vendor/account/repository/vendors_list_repository.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/common_input_widget.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/file_upload_widget.dart';
import 'package:wena_partners/vendor/widget/image_upload_widget.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileScreen> {
  final TextEditingController _controllerMobile = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerAccountName = TextEditingController();
  final TextEditingController _controllerNamAccountNumber = TextEditingController();
  final TextEditingController _controllerBankName = TextEditingController();
  final TextEditingController _controllerBankCode = TextEditingController();
  final TextEditingController _controllerBranchName = TextEditingController();

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

  String _errBusinessName = "";
  String _errFirstName = "";
  String _errSurname = "";
  String _errEmail = "";
  String _errPassowrd = "";
  String _errAccountName = "";
  String _errAccountNumber = "";
  String _errBankName = "";
  String _errBankCode = "";
  String _errBranchName = "";
  String _errMobileNo = "";
  String _errDistrict = "";
  String _errVendor = "";

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
  final UpdateProfileRepository _updateProfileRepository = UpdateProfileRepository();

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
      getUserDetails();
    });
    // TODO: implement initState

    if (mounted) {
      setState(() {});
    }
    super.initState();
  }

  String _userId = "";
  String _userToken = "";
  String _profilePic = "";
  String _email = "";
  String _userName = "";
  getUserDetails() async {
    _userId = await LocalStorage.getUserId();
    _userToken = await LocalStorage.getToken();
    _profilePic = await LocalStorage.getUserProfilePic();
    _email = await LocalStorage.getUserEmail();
    _userName = await LocalStorage.getUserName();
    getProfile();
  }

  final ProfileRepository _profileRepository = ProfileRepository();
  ProfileModel _profileModel = ProfileModel();
  getProfile() {
    _profileRepository.getProfile(
        data: {
          "vendor_id": _userId,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
            if (_profileRepository.profileResp.status == Status.LOADING) {
              showLoadingDialog();
            } else if (_profileRepository.profileResp.status ==
                Status.COMPLETED) {
              hideLoadingDialog();
            }
          }
        }).then((value) {
      if (value["body"] != "") {
        if (value["body"]["status"] == 200) {
          _profileModel = ProfileModel.fromJson(value["body"]["data"]);
          _controllerMobile.text = _profileModel.varMobileNo!;
          _controllerFirstName.text = _profileModel.varName!;
          _controllerSurname.text = _profileModel.varSurname!;
          _controllerEmail.text = _profileModel.varEmail!;
          _controllerAccountName.text = _profileModel.varAccountName!;
          _controllerNamAccountNumber.text = _profileModel.varBankAccount!;
          _controllerBankName.text = _profileModel.varBankName!;
          _controllerBankCode.text = _profileModel.varBankCode!;
          _controllerBranchName.text = _profileModel.varBankBranchName!;
          for (var element in cities) {
            if (element.intGlCode == _profileModel.intCity) {
              selectedCity = element;
              setState(() {});
            }
          }
        }
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
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
                            margin:
                                EdgeInsets.only(left: dimen20, right: dimen20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: dimen20,
                                  ),
                                  Container(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          _profilePic == ""
                                              ? Image.asset(
                                                  "assets/images/placeholder.png",
                                                  width: dimen60,
                                                  height: dimen60,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          300.0),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        'assets/images/placeholder.png',
                                                    imageErrorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/placeholder.png',
                                                    ),
                                                    image: _profilePic,
                                                    fit: BoxFit.fitWidth,
                                                    width: dimen60,
                                                    height: dimen60,
                                                  )),
                                          SizedBox(
                                            width: dimen20,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                _userName,
                                                style:
                                                    textSegoeUiColor161616Size20,
                                              ),
                                              SizedBox(
                                                height: dimen05,
                                              ),
                                              Text(
                                                _email,
                                                style:
                                                    textSegoeUiColorContentSize16,
                                              )
                                            ],
                                          )),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: dimen40,
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
                                                focusNode: _focusNodeFirstName,
                                                nextFocusNode:
                                                    _focusNodeSurname,
                                              ),
                                              if (_errFirstName != "")
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: dimen10),
                                                  child: Text(
                                                    _errFirstName,
                                                    style:
                                                        textSegoeUiColorRedSize16,
                                                  ),
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
                                                focusNode: _focusNodeSurname,
                                                nextFocusNode: _focusNodeEmail,
                                              ),
                                              if (_errSurname != "")
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: dimen10),
                                                  child: Text(
                                                    _errSurname,
                                                    style:
                                                        textSegoeUiColorRedSize16,
                                                  ),
                                                ),
                                            ]),
                                      )
                                    ]),
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
                                  ),
                                  if (_errEmail != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errEmail,
                                        style: textSegoeUiColorRedSize16,
                                      ),
                                    ),
                                  SizedBox(
                                    height: dimen20,
                                  ),
                                  MobileInputWidget(
                                    controller: _controllerMobile,
                                    isEnabled: false,
                                    onCountryCodeChange: (code) {
                                      countryCode = code;
                                    },
                                    contentPadding:
                                        const EdgeInsets.only(left: 5),
                                  ),
                                  if (_errMobileNo != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errMobileNo,
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
                                      (image) {
                                        profileImage = image;
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      },
                                      image: profileImage,
                                      onlineUrl: _profileModel.varImage != null
                                          ? _profileModel.varImage!
                                          : "",
                                    )),
                                    Expanded(child: Container())
                                  ])),
                                  if (_errProfileImage != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
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
                                            color: const Color(colorDADADA)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(dimen10))),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          dimen50,
                                      child: Stack(
                                        alignment: FractionalOffset.center,
                                        children: [
                                          Container(
                                              alignment:
                                                  FractionalOffset.bottomLeft,
                                              child: Text(
                                                  selectedCity.intGlCode != null
                                                      ? selectedCity.title!
                                                      : "District",
                                                  style: selectedCity
                                                              .intGlCode !=
                                                          null
                                                      ? textSegoeUiColorBlackSize16
                                                      : textSegoeUiColorContentSize16)),
                                          Container(
                                              alignment:
                                                  FractionalOffset.centerRight,
                                              child: DropdownButton<CityModel>(
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
                                                    child: Text(value.title!),
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
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errDistrict,
                                        style: textSegoeUiColorRedSize16,
                                      ),
                                    ),
                                  if (_errVendor != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errVendor,
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
                                        (image) {
                                          idFrontImage = image;
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        file: idFrontImage,
                                        onlineUrl: _profileModel
                                                    .varNationalIdFront !=
                                                null
                                            ? _profileModel.varNationalIdFront!
                                            : "",
                                      ),
                                      if (_errIdFrontImage != "")
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: dimen10),
                                          child: Text(
                                            _errIdFrontImage,
                                            style: textSegoeUiColorRedSize16,
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
                                        (image) {
                                          idBackImage = image;
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        },
                                        file: idBackImage,
                                        onlineUrl: _profileModel
                                                    .varNationalIdBack !=
                                                null
                                            ? _profileModel.varNationalIdBack!
                                            : "",
                                      ),
                                      if (_errIdBackImage != "")
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: dimen10),
                                          child: Text(
                                            _errIdBackImage,
                                            style: textSegoeUiColorRedSize16,
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
                                  ),
                                  if (_errAccountName != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errAccountName,
                                        style: textSegoeUiColorRedSize16,
                                      ),
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
                                  ),
                                  if (_errAccountNumber != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errAccountNumber,
                                        style: textSegoeUiColorRedSize16,
                                      ),
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
                                  ),
                                  if (_errBankName != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errBankName,
                                        style: textSegoeUiColorRedSize16,
                                      ),
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
                                  ),
                                  if (_errBankCode != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errBankCode,
                                        style: textSegoeUiColorRedSize16,
                                      ),
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
                                  ),
                                  if (_errBranchName != "")
                                    Padding(
                                      padding: EdgeInsets.only(top: dimen10),
                                      child: Text(
                                        _errBranchName,
                                        style: textSegoeUiColorRedSize16,
                                      ),
                                    ),
                                  SizedBox(
                                    height: dimen20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _errBusinessName = "";
                                        _errFirstName = "";
                                        _errSurname = "";
                                        _errEmail = "";
                                        _errPassowrd = "";
                                        _errAccountName = "";
                                        _errAccountNumber = "";
                                        _errBankName = "";
                                        _errBankCode = "";
                                        _errBranchName = "";
                                        _errMobileNo = "";
                                        _errDistrict = "";
                                        _errVendor = "";

                                        _errProfileImage = "";
                                        _errIdFrontImage = "";
                                        _errIdBackImage = "";
                                        if (mounted) {
                                          setState(() {});
                                        }
                                        if (_controllerMobile.text == "" ||
                                            _controllerFirstName.text == "" ||
                                            _controllerSurname.text == "" ||
                                            _controllerEmail.text == "" ||
                                            _controllerAccountName.text == "" ||
                                            _controllerNamAccountNumber.text ==
                                                "" ||
                                            _controllerBankName.text == "" ||
                                            _controllerBankCode.text == "" ||
                                            _controllerBranchName.text == "" ||
                                            selectedCity.intGlCode == null ||
                                            !_controllerEmail.text
                                                .isValidEmail()) {
                                          if (_controllerFirstName.text == "") {
                                            _errFirstName =
                                                "First name is required";
                                          }
                                          if (_controllerSurname.text == "") {
                                            _errSurname = "Surname is required";
                                          }
                                          if (_controllerEmail.text == "") {
                                            _errEmail = "Email is required";
                                          }
                                          if (_controllerEmail.text != "" &&
                                              !_controllerEmail.text
                                                  .isValidEmail()) {
                                            _errEmail = "Email is not valid";
                                          }

                                          if (_controllerMobile.text == "") {
                                            _errMobileNo =
                                                "Phone number is required";
                                          }
                                          if (_controllerAccountName.text ==
                                              "") {
                                            _errAccountName =
                                                "Account name is required";
                                          }
                                          if (_controllerNamAccountNumber
                                                  .text ==
                                              "") {
                                            _errAccountNumber =
                                                "Account number is required";
                                          }
                                          if (_controllerBankName.text == "") {
                                            _errBankName =
                                                "Bank name is required";
                                          }
                                          if (_controllerBankCode.text == "") {
                                            _errBankCode =
                                                "Bank code is required";
                                          }
                                          if (_controllerBranchName.text ==
                                              "") {
                                            _errBranchName =
                                                "Account name is required";
                                          }

                                          if (selectedCity.intGlCode == null) {
                                            _errDistrict =
                                                "District is required";
                                          }

                                          if (mounted) {
                                            setState(() {});
                                          }
                                        } else {
                                          if (_updateProfileRepository
                                                  .accountResp.status !=
                                              Status.LOADING) {
                                            signUp();
                                          }
                                        }
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(top: dimen30),
                                          height: dimen50,
                                          child:
                                              CustomButtonColorSecondaryWidget(
                                                  "Save",
                                                  _updateProfileRepository
                                                          .accountResp.status ==
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

    data['var_vendor_id'] = _userId;
    data['var_name'] = _controllerFirstName.text;
    data['var_surname'] = _controllerSurname.text;

    data['var_email'] = _controllerEmail.text;

    // data['var_country_code'] = widget.countryCode;
    data['isVendorOrBranch'] = "0";
    data['var_mobile_no'] = _controllerMobile.text;
    data['int_city'] = selectedCity.intGlCode;
    data['fk_vendor'] = "0";

    data['var_bank_account'] = _controllerNamAccountNumber.text;
    data['var_account_name'] = _controllerAccountName.text;
    data['var_bank_name'] = _controllerBankName.text;

    data['var_bank_code'] = _controllerBankCode.text;
    data['var_bank_branch_name'] = _controllerBranchName.text;
    data['var_device_token'] = deviceToken;
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

    _updateProfileRepository
        .updateProfile(
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
          showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext dcontext) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Container(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            value["body"]["message"],
                            style: textSegoeUiColorContentSize14,
                          )),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Container(
                      alignment: FractionalOffset.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(dcontext);
                            Navigator.pop(context);
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: dimen20),
                              color: Colors.transparent,
                              child: Text(
                                'Okay',
                                style: textSegoeUiColorContentSize14,
                              )))),
                ],
              );
            },
          );
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
