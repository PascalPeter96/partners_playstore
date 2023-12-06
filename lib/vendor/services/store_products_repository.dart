import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wena_partners/vendor/models/retail/store_products_variants_model.dart';
import 'package:wena_partners/vendor/utils/constants.dart';


class StoreProductVariantsRepository {


  static var client = http.Client();

  Future<List<StoreProductVariants>?> fetchStoreProductVariants(String? token) async {

    var response = await client.get(Uri.parse('${Constants.BASE_URL}store/products/variations'),
    headers: {
      'Accept' : 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token'
    },
    );

    print(response.body);

    Iterable data = jsonDecode(response.body)['data'];

    print(response);
    print(data);

    if(response.statusCode == 200) {
      print(response);
      print(data);
      return data.map((e) => StoreProductVariants.fromJson(e)).toList();
    } else {
      return null;
    }

  }


}