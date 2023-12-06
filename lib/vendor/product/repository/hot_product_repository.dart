
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

import '../../utils/http_handler/network_http.dart';

class HotProductRepository {
  ApiResponse<dynamic?> productResp = ApiResponse.init();
  Future<dynamic?> getHotProducts(
      {required Map<String, dynamic> data, required var stateChange}) async {
    productResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.hotProudctUrl, data: data);
    final jsonData = response;
    productResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      productResp.message = response["body"]["message"];
      productResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
