
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

class CityListRepository {
  ApiResponse<dynamic?> cityResp = ApiResponse.init();
  Future<dynamic?> getCity({required var stateChange}) async {
    cityResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.getHttpMethod(
      url: APIString.cityListUrl,
    );
    final jsonData = response;
    cityResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      cityResp.message = response["body"]["message"];
      cityResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
