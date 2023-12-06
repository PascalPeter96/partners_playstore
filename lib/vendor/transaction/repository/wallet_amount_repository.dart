
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

import '../../utils/http_handler/network_http.dart';

class WalletAmountRepository {
  ApiResponse<dynamic?> productResp = ApiResponse.init();
  Future<dynamic?> getWalletAmount(
      {required Map<String, dynamic> data, required var stateChange}) async {
    productResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.walletAmountUrl, data: data);
    final jsonData = response;
    productResp.status = Status.COMPLETED;
    stateChange();
    return jsonData;
  }
}
