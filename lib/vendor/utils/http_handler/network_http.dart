// The best way to handle network requests in Flutter
// Applications frequently need to perform POST and GET and other HTTP requests.
// Flutter provides an http package that supports making HTTP requests.

// HTTP methods: GET, POST, PATCH, PUT, DELETE
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:wena_partners/vendor/config/api_string.dart';

class HttpHandler {
  static String baseURL = APIString.baseURL;

  static Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {};
  }

  static Future<Map<String, dynamic>> postFormDataMethod(
      {required String url,
      required Map<String, String> body,
      String? imagePath,
      List<String>? imageList,
      String? imageKey}) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString(
    //   PrefString.token,
    // );
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        "$baseURL$url",
      ),
    );
    log(
      "---  $request",
    );
    request.headers.addAll(
      {
        // 'Authorization': '$token',
        'Content-Type':
            'multipart/form-data; boundary=<calculated when request is sent>',
      },
    );

    log(
      "body ---- $body",
    );

    if (imagePath != null) {
      log(
        "image -- $imagePath",
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          '$imageKey',
          imagePath,
        ),
      );
    }
    if (imageList != null) {
      for (var element in imageList) {
        request.files.add(
          await http.MultipartFile.fromPath(
            '$imageKey',
            element,
          ),
        );
      }
    }
    request.fields.addAll(
      body,
    );
    var response = await request.send();

    log(
      "response -- $response",
    );
    var responseData = await response.stream.toBytes();

    log(
      "responseData -- $responseData",
    );
    String responseString = String.fromCharCodes(
      responseData,
    );
    log(
      "Check issue = $responseString",
    );

    if (response.statusCode == 200) {
      var data = json.decode(
        responseString,
      );
      Map<String, dynamic> returnRes = {
        'body': data,
        'error': null,
      };
      return returnRes;
    } else {
      Map<String, dynamic> returnRes = {
        'body': null,
        'error': responseString,
      };
      log('Something went wrong');
      return returnRes;
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod({
    @required String? url,
    bool isMockUrl = false,
  }) async {
    var header = await _getHeaders();

    log("Get URL -- '$baseURL$url'");
    debugPrint("Get Data -- 'null'");

    var response = await Dio().get("$baseURL$url");

    debugPrint("Get Response Code -- '${response.statusCode}'");
    debugPrint("Get Response -- '${response.data}'");
    if (response.statusCode == 200) {
      debugPrint("In Get '200'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Get '400'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Get '401'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Get '403'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Get '404'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Get '500'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Get 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> postHttpMethod({
    @required String? url,
    Map<String, XFile>? fileData,
    Map<String, dynamic>? data,
    Map<String, File>? files,
  }) async {
    var header = await _getHeaders();
    debugPrint("Post URL -- '$baseURL$url'");
    debugPrint("Post Data -- '$data'");
    FormData formdata = FormData.fromMap(data!);
    if (fileData != null) {
      fileData.forEach((key, value) async {
        formdata.files.addAll([
          MapEntry(key, await MultipartFile.fromFile(File(value.path).path)),
        ]);
      });
    }
    if (files != null) {
      files.forEach((key, value) async {
        formdata.files.addAll([
          MapEntry(key, await MultipartFile.fromFile(File(value.path).path)),
        ]);
      });
    }
    var response = await Dio().post("$baseURL$url", data: formdata);

    debugPrint("Post Response Code -- '${response.statusCode}'");

    debugPrint("Post Response -- '${response.data}'");
    if (response.statusCode == 200) {
      debugPrint("In Post '200'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Post '400'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Post '401'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Post '403'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Post '404'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Post '500'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Post 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> patchHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    FormData formdata = FormData.fromMap(data!);
    var header = await _getHeaders();
    debugPrint("Patch URL -- '$baseURL$url'");
    debugPrint("Patch Data -- '$data'");
    var response = await Dio().patch("$baseURL$url", data: formdata);

    debugPrint("Patch Response Code -- '${response.statusCode}'");
    debugPrint("Patch Response -- '${response.data}'");
    if (response.statusCode == 200) {
      debugPrint("In Patch '200'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Patch '400'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Patch '401'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Patch '403'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Patch '404'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Patch '500'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Patch 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> putHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    FormData formdata = FormData.fromMap(data!);
    var header = await _getHeaders();
    debugPrint("Put URL -- '$baseURL$url'");
    debugPrint("Put Data -- '$data'");
    var response = await Dio().put("$baseURL$url", data: formdata);

    debugPrint("PUT Response code -- '${response.statusCode}'");
    debugPrint("PUT Response -- '${response.data}'");

    if (response.statusCode == 200) {
      debugPrint("In Put '200'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Put '400'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Put '401'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Put '403'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Put '404'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Put '500'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Put 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> deleteHttpMethod({
    @required String? url,
  }) async {
    var header = await _getHeaders();
    debugPrint("Delete URL -- '$baseURL$url'");
    debugPrint("Delete Data -- 'null'");
    var response = await Dio().delete("$baseURL$url");

    debugPrint("Delete Response Code -- '${response.statusCode}'");
    debugPrint("Delete Response -- '${response.data}'");
    if (response.statusCode == 200) {
      debugPrint("In Delete '200'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Delete '400'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Delete '401'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Delete '403'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Delete '404'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Delete '500'");
      Map<String, dynamic> data = {
        'body': response.data,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Delete 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }
}
