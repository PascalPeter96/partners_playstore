
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

class VendorListRepository {
  ApiResponse<dynamic?> vendorResp = ApiResponse.init();
  Future<dynamic?> getVendors({required var stateChange}) async {
    vendorResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.getHttpMethod(
      url: APIString.vendorListUrl,
    );
    final jsonData = response;
    vendorResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      vendorResp.message = response["body"]["message"];
      vendorResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
