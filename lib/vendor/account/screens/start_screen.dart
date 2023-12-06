import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wena_partners/vendor/account/screens/login_screen.dart';
import 'package:wena_partners/vendor/account/widget/mobile_input_widget.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<StartScreen> {
  final TextEditingController _controllerMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
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
                        alignment: FractionalOffset.topCenter,
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                            alignment: FractionalOffset.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: dimen20, right: dimen20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height:
                                                AppBar().preferredSize.height +
                                                    dimen30),
                                        Image.asset(
                                          "assets/images/logo.png",
                                          width: dimen150,
                                          height: dimen40,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                  left: dimen50,
                                                  right: dimen50,
                                                ),
                                                child: Image.asset(
                                                  "assets/images/getstarted.png",
                                                )),
                                            Text(
                                              "Get Started",
                                              style:
                                                  textTahomaColor292D32Size30,
                                            ),
                                            SizedBox(
                                              height: dimen10,
                                            ),
                                            Text(
                                              "Proceed to sign up as a vendor",
                                              style:
                                                  textSegoeUiColorContentSize16,
                                            ),
                                            SizedBox(
                                              height: dimen50,
                                            ),
                                          ],
                                        )),
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: dimen30),
                                          alignment:
                                              FractionalOffset.bottomCenter,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                            child: MobileInputWidget(
                                              controller: _controllerMobile,
                                              isEnabled: false,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 5),
                                            ),
                                          ),
                                        )
                                      ]))
                            ]))))));
  }
}
