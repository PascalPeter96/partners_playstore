

import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

import '../../utils/api_response.dart';

class LoginRepository {
  ApiResponse<dynamic?> accountResp = ApiResponse.init();
  Future<dynamic?> login(
      {required Map<String, String> data, required var stateChange}) async {
    accountResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.vendorLoginUrl, data: data);
    final jsonData = response;
    accountResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      accountResp.message = response["body"]["message"];
      accountResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
