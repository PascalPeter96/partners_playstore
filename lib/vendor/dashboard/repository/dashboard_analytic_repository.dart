
import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

class DashboardAnalyticRepository {
  ApiResponse<dynamic?> dashboardResp = ApiResponse.init();
  Future<dynamic?> getAnalytics(
      {required Map<String, dynamic> data, required var stateChange}) async {
    dashboardResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.dashboardAnalyticsUrl, data: data);
    final jsonData = response;
    dashboardResp.status = Status.COMPLETED;
    stateChange();
    if (jsonData["body"]["status"] != 200) {
      dashboardResp.message = response["body"]["message"];
      dashboardResp.status = Status.ERROR;
      stateChange();
    }
    return jsonData;
  }
}
