import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wena_partners/app_style/app_theme.dart';

class CompletedDeliveryJobsScreen extends StatefulWidget {
  const CompletedDeliveryJobsScreen({Key? key}) : super(key: key);

  @override
  State<CompletedDeliveryJobsScreen> createState() => _CompletedDeliveryJobsScreenState();
}

class _CompletedDeliveryJobsScreenState extends State<CompletedDeliveryJobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset('assets/lotties/empty_order.json'),
          Text('No Completed Jobs', style: AppTheme.greenSectionTitle2,),
        ],
      ),
    );
  }
}
