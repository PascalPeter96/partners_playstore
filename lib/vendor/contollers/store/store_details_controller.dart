
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:wena_partners/vendor/models/store/store_details_model.dart';
import 'package:wena_partners/vendor/models/store/store_statistics_model.dart';
import 'package:wena_partners/vendor/utils/constants.dart';


class StoreDetailsController extends GetxController {

  final String storeId;
  StoreDetailsController({ required this.storeId});

  var isLoading = true.obs;
  var storeDetails = StoreDetails().obs;


  var storeBranchId = ''.obs;

  static var client = http.Client();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchStoreDetails();

  }

  setStoreBranchId(String id){
    storeBranchId.value = id;
    print(storeBranchId);
  }

  void fetchStoreDetails() async {
    var response = await client.get(Uri.parse('${Constants.BASE_URL}store/$storeId'));
    if (response.statusCode == 200) {
      storeDetails.value = StoreDetails.fromJson(jsonDecode(response.body)['data']);
      print(storeDetails.value.businessTel);
      print(response.body);
      print(jsonDecode(response.body)['status']);
      isLoading.value = false;
    } else {
      isLoading(true);
      throw Exception('Failed to fetch store details');
    }
  }

}