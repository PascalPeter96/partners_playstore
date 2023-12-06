import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wena_partners/vendor/models/wallet/wallet_payments_model.dart';
import 'package:wena_partners/vendor/utils/constants.dart';


class WalletPaymentsRepository {

  static var client = http.Client();

  Future<List<VendorWalletPayment>?> fetchWalletTransactions(String walletId) async {

    var response = await client.get(Uri.parse('${Constants.BASE_URL}wallet-payments/$walletId'));
    Iterable data = jsonDecode(response.body)['payments'];
    print(response.body);
    print(data);

    if(response.statusCode == 200) {
      print('${Constants.BASE_URL}wallet-payments/$walletId');
      return data.map((e) => VendorWalletPayment.fromJson(e)).toList();
    } else {
      return null;
    }

  }
}