import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wena_partners/vendor/account/repository/confirmotp_repository.dart';
import 'package:wena_partners/vendor/account/repository/sendopt_repository.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  final String vendorId;

  const OTPScreen({required this.mobileNumber, required this.vendorId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final String _mobileError = "";
  final TextEditingController _controllerMobile = TextEditingController();
  final FocusNode _mobileNode = FocusNode();
  final bool _isLoading = false;
  final _form = GlobalKey<FormState>();

  late var _connetivity;
  late final bool _isConnected = true;
  final String _connectionError = "";
  final String _otpConfirmError = "";

  final _inputOneFocusNode = FocusNode();
  final _inputTowFocusNode = FocusNode();
  final _inputThreeFocusNode = FocusNode();
  final _inputFourFocusNode = FocusNode();

  String _otpOne = "";
  String _otpTwo = "";
  String _otpThree = "";
  String _otpFour = "";

  bool otpResent = false;
  int _position = 0;
  bool isEnabled = false;
  String error = "";

  final OtpSendRepository _otpSendRepository = OtpSendRepository();
  final ConfirmOtpRepository _otpConfirmRepository = ConfirmOtpRepository();
  @override
  void initState() {
    // TODO: implement initState
    sendOtp();
    super.initState();
  }

  sendOtp() async {
    _otpSendRepository.sendOtp(
        data: {
          "var_vendor_id": widget.vendorId,
          "var_mobile_no": widget.mobileNumber,
        },
        stateChange: () {
          if (mounted) {
            setState(() {});
          }
        }).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
        body: SafeArea(
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: dimen20, right: dimen20),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: dimen20),
                              GestureDetector(
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
                                      ))),
                              SizedBox(
                                height: dimen40,
                              ),
                              Text(
                                "OTP Verification",
                                textAlign: TextAlign.start,
                                style: textTahomaColor292D32Size30,
                              ),
                              SizedBox(
                                height: dimen10,
                              ),
                              Text(
                                "Get OTP from Customer and Complete you order.",
                                style: textSegoeUiColorContentSize16,
                              ),
                              Form(
                                  key: _form,
                                  child: Container(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                            top: dimen20,
                                          ),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (_connectionError != "")
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: dimen10,
                                                          bottom: dimen20,
                                                          top: dimen30),
                                                      alignment:
                                                          FractionalOffset
                                                              .center,
                                                      child: Text(
                                                        _connectionError,
                                                        style:
                                                            textSegoeUiColorRedSize16,
                                                      )),
                                                if (_otpConfirmError != "")
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: dimen05,
                                                          top: dimen30),
                                                      alignment:
                                                          FractionalOffset
                                                              .centerLeft,
                                                      child: Text(
                                                        _otpConfirmError,
                                                        style:
                                                            textSegoeUiColorRedSize16,
                                                      )),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: dimen30),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _otpOne !=
                                                                          ""
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          colorDADADA),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              dimen10)),
                                                                  border: Border.all(
                                                                      width: _otpOne !=
                                                                              ""
                                                                          ? 1.5
                                                                          : 0,
                                                                      color: _otpOne !=
                                                                              ""
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                margin: EdgeInsets.only(
                                                                    top:
                                                                        dimen10,
                                                                    right:
                                                                        dimen05,
                                                                    left:
                                                                        dimen05),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            dimen05),
                                                                height: dimen60,
                                                                child:
                                                                    TextFormField(
                                                                        cursorColor:
                                                                            Colors
                                                                                .black,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .number,
                                                                        onTap:
                                                                            () {
                                                                          whichEdititing(
                                                                              0);
                                                                        },
                                                                        focusNode:
                                                                            _inputOneFocusNode,
                                                                        onChanged:
                                                                            (value) {
                                                                          _otpOne = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                          if (mounted) {
                                                                            setState(() {});
                                                                          }
                                                                          focusNext(
                                                                              0,
                                                                              context,
                                                                              value);
                                                                        },
                                                                        onSaved:
                                                                            (value) {
                                                                          _otpOne = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                        },
                                                                        onEditingComplete:
                                                                            _inputOneFocusNode
                                                                                .nextFocus,
                                                                        textInputAction:
                                                                            TextInputAction
                                                                                .next,
                                                                        maxLength:
                                                                            1,
                                                                        inputFormatters: <
                                                                            TextInputFormatter>[
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        obscureText:
                                                                            false,
                                                                        decoration: const InputDecoration(
                                                                            counterText: "",
                                                                            border: InputBorder.none,
                                                                            hintText: "",
                                                                            hintStyle: TextStyle(
                                                                              color: Color(colorContent),
                                                                            )),
                                                                        style: textSegoeUiColor1E232CSize22))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                height: dimen60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _otpTwo !=
                                                                          ""
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          colorDADADA),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              dimen10)),
                                                                  border: Border.all(
                                                                      width: _otpTwo !=
                                                                              ""
                                                                          ? 1.5
                                                                          : 0,
                                                                      color: _otpTwo !=
                                                                              ""
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                margin: EdgeInsets.only(
                                                                    top:
                                                                        dimen10,
                                                                    left:
                                                                        dimen05,
                                                                    right:
                                                                        dimen05),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            dimen05),
                                                                child:
                                                                    TextFormField(
                                                                        cursorColor:
                                                                            Colors
                                                                                .black,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .number,
                                                                        onTap:
                                                                            () {
                                                                          whichEdititing(
                                                                              1);
                                                                        },
                                                                        onChanged:
                                                                            (value) {
                                                                          _otpTwo = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                          if (mounted) {
                                                                            setState(() {});
                                                                          }
                                                                          focusNext(
                                                                              1,
                                                                              context,
                                                                              value);
                                                                        },
                                                                        onSaved:
                                                                            (value) {
                                                                          _otpTwo = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction
                                                                                .next,
                                                                        focusNode:
                                                                            _inputTowFocusNode,
                                                                        maxLength:
                                                                            1,
                                                                        inputFormatters: <
                                                                            TextInputFormatter>[
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        obscureText:
                                                                            false,
                                                                        decoration: const InputDecoration(
                                                                            counterText: "",
                                                                            border: InputBorder.none,
                                                                            hintText: "",
                                                                            hintStyle: TextStyle(
                                                                              color: Color(colorContent),
                                                                            )),
                                                                        style: textSegoeUiColor1E232CSize22))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                height: dimen60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _otpThree !=
                                                                          ""
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          colorDADADA),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              dimen10)),
                                                                  border: Border.all(
                                                                      width: _otpThree !=
                                                                              ""
                                                                          ? 1.5
                                                                          : 0,
                                                                      color: _otpThree !=
                                                                              ""
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                margin: EdgeInsets.only(
                                                                    top:
                                                                        dimen10,
                                                                    left:
                                                                        dimen05,
                                                                    right:
                                                                        dimen05),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            dimen05),
                                                                child:
                                                                    TextFormField(
                                                                        cursorColor:
                                                                            Colors
                                                                                .black,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .number,
                                                                        onTap:
                                                                            () {
                                                                          whichEdititing(
                                                                              2);
                                                                        },
                                                                        onSaved:
                                                                            (value) {
                                                                          _otpThree = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                        },
                                                                        onChanged:
                                                                            (value) {
                                                                          _otpThree = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                          if (mounted) {
                                                                            setState(() {});
                                                                          }
                                                                          focusNext(
                                                                              2,
                                                                              context,
                                                                              value);
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction
                                                                                .next,
                                                                        maxLength:
                                                                            1,
                                                                        focusNode:
                                                                            _inputThreeFocusNode,
                                                                        inputFormatters: <
                                                                            TextInputFormatter>[
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        obscureText:
                                                                            false,
                                                                        decoration: const InputDecoration(
                                                                            counterText: "",
                                                                            border: InputBorder.none,
                                                                            hintText: "",
                                                                            hintStyle: TextStyle(
                                                                              color: Color(colorContent),
                                                                            )),
                                                                        style: textSegoeUiColor1E232CSize22))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                height: dimen60,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: _otpFour !=
                                                                          ""
                                                                      ? Colors
                                                                          .white
                                                                      : const Color(
                                                                          colorDADADA),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              dimen10)),
                                                                  border: Border.all(
                                                                      width: _otpFour !=
                                                                              ""
                                                                          ? 1.5
                                                                          : 0,
                                                                      color: _otpFour !=
                                                                              ""
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white),
                                                                ),
                                                                margin: EdgeInsets.only(
                                                                    top:
                                                                        dimen10,
                                                                    left:
                                                                        dimen05,
                                                                    right:
                                                                        dimen05),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            dimen05),
                                                                child:
                                                                    TextFormField(
                                                                        cursorColor:
                                                                            Colors
                                                                                .black,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .number,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        onTap:
                                                                            () {
                                                                          whichEdititing(
                                                                              3);
                                                                        },
                                                                        onChanged:
                                                                            (value) {
                                                                          _otpFour = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                          if (mounted) {
                                                                            setState(() {});
                                                                          }
                                                                          focusNext(
                                                                              3,
                                                                              context,
                                                                              value);
                                                                        },
                                                                        onSaved:
                                                                            (value) {
                                                                          _otpFour = value != null
                                                                              ? value.toString()
                                                                              : "";
                                                                        },
                                                                        textInputAction:
                                                                            TextInputAction
                                                                                .next,
                                                                        focusNode:
                                                                            _inputFourFocusNode,
                                                                        maxLength:
                                                                            1,
                                                                        inputFormatters: <
                                                                            TextInputFormatter>[
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly
                                                                        ],
                                                                        obscureText:
                                                                            false,
                                                                        decoration: const InputDecoration(
                                                                            counterText: "",
                                                                            border: InputBorder.none,
                                                                            hintText: "",
                                                                            hintStyle: TextStyle(
                                                                              color: Color(colorContent),
                                                                            )),
                                                                        style: textSegoeUiColor1E232CSize22))),
                                                      ]),
                                                ),
                                                SizedBox(
                                                  height: dimen20,
                                                ),
                                                if (_otpConfirmRepository
                                                        .accountResp.message !=
                                                    null)
                                                  Container(
                                                    child: Text(
                                                      _otpConfirmRepository
                                                          .accountResp.message!,
                                                      style:
                                                          textSegoeUiColorRedSize16,
                                                    ),
                                                  ),
                                                GestureDetector(
                                                    onTap: () {
                                                      if (_otpOne != "" &&
                                                          _otpTwo != "" &&
                                                          _otpThree != "" &&
                                                          _otpFour != "") {
                                                        _otpConfirmRepository
                                                            .confirmOtp(
                                                                data: {
                                                              "var_vendor_id":
                                                                  widget
                                                                      .vendorId,
                                                              "var_otp":
                                                                  _otpOne +
                                                                      _otpTwo +
                                                                      _otpThree +
                                                                      _otpFour,
                                                            },
                                                                stateChange:
                                                                    () {
                                                                  if (mounted) {
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                }).then((value) {
                                                          if (value["body"]
                                                                  ["status"] ==
                                                              200) {
                                                            LocalStorage.setUserId(
                                                                value["body"]
                                                                        ["data"]
                                                                    [
                                                                    "int_glcode"]);
                                                            LocalStorage.setToken(
                                                                value["body"]
                                                                        ["data"]
                                                                    [
                                                                    "var_auth_token"]);
                                                            LocalStorage.setUserName(
                                                                value["body"]
                                                                        ["data"]
                                                                    [
                                                                    "var_name"]);
                                                            LocalStorage.setUserEmail(
                                                                value["body"]
                                                                        ["data"]
                                                                    [
                                                                    "var_email"]);
                                                            LocalStorage.setUserProfilePic(
                                                                value["body"]
                                                                        ["data"]
                                                                    [
                                                                    "var_image"]);
                                                            Navigator.of(context).pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DashboardScreen()),
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: dimen30),
                                                        height: dimen50,
                                                        child: CustomButtonColorSecondaryWidget(
                                                            "Verify",
                                                            _otpConfirmRepository
                                                                    .accountResp
                                                                    .status ==
                                                                Status
                                                                    .LOADING)))
                                              ])))),
                            ]),
                      )),
                ))));
  }

  void focusNext(int position, BuildContext context, String value) {
    switch (position) {
      case 0:
        if (value.isNotEmpty) {
          FocusScope.of(context).requestFocus(_inputTowFocusNode);
        }
        break;
      case 1:
        if (value.isNotEmpty) {
          FocusScope.of(context).requestFocus(_inputThreeFocusNode);
        } else {
          FocusScope.of(context).requestFocus(_inputOneFocusNode);
        }
        break;
      case 2:
        if (value.isNotEmpty) {
          FocusScope.of(context).requestFocus(_inputFourFocusNode);
        } else {
          FocusScope.of(context).requestFocus(_inputTowFocusNode);
        }
        break;
      case 3:
        if (value.isEmpty) {
          FocusScope.of(context).requestFocus(_inputThreeFocusNode);
        }
        break;
    }
  }

  void whichEdititing(int position) {
    _position = position;
  }
}
