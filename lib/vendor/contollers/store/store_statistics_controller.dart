
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:wena_partners/vendor/models/store/store_statistics_model.dart';
import 'package:wena_partners/vendor/utils/constants.dart';


class StoreStatisticsController extends GetxController {

  final String storeId;
  StoreStatisticsController({ required this.storeId});

  var isLoading = true.obs;
  var storeStat = StoreStatistics().obs;


  static var client = http.Client();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchStoreStats();

  }


  void fetchStoreStats() async {
    var response = await client.get(Uri.parse('${Constants.BASE_URL}store/statistics/$storeId'));
    if (response.statusCode == 200) {
      storeStat.value = StoreStatistics.fromJson(jsonDecode(response.body));
      print(storeStat.value.dailyOrders);
      print(response.body);
      print(jsonDecode(response.body)['status']);
      isLoading.value = false;
    } else {
      isLoading(true);
      throw Exception('Failed to fetch store stats');
    }
  }

}