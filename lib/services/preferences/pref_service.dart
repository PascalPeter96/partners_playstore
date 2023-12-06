import 'package:get_storage/get_storage.dart';

class PrefService {

  final pref =  GetStorage();
  Future createString(String key, String value) async {
    // final pref =  GetStorage();
    return pref.write(key, value);
  }

  Future readString(String key) async {
    // final pref =  GetStorage();
    var cache = pref.read(key) ?? '';
    return cache;
  }

}