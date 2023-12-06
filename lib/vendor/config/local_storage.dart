import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  // DATA TYPE
  static const String boolType = "BOOL";
  static const String doubleType = "DOUBLE";
  static const String integerType = "INTEGER";
  static const String stringType = "STRING";
  static const String listOfStringType = "LIST-OF-STRING";

  // LOCAL STORAGE KEY
  static const String userID = "UserID";
  static const String token = "Token";

  static const String userName = "userName";
  static const String userEmail = "userEmail";
  static const String profilePic = "profilePic";

  static setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userID, userId);
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userID) ?? "";
  }

  static setToken(String userToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, userToken);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token) ?? "";
  }

  static setUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userName, name);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? "";
  }

  static setUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userEmail, email);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail) ?? "";
  }

  static setUserProfilePic(String pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(profilePic, pic);
  }

  static Future<String> getUserProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(profilePic) ?? "";
  }

  static setFCMId(String fcmId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcm_id", fcmId);
  }

  static Future<String> getFCMId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("fcm_id") != null) {
      return prefs.getString("fcm_id")!;
    } else {
      return "";
    }
  }
}
