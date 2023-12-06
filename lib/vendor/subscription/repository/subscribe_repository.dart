import '../../config/api_string.dart';
import '../../utils/api_response.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/status.dart';

class SubscribeRepository {
  ApiResponse<dynamic?> subResp = ApiResponse.init();
  Future<dynamic?> subScribe(
      {required Map<String, dynamic> data, required var stateChange}) async {
    subResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.planSubscribeUrl, data: data);
    final jsonData = response;
    subResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      subResp.message = response["body"]["message"];
      subResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
