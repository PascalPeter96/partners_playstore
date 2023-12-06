import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wena_partners/app_style/app_theme.dart';

class PendingDeliveryJobsScreen extends StatefulWidget {
  const PendingDeliveryJobsScreen({Key? key}) : super(key: key);

  @override
  State<PendingDeliveryJobsScreen> createState() => _PendingDeliveryJobsScreenState();
}

class _PendingDeliveryJobsScreenState extends State<PendingDeliveryJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset('assets/lotties/empty_order.json'),
          Text('No Pending Jobs', style: AppTheme.greenSectionTitle2,),
        ],
      ),
    );
  }
}
