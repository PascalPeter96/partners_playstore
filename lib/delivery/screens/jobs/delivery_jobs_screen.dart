import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/delivery/screens/jobs/all_delivery_jobs_screen.dart';
import 'package:wena_partners/delivery/screens/jobs/completed_delivery_jobs_screen.dart';
import 'package:wena_partners/delivery/screens/jobs/pending_delivery_jobs_screen.dart';
import 'package:wena_partners/widgets/title_app_bar.dart';


class DeliveryJobsScreen extends StatefulWidget {
  const DeliveryJobsScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryJobsScreen> createState() => _DeliveryJobsScreenState();
}

class _DeliveryJobsScreenState extends State<DeliveryJobsScreen> with TickerProviderStateMixin{

  int selectedIndex = 0;

  var jobTabs = const [
    Tab(text: 'All'),
    Tab(text: 'Completed'),
    Tab(text: 'Pending'),

  ];

  @override
  Widget build(BuildContext context) {
    TabController jobTabCont = TabController(length: 3, vsync: this);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Jobs', style: AppTheme.appTitle,),
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

                  tabs: jobTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: jobTabCont,
                children: [
                  AllDeliveryJobsScreen(),
                  CompletedDeliveryJobsScreen(),
                  PendingDeliveryJobsScreen(),
                ],

              ),
            ),
          ],
        ),
      ),

    );

  }
}
