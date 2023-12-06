

import 'dart:io';

import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

class AddBranchRepository {
  ApiResponse<dynamic?> branchResp = ApiResponse.init();
  Future<dynamic?> addBranch(
      {required Map<String, dynamic> data,
      required Map<String, File>? files,
      required var stateChange}) async {
    branchResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.addBranchUrl, files: files, data: data);
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
