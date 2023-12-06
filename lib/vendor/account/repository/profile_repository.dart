
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';
class ProfileRepository {
  ApiResponse<dynamic?> profileResp = ApiResponse.init();
  Future<dynamic?> getProfile(
      {required Map<String, dynamic> data, required var stateChange}) async {
    profileResp.status = Status.LOADING;
    stateChange();
    var response = await HttpHandler.postHttpMethod(
        url: APIString.vendorProfileUrl, data: data);
    final jsonData = response;
    profileResp.status = Status.COMPLETED;
    stateChange();

    return jsonData;
  }
}
