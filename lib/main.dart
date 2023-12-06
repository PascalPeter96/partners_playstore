import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/home/delivery_bottom_navbar.dart';
import 'package:wena_partners/initial/initial_screen.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';
import 'package:wena_partners/services/preferences/app_prefs.dart';
import 'package:wena_partners/vendor/dashboard/screens/dashboard_screen.dart';

const String SERVER_ADDRESS = "http://utcit.in/wena/";

const String SERVER_IMAGE = "https://utcit.in/wena/uploads/professional/profile/";

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;


void main() async {

  await WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp],);
  await SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
  );

  runApp(
    DevicePreview(
      enabled: false,
      // enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

// final userStorage = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return GetMaterialApp(

            title: 'Wena Partners',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            // home: DashboardScreen(),
            home: userStorage.read('isVendorLoggedIn') == null ? InitialScreeen() : DashboardScreen() ,
            // home:  DashboardScreen(),
            // home: const BottomBar(),
            // home:  DeliveryBottomNavBar(),
          );
        }
    );
  }
}
