import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/jobs/all_delivery_jobs_screen.dart';
import 'package:wena_partners/delivery/screens/jobs/completed_delivery_jobs_screen.dart';
import 'package:wena_partners/delivery/screens/jobs/pending_delivery_jobs_screen.dart';
import 'package:wena_partners/delivery/screens/orders/all_recent_orders_screen.dart';
import 'package:wena_partners/delivery/screens/orders/canceled_recent_orders_screen.dart';
import 'package:wena_partners/delivery/screens/orders/completed_recent_orders_screen.dart';
import 'package:wena_partners/delivery/screens/orders/pending_recent_orders_screen.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class DeliveryOrdersScreen extends StatefulWidget {
  const DeliveryOrdersScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryOrdersScreen> createState() => _DeliveryOrdersScreenState();
}

class _DeliveryOrdersScreenState extends State<DeliveryOrdersScreen> with TickerProviderStateMixin{

  int selectedIndex = 0;

  var orderTabs = const [
    Tab(text: 'All'),
    Tab(text: 'Completed'),
    Tab(text: 'Pending'),
    Tab(text: 'Canceled'),

  ];

  @override
  Widget build(BuildContext context) {
    TabController jobTabCont = TabController(length: 4, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Orders', style: AppTheme.appTitle,),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Container(
              height: 5.h,
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: EdgeInsets.only( right: 10.w, left: 10.w),
                labelStyle: TextStyle(
                    fontSize: 17.5.sp,
                    fontWeight: FontWeight.w600
                ),
                isScrollable: true,
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: AppTheme.subtitleTextColor,
                controller: jobTabCont,
                indicatorColor: Colors.transparent,
                indicator: BoxDecoration(
                    color: AppTheme.primaryLightColor,
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(
                        color: AppTheme.primaryColor
                    )
                ),

                tabs: orderTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: jobTabCont,
                children: [
                  AllRecentOrdersScreen(),
                  CompletedRecentOrdersScreen(),
                  PendingRecentOrdersScreen(),
                  CanceledRecentOrdersScreen(),
                ],

              ),
            ),
          ],
        ),
      ),

    );

  }
}
