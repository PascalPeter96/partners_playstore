
import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/account/account_screen.dart';
import 'package:wena_partners/delivery/screens/home/delivery_homepage.dart';
import 'package:wena_partners/delivery/screens/jobs/delivery_jobs_screen.dart';
import 'package:wena_partners/delivery/screens/orders/delivery_orders_screen.dart';
import 'package:wena_partners/delivery/screens/profile/delivery_profile_screen.dart';

class DeliveryBottomNavBar extends StatefulWidget {
  const DeliveryBottomNavBar({Key? key}) : super(key: key);

  @override
  State<DeliveryBottomNavBar> createState() => _DeliveryBottomNavBarState();
}

class _DeliveryBottomNavBarState extends State<DeliveryBottomNavBar> {

  int currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavKey = GlobalKey();


// final CartController cartController = Get.find();

  final screens = const[
    DeliveryHomepage(),
    DeliveryJobsScreen(),
    DeliveryOrdersScreen(),
    DeliveryAccountScreen(),
    // DeliveryProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {

    final icons = <Widget>[
      Image.asset('assets/icons/home.png', color: currentIndex == 0 ? Colors.white : Colors.black, scale: 2.8),
      Image.asset('assets/icons/jobs2.png', color: currentIndex == 1 ? Colors.white : Colors.black, ),
      Image.asset('assets/icons/orders.png', color: currentIndex == 2 ? Colors.white : Colors.black, scale: 2.8),
      Image.asset('assets/icons/user.png', color: currentIndex == 3 ? Colors.white : Colors.black, scale: 2.8),

    ];

    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            // color: Colors.white30,
            backgroundColor: Colors.transparent,
            key: bottomNavKey,
            buttonBackgroundColor: AppTheme.primaryColor,
            items: icons,
            height: 7.h,
            index: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                print(currentIndex);
              });
            },
          ),
          body: screens[currentIndex],
        ),
      ),
    );
  }
}
