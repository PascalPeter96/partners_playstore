
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

class BranchDetailRepository {
  ApiResponse<dynamic?> branchResp = ApiResponse.init();
  Future<dynamic?> getBranchDetails(
      {required Map<String, dynamic> data, required var stateChange}) async {
    branchResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.branchDetailUrl, data: data);
    final jsonData = response;
    branchResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      branchResp.message = response["body"]["message"];
      branchResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
