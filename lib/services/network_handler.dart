import 'package:http/http.dart' as http;

class NetworkHandler {

  static final client = http.Client();

  static Future<String> post(var body, String endpoint, String? token) async {
    var response = await client
        .post(
      buildUrl(endpoint),
      body: body,
      headers: {
        'Accept' : 'application/json',
        'Content-type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Authorization': 'Bearer $token'
      }
    );
    // print(response.body);
    return response.body.toString();
  }

  static Future<String> delete(var body, String endpoint, String? token) async {

    var response = await client.delete(
        buildUrl(endpoint),
        body: body,
        headers: {
          'Accept' : 'application/json',
          'Content-type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        }
    );


    // print(response.body);
    return response.body.toString();
  }

  static Future<dynamic> get(String endpoint, String? token) async {
    var response = await client
        .get(
        buildUrl(endpoint),
        headers: {
          'Accept' : 'application/json',
          'Content-type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        },
    );
    return response.body;
  }

  static Future<String> patch(var body, String endpoint, String? token) async {
    var response = await client
        .patch(
        buildUrl(endpoint),
        body: body,
        headers: {
          'Accept' : 'application/json',
          'Content-type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
          'Authorization': 'Bearer $token'
        }
    );
    // print(response.body);
    return response.body.toString();
  }

  static Uri buildUrl(String endpoint){
    String baseUrl = 'https://admin.wenahardware.com/api/v1/';
    // String baseUrl = 'https://staging.wenahardware.com/api/v1/';
    // {{base_url}}
    final apiPath = baseUrl + endpoint;
    return Uri.parse(apiPath);
  }

  // static void storeToken(String token) async {
  //   await storage.write(key: 'Access-Token', value: token);
  // }
  //
  // static Future<String?> getToken(String token) async {
  //   return await storage.read(key: 'Access-Token');
  // }



}