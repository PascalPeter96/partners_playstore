
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

import '../../utils/http_handler/network_http.dart';

class WithdrowRepository {
  ApiResponse<dynamic?> walletResp = ApiResponse.init();
  Future<dynamic?> withdrow(
      {required Map<String, dynamic> data, required var stateChange}) async {
    walletResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.withdorwAmountUrl, data: data);
    final jsonData = response;
    walletResp.status = Status.COMPLETED;
    stateChange();
    return jsonData;
  }
}
