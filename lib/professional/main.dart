// ignore_for_file: constant_identifier_names, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/view/bootombar_screen.dart';
import 'package:wena_partners/professional/view/splacescreen.dart';



const String SERVER_ADDRESS = "http://utcit.in/wena/";

const String SERVER_IMAGE = "https://utcit.in/wena/uploads/professional/profile/";

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

class ProfessionalModule{

  Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('user_id');
    print(userId);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: userId == null ? const SplashScreen(): const BottomBar(),
        // home: BottomBar(),
      ),
    );
  }

}