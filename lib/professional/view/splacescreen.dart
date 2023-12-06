// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wena_partners/professional/view/start_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async{

    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if(token==null){
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? firebaseToken = await firebaseMessaging.getToken();
      if(firebaseToken!=null){
        prefs.setString('token', firebaseToken);
        // print('store token successfully and token is ${prefs.getString('token')}');
        Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProStartScreen())));
      }else{
        // print('token is null');
        Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProStartScreen())));
      }
    }else{
      // print('token is $token');
      Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProStartScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Image.asset("assets/images/startscreen/wena.png")),
      ),
    );
  }
}
