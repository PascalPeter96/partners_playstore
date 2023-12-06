import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/account/models/cityModel.dart';
import 'package:wena_partners/vendor/account/repository/city_repository.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/branches/models/branch_model.dart';
import 'package:wena_partners/vendor/branches/repository/add_branch_repository.dart';
import 'package:wena_partners/vendor/branches/repository/getbranchdetail_repository.dart';
import 'package:wena_partners/vendor/branches/repository/update_branch_repository.dart';
import 'package:wena_partners/vendor/branches/screens/branches_screnn.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/background_widget_wb.dart';
import 'package:wena_partners/vendor/widget/common_input_widget.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';
import 'package:wena_partners/vendor/widget/file_upload_widget.dart';
import 'package:wena_partners/vendor/widget/loading_dialog.dart';

class AddBranchesScreen extends StatefulWidget {
  bool forEdit;
  String branchId;
  BranchModel branchModel;
  AddBranchesScreen(
      {this.forEdit = false, this.branchId = "", required this.branchModel});

  @override
  _AddBrachesState createState() => _AddBrachesState();
}

class _AddBrachesState extends State<AddBranchesScreen> {
  final TextEditingController _controllerMobile = TextEditingController();

  final TextEditingController _controllerBusinessName = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final TextEditingController _controllerNumberStoreName = TextEditingController();
  final TextEditingController _controllerLandmark = TextEditingController();
  final TextEditingController _controllerState = TextEditingController();
  final TextEditingController _controllerCountry = TextEditingController();
  final TextEditingController _controllerPostcode = TextEditingController();
  final TextEditingController _controllerStoreName = TextEditingController();

  final FocusNode _focusNodeBusinessName = FocusNode();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeSurname = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassowrd = FocusNode();

  final FocusNode _focusNodeStoreNumber = FocusNode();
  final FocusNode _focusNodeLandmark = FocusNode();
  final FocusNode _focusNodeState = FocusNode();
  final FocusNode _focusNodeCountry = FocusNode();
  final FocusNode _focusNodePostcode = FocusNode();
  final FocusNode _focusNodeStoreName = FocusNode();

  String _errMobileNo = "";
  String _errDistrict = "";
  var idFrontImage;
  var idBackImage;
  String _errIdFrontImage = "";
  String _errIdBackImage = "";

  List<CityModel> cities = [];
  CityModel selectedCity = CityModel();
  String _userId = "";
  BranchModel branchesModel = BranchModel(addressModel: []);
  final BranchDetailRepository _branchDetailRepository = BranchDetailRepository();
  @override
  void initState() {
    // TODO: implement initState

    CityListRepository().getCity(stateChange: () {
      if (mounted) {
        setState(() {});
      }
    }).then((value) {
      cities = value["body"]['data']
          .map<CityModel>((json) => CityModel.fromJson(json))
          .toList();

      if (widget.forEdit) {
        for (var element in cities) {
          if (element.intGlCode == widget.branchModel.addressModel[0].cityId) {
            selectedCity = element;
            if (mounted) {
              setState(() {});
            }
          }
        }
        getEditDetails();
      }
    });

    getUserId();
    super.initState();
  }

  getEditDetails() {
    _branchDetailRepository.getBranchDetails(
        data: {"branch_id": widget.branchId},
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
          if (_branchDetailRepository.branchResp.status == Status.LOADING) {
            showLoadingDialog();
          } else if (_branchDetailRepository.branchResp.status ==
              Status.COMPLETED) {
            hideLoadingDialog();
          }
        }).then((value) {
      branchesModel = BranchModel.fromJson(value["body"]["data"][0]);

      _controllerMobile.text = branchesModel.varMobileNo!;

      _controllerFirstName.text = widget.branchModel.varName!;
      _controllerSurname.text = widget.branchModel.varSurname!;
      _controllerEmail.text = branchesModel.varEmail!;
      _controllerNumberStoreName.text = _controllerLandmark.text =
          widget.branchModel.addressModel[0].varAddress!;
      widget.branchModel.addressModel[0].varLandmark!;
      _controllerState.text = widget.branchModel.addressModel[0].varState!;
      _controllerCountry.text = widget.branchModel.addressModel[0].varCountry!;
      _controllerPostcode.text = widget.branchModel.addressModel[0].varPincode!;
    });
  }

  final String _countryCode = "+256";
  getUserId() async {
    _userId = await LocalStorage.getUserId();
  }

  final GlobalKey<FormState> _formAbKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BackgroundWithBackMaterialWidget(
        Expanded(
            child: Stack(children: [
          Form(
              key: _formAbKey,
              child: SingleChildScrollView(
                  child: Container(
                      alignment: FractionalOffset.centerLeft,
                      margin: EdgeInsets.only(bottom: dimen40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                          nextFocusNode: _focusNodeSurname,
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
                                          focusNode: _focusNodeSurname,
                                          nextFocusNode: _focusNodeEmail,
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
                              isEnabled: widget.forEdit ? false : true,
                              isValidator: true,
                              validatorString: "Store name is required",
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
                            if (!widget.forEdit)
                              SizedBox(
                                height: dimen20,
                              ),
                            if (!widget.forEdit)
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
                              isError: _errMobileNo != "" ? true : false,
                              isEnabled: widget.forEdit ? false : true,
                              countryCode: _countryCode,
                            ),
                            if (_errMobileNo != "")
                              Padding(
                                padding: EdgeInsets.only(
                                    top: dimen10, left: dimen20),
                                child: Text(
                                  _errMobileNo,
                                  style: textSegoeUiColorRedSize16,
                                ),
                              ),
                            Row(children: [
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(top: dimen30),
                                      height: dimen50,
                                      child: const CustomButtonColorSecondaryWidget(
                                          "Get Location", false))),
                              Expanded(
                                child: Container(),
                              )
                            ]),
                            SizedBox(
                              height: dimen30,
                            ),
                            CommonInputWidget(
                              _controllerNumberStoreName,
                              hint: "Store Number or Building Name",
                              isSecure: false,
                              inputType: TextInputType.text,
                              focusNode: _focusNodeStoreNumber,
                              nextFocusNode: _focusNodeLandmark,
                              isValidator: true,
                              validatorString: "Store number is required",
                            ),
                            SizedBox(
                              height: dimen20,
                            ),
                            CommonInputWidget(
                              _controllerLandmark,
                              hint: "Landmark",
                              isSecure: false,
                              inputType: TextInputType.text,
                              focusNode: _focusNodeLandmark,
                              nextFocusNode: _focusNodeState,
                              isValidator: true,
                              validatorString: "Landmark is required",
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
                                width:
                                    MediaQuery.of(context).size.width - dimen50,
                                child: Stack(
                                  alignment: FractionalOffset.center,
                                  children: [
                                    Container(
                                        alignment: FractionalOffset.bottomLeft,
                                        child: Text(
                                            selectedCity.intGlCode != null
                                                ? selectedCity.title!
                                                : "District",
                                            style: selectedCity.intGlCode !=
                                                    null
                                                ? textSegoeUiColorBlackSize16
                                                : textSegoeUiColorContentSize16)),
                                    Container(
                                        alignment: FractionalOffset.centerRight,
                                        child: DropdownButton<CityModel>(
                                          isExpanded: true,
                                          underline: Container(),
                                          icon: Image.asset(
                                            "assets/icons/arrow_down.png",
                                            width: dimen16,
                                            height: dimen16,
                                          ),
                                          items: cities.map((CityModel value) {
                                            return DropdownMenuItem<CityModel>(
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
                            // SizedBox(
                            //   height: dimen20,
                            // ),
                            // CommonInputWidget(
                            //   _controllerState,
                            //   hint: "State ",
                            //   isSecure: false,
                            //   inputType: TextInputType.text,
                            //   focusNode: _focusNodeState,
                            //   nextFocusNode: _focusNodeCountry,
                            //   isValidator: true,
                            //   validatorString: "State is required",
                            // ),
                            SizedBox(
                              height: dimen20,
                            ),
                            CommonInputWidget(
                              _controllerCountry,
                              hint: "town / trading",
                              isSecure: false,
                              inputType: TextInputType.text,
                              focusNode: _focusNodeCountry,
                              nextFocusNode: _focusNodePostcode,
                              isValidator: true,
                              validatorString: "Tow / trading is required",
                            ),
                            SizedBox(
                              height: dimen20,
                            ),
                            CommonInputWidget(
                              _controllerPostcode,
                              hint: "Postcode",
                              isSecure: false,
                              inputType: TextInputType.number,
                              actionType: TextInputAction.done,
                              focusNode: _focusNodePostcode,
                              nextFocusNode: _focusNodePostcode,
                              isValidator: true,
                              validatorString: "Postcode is required",
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
                                Container(
                                    child: FileUploadWidget(
                                  "Upload front side",
                                  isError:
                                      _errIdFrontImage != "" ? true : false,
                                  (image) {
                                    idFrontImage = image;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  file: idFrontImage,
                                  onlineUrl:
                                      branchesModel.nationalIdFrontUrl != null
                                          ? branchesModel.nationalIdFrontUrl!
                                          : "",
                                )),
                                if (_errIdFrontImage != "")
                                  Padding(
                                    padding: EdgeInsets.only(top: dimen10),
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
                                  isError: _errIdBackImage != "" ? true : false,
                                  (image) {
                                    idBackImage = image;
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  file: idBackImage,
                                  onlineUrl:
                                      branchesModel.nationalIdBackUrl != null
                                          ? branchesModel.nationalIdBackUrl!
                                          : "",
                                ),
                                if (_errIdBackImage != "")
                                  Padding(
                                    padding: EdgeInsets.only(top: dimen10),
                                    child: Text(
                                      _errIdBackImage,
                                      style: textSegoeUiColorRedSize16,
                                    ),
                                  ),
                              ])),
                            ])),
                            GestureDetector(
                                onTap: () {
                                  _errMobileNo = "";
                                  _errDistrict = "";
                                  _errIdFrontImage = "";
                                  _errIdBackImage = "";
                                  _formAbKey.currentState!.save();
                                  if (mounted) {
                                    setState(() {});
                                  }

                                  if (widget.forEdit) {
                                    if (!_formAbKey.currentState!.validate() ||
                                        !mobileNumberValidator(
                                            _controllerMobile.text) ||
                                        selectedCity.intGlCode == null) {
                                      if (selectedCity.intGlCode == null) {
                                        _errDistrict = "Disctrict is required";
                                      }
                                      if (_controllerMobile.text == "") {
                                        _errMobileNo =
                                            "Mobile number is required";
                                      }
                                      if (!mobileNumberValidator(
                                          _controllerMobile.text)) {
                                        _errMobileNo =
                                            "Mobile number is invalid";
                                      }
                                    } else {
                                      updateBranch();
                                    }
                                  } else {
                                    if (!_formAbKey.currentState!.validate() ||
                                        selectedCity.intGlCode == null ||
                                        _controllerCountry.text == "" ||
                                        !mobileNumberValidator(
                                            _controllerMobile.text) ||
                                        _controllerPostcode.text == "" ||
                                        idFrontImage == null ||
                                        idBackImage == null) {
                                      if (_controllerMobile.text == "") {
                                        _errMobileNo =
                                            "Mobile number is required";
                                      }
                                      if (!mobileNumberValidator(
                                          _controllerMobile.text)) {
                                        _errMobileNo =
                                            "Mobile number is invalid";
                                      }
                                      if (selectedCity.intGlCode == null) {
                                        _errDistrict = "Disctrict is required";
                                      }

                                      if (idBackImage == null) {
                                        _errIdBackImage =
                                            "Back side Id is required";
                                      }
                                      if (idFrontImage == null) {
                                        _errIdFrontImage =
                                            "Front side Id is required";
                                      }
                                    } else {
                                      createBranch();
                                    }
                                  }
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: dimen30),
                                    height: dimen50,
                                    child: CustomButtonColorSecondaryWidget(
                                        !widget.forEdit
                                            ? "Add Branches"
                                            : "Save",
                                        (_addBranchRepository
                                                    .branchResp.status ==
                                                Status.LOADING ||
                                            _updateBranchRepository
                                                    .branchResp.status ==
                                                Status.LOADING))))
                          ])))),
        ])),
        !widget.forEdit ? "Add branches" : "Edit branch");
  }

  final AddBranchRepository _addBranchRepository = AddBranchRepository();
  final UpdateBranchRepository _updateBranchRepository = UpdateBranchRepository();

  createBranch() {
    var data = <String, dynamic>{};
    data['fk_vendor'] = _userId;
    data['var_name'] = _controllerFirstName.text;
    data['var_surname'] = _controllerSurname.text;

    data['var_email'] = _controllerEmail.text;
    data['var_password'] = _controllerPassword.text;
    data['var_country_code'] = _countryCode;
    data['var_mobile_no'] = _controllerMobile.text;
    data['var_city'] = selectedCity.intGlCode;
    data['var_address'] = _controllerNumberStoreName.text;
    data['var_landmark'] = _controllerLandmark.text;
    data['var_latitude'] = userLat.toString();
    data['var_longitude'] = userLon.toString();
    data['var_state'] = _controllerState.text;
    data['var_country'] = _controllerCountry.text;
    data['var_pincode'] = _controllerPostcode.text;

    final Map<String, File> files = {
      "var_national_id_front": idFrontImage,
      "var_national_id_back": idBackImage
    };

    _addBranchRepository
        .addBranch(
            data: data,
            files: files,
            stateChange: () {
              if (mounted) {
                setState(() {});
              }
            })
        .then((value) {
      if (value["body"]["status"] == 200) {
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BranchesScreen()));
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
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value["body"]["message"])));
      }
    });
  }

  updateBranch() {
    var data = <String, dynamic>{};
    data['fk_vendor'] = _userId;
    data['branch_id'] = widget.branchId;
    data['var_name'] = _controllerFirstName.text;
    data['var_surname'] = _controllerSurname.text;

    data['var_email'] = _controllerEmail.text;

    data['var_country_code'] = _countryCode;
    data['var_mobile_no'] = _controllerMobile.text;
    data['var_city'] = selectedCity.intGlCode;
    data['var_address'] = _controllerNumberStoreName.text;
    data['var_landmark'] = _controllerLandmark.text;
    data['var_latitude'] = userLat.toString();
    data['var_longitude'] = userLon.toString();
    data['var_state'] = _controllerState.text;
    data['var_country'] = _controllerCountry.text;
    data['var_pincode'] = _controllerPostcode.text;
    if (idFrontImage == null) {
      data['var_national_id_front_already'] = branchesModel.varNationalIdFront;
    } else {
      data['var_national_id_front_already'] = "";
    }
    if (idBackImage == null) {
      data['var_national_id_back_already'] = branchesModel.varNationalIdBack;
    } else {
      data['var_national_id_back_already'] = "";
    }
    final Map<String, File> files = {};
    if (idFrontImage != null) {
      {
        files["var_national_id_front"] = idFrontImage;
      }
    }
    if (idBackImage != null) {
      files["var_national_id_back"] = idBackImage;
    }

    _updateBranchRepository
        .updateBranch(
            data: data,
            files: files,
            stateChange: () {
              if (mounted) {
                setState(() {});
              }
            })
        .then((value) {
      if (value["body"]["status"] == 200) {
        showDialog<void>(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BranchesScreen()));
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
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value["body"]["message"])));
      }
    });
  }
}
