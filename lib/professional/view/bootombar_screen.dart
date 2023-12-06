
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'order_screen.dart';
import 'profile/account_screen.dart';
import 'home_screen.dart';

class BottomBar extends StatefulWidget {

  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> screens = [
    const HomeScreen(),
    const OrderScreen(),
    Container(),
    const AccountScreen(),
    // const AddProjectScreen(),
  ];


  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: screens[_page],
        // body: Navigator(
        //   onGenerateRoute: (settings) {
        //     Widget page = const HomeScreen();
        //     if (settings.name == 'page2') page = const AccountScreen();
        //     return MaterialPageRoute(builder: (_) => screens[_page]);
        //   },
        //   // onGenerateRoute: (settings) {
        //   //   Widget page = const HomeScreen();
        //   //   if (settings.name == 'page2') page = const AccountScreen();
        //   //   return MaterialPageRoute(builder: (_) => screens[_page]);
        //   // },
        // ),
        ///------------------old-----------

        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          key: _bottomNavigationKey,
          index: 0,
          buttonBackgroundColor: const Color(0xFF149C48),
          backgroundColor: Colors.transparent,
          items:   <Widget>[

            SvgPicture.asset(
              _page==0
                  ? "assets/images/Group 83.svg"
                  : "assets/images/Group 82.svg",height: 25,
            ),
            // SvgPicture.asset(
            //   _page==1
            //       ? "assets/images/User.svg"
            //       : "assets/images/User-1.svg",height: 25,
            // ),
            // SvgPicture.asset(
            //   _page==1
            //       ? "assets/images/Home-1.svg"
            //       : "assets/images/Home.svg",height: 25,
            // ),
            SvgPicture.asset(
              _page==1
                  ? "assets/images/Book-1.svg"
                  : "assets/images/Book.svg",height: 25,
            ),
            SvgPicture.asset(
                _page==2
                    ? "assets/images/Home-1.svg"
                    : "assets/images/Home.svg",height: 25,
            ),
            SvgPicture.asset(
              _page==3
                  ? "assets/images/User.svg"
                    : "assets/images/User-1.svg",height: 25,
            ),
          ],

          onTap: (index) {
            setState(() {
              _page = index;
            });
            //Handle button tap
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
