import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wena_partners/vendor/account/screens/account_screen.dart';
import 'package:wena_partners/vendor/contollers/store/store_statistics_controller.dart';
import 'package:wena_partners/vendor/dashboard/screens/home_tab_screen.dart';
import 'package:wena_partners/vendor/dashboard/widget/bottom_menu_widget.dart';
import 'package:wena_partners/vendor/orders/screens/order_screen.dart';
import 'package:wena_partners/vendor/product/screen/product_list_screen.dart';
import 'package:wena_partners/vendor/screens/wallet/wallet_screen.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/utils/const.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashoboardState createState() => _DashoboardState();
}

class _DashoboardState extends State<DashboardScreen> {


  int visit = 0;

  List<int> screenTrack = [0];
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  late Position currentLocation;
  getUserLocation() async {
    currentLocation = await locateUser();
    userLat = currentLocation.latitude;
    userLon = currentLocation.longitude;
  }

  Future<bool> _onWillPop() async {
    bool check = false;
    if (screenTrack.length > 1) {
      screenTrack.removeAt(screenTrack.length - 1);
      visit = screenTrack[screenTrack.length - 1];

      if (mounted) {
        setState(() {});
      }
    } else {
      check = true;
    }

    return check;
  }

  chekLocationPermission() async {
    Geolocator.checkPermission().then((LocationPermission value) {
      if (value.name == "always" || value.name == "whileInUse") {
        if (mounted) {
          getUserLocation();
        }
      } else {
        Geolocator.requestPermission().then((LocationPermission value) {
          if (value.name == "always" || value.name == "whileInUse") {
            if (mounted) {
              getUserLocation();
            }
          }
        });
      }
    });
  }

  List<dynamic> pages = [
    HomeTabScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState

    chekLocationPermission();

    pages = [
      HomeTabScreen(),
      VendorWalletScreen(),
      ProducListScreen(backListner: () {
        _onWillPop();
      }),
      OrderScreen(backListner: () {
        _onWillPop();
      }),
      AccountScreen(() {
        _onWillPop();
      })
    ];

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          child: CustomBottomBarInspiredOutside(
            items: [
              CustomTabItem(
                icon: visit == 0
                    ? Container(
                        width: dimen60,
                        height: dimen50,
                        padding: EdgeInsets.all(dimen05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(dimen30),
                            ),
                            color: const Color(colorSecondary)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(dimen40),
                          child: ImageIcon(
                            const AssetImage("assets/icons/home.png"),
                            color: Colors.white,
                            size: dimen28,
                          ),
                        ))
                    : ImageIcon(
                        const AssetImage("assets/icons/home.png"),
                        color: const Color(colorContent),
                        size: dimen28,
                      ),
                title: 'Home',
              ),

              CustomTabItem(
                icon: visit == 1
                    ? Container(
                    width: dimen60,
                    height: dimen50,
                    padding: EdgeInsets.all(dimen05),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(dimen30),
                        ),
                        color: const Color(colorSecondary)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(dimen40),
                      child: Icon(Icons.wallet, size: dimen24, color: Colors.white,)
                    ))
                    : Icon(Icons.wallet, size: dimen24, color: const Color(colorContent),),
                title: 'Wallet',
              ),

              CustomTabItem(
                icon: visit == 2
                    ? Container(
                        width: dimen50,
                        height: dimen50,
                        padding: EdgeInsets.all(dimen05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(dimen40),
                            ),
                            color: const Color(colorSecondary)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(dimen40),
                          child: ImageIcon(
                            const AssetImage("assets/icons/product.png"),
                            color: Colors.white,
                            size: dimen28,
                          ),
                        ))
                    : ImageIcon(
                        const AssetImage("assets/icons/product.png"),
                        color: const Color(colorContent),
                        size: dimen28,
                      ),
                title: 'Product',
              ),
              CustomTabItem(
                icon: visit == 3
                    ? Container(
                        width: dimen50,
                        height: dimen50,
                        padding: EdgeInsets.all(dimen05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(dimen40),
                            ),
                            color: const Color(colorSecondary)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(dimen40),
                          child: ImageIcon(
                            const AssetImage("assets/icons/orders.png"),
                            color: Colors.white,
                            size: dimen28,
                          ),
                        ))
                    : ImageIcon(
                        const AssetImage("assets/icons/orders.png"),
                        color: const Color(colorContent),
                        size: dimen28,
                      ),
                title: 'Order',
              ),
              CustomTabItem(
                icon: visit == 4
                    ? Container(
                        width: dimen50,
                        height: dimen50,
                        padding: EdgeInsets.all(dimen05),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(dimen40),
                            ),
                            color: const Color(colorSecondary)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(dimen40),
                          child: ImageIcon(
                            const AssetImage("assets/icons/user.png"),
                            color: Colors.white,
                            size: dimen28,
                          ),
                        ))
                    : ImageIcon(
                        const AssetImage("assets/icons/user.png"),
                        color: const Color(colorContent),
                        size: dimen28,
                      ),
                title: 'Account',
              ),
            ],
            backgroundColor: Colors.white,
            color: const Color(colorContent),
            colorSelected: Colors.green,
            indexSelected: visit,
            onTap: (int index) => setState(() {
              visit = index;
              screenTrack.add(index);
            }),
            top: 5,
            animated: true,
            itemStyle: ItemStyle.circle,
          ),
        ),
        body: SafeArea(
            child: WillPopScope(
                onWillPop: () {
                  return _onWillPop();
                },
                child: GestureDetector(
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
                              child: pages[visit],
                            )))))));
  }
}
