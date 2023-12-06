import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wena_partners/vendor/account/screens/start_screen.dart';
import 'package:wena_partners/vendor/config/local_storage.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';

import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';
import 'package:wena_partners/vendor/utils/const.dart';


class ASplashScreen extends StatefulWidget {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));
  }

  @override
  _SplashStateScreen createState() => _SplashStateScreen();
}

class _SplashStateScreen extends State<ASplashScreen> {
  @override
  void initState() {
    InitTimer._().initialize().then((value) async {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();

      if (await LocalStorage.getToken() != "") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StartScreen(),
            ));
      }
    });
    // NotificationUtil.initializeNotification(
    //     (flutterLocalNotificationsPlugin, initializationSettings) {
    //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //       onSelectNotification: (payload) {
    //     String s = payload;
    //   });
    // });
    // getFCMId().then((value) => FCM_TOKEN = value);
  }

  @override
  Widget build(BuildContext context) {
    setFontSize(MediaQuery.of(context).size.height);
    return MaterialApp(
        title: app_name,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 0.0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
            ),
          ),
          // backgroundColor: colorDarkPurple,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: FractionalOffset.center,
                child: Container(
                  margin: EdgeInsets.only(left: dimen40, right: dimen40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: FractionalOffset.center,
                        margin: EdgeInsets.only(top: dimen20),
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: dimen130,
                          height: dimen30,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class InitTimer {
  InitTimer._();
  static final instance = InitTimer._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 6));
  }
}
