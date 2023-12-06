import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wena_partners/vendor/account/repository/login_repository.dart';
import 'package:wena_partners/vendor/account/screens/otp_screen.dart';
import 'package:wena_partners/vendor/account/screens/sign_up_screen.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';
import 'package:wena_partners/vendor/utils/status.dart';
import 'package:wena_partners/vendor/widget/custome_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController _controllerMobile = TextEditingController();
  String _countryCode = "+256";
  LoginRepository authRepository = LoginRepository();
  String _mobileError = "";

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
        body: GestureDetector(
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
                            SizedBox(height: AppBar().preferredSize.height),
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
                            MobileInputWidget(
                              controller: _controllerMobile,
                              isEnabled: true,
                              isError: _mobileError != "" ? true : false,
                              onCountryCodeChange: (String code) {
                                _countryCode = code;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              contentPadding: const EdgeInsets.only(left: 5),
                            ),
                            SizedBox(
                              height: dimen20,
                            ),
                            if (_mobileError != "")
                              Container(
                                child: Text(
                                  _mobileError,
                                  style: textSegoeUiColorRedSize16,
                                ),
                              ),
                            SizedBox(
                              height: dimen40,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (!mobileNumberValidator(
                                      _controllerMobile.text)) {
                                    if (_controllerMobile.text == "") {
                                      _mobileError = "Phone number is required";
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    } else if (!mobileNumberValidator(
                                        _controllerMobile.text)) {
                                      _mobileError =
                                          "Phone number is not valid";
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    }
                                  } else {
                                    authRepository.accountResp.message = null;
                                    setState(() {});
                                    if (authRepository.accountResp.status !=
                                        Status.LOADING) {
                                      authRepository.login(
                                          data: {
                                            "var_country_code": _countryCode,
                                            "var_mobile_no":
                                                _controllerMobile.text,
                                            "var_device_token": deviceToken
                                          },
                                          stateChange: () {
                                            _mobileError = "";
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }).then((value) {
                                        if (value["body"]["status"] == 200) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OTPScreen(
                                                    mobileNumber:
                                                        _controllerMobile.text,
                                                    vendorId: value["body"]
                                                        ["data"]["int_glcode"]),
                                              ));
                                        } else if (value["body"]["message"]
                                            .toString()
                                            .toLowerCase()
                                            .contains("Invalid Mobile No."
                                                .toLowerCase())) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SignupScreen(
                                                  mobileNo:
                                                      _controllerMobile.text,
                                                  countryCode: _countryCode,
                                                ),
                                              ));
                                        }
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: dimen30),
                                    height: dimen50,
                                    child: CustomButtonColorSecondaryWidget(
                                        "Continue",
                                        authRepository.accountResp.status ==
                                            Status.LOADING)))
                          ]),
                    )))));
  }
}
