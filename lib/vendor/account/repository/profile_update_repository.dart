import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:wena_partners/vendor/config/api_string.dart';
import 'package:wena_partners/vendor/utils/api_response.dart';
import 'package:wena_partners/vendor/utils/http_handler/network_http.dart';
import 'package:wena_partners/vendor/utils/status.dart';

import '../../utils/api_response.dart';

class UpdateProfileRepository {
  ApiResponse<dynamic?> accountResp = ApiResponse.init();
  Future<dynamic?> updateProfile(
      {required Map<String, dynamic> data,
      required Map<String, XFile>? fileData,
      required Map<String, File>? files,
      required var stateChange}) async {
    accountResp.status = Status.LOADING;
    stateChange();
    Map response = await HttpHandler.postHttpMethod(
        url: APIString.updateProfileUrl,
        fileData: fileData,
        files: files,
        data: data);
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
