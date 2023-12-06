import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:wena_partners/vendor/models/store/store_statistics_model.dart';
import 'package:wena_partners/vendor/utils/constants.dart';



class StoreStatisticsRepository {

  static var client = http.Client();


  Future<StoreStatistics?> fetchUserDetails(String id) async {

    var response = await client.get(Uri.parse('${Constants.BASE_URL}store/statistics/$id'));
    // Iterable data = jsonDecode(response.body)['data']['customer'];
    var data = jsonDecode(response.body)['data'];
    print(data);


    if(response.statusCode == 200) {
      print(data);
      return data.map((e) => StoreStatistics.fromJson(e));
    } else {
      return null;
    }

  }


}