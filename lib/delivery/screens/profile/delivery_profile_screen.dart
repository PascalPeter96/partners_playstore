import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wena_partners/app_style/app_theme.dart';

class DeliveryProfileScreen extends StatefulWidget {
  const DeliveryProfileScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryProfileScreen> createState() => _DeliveryProfileScreenState();
}

class _DeliveryProfileScreenState extends State<DeliveryProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Profile', style: AppTheme.appTitle,),
        centerTitle: true,
      ),

    );
  }
}
