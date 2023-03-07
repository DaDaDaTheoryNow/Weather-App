import 'package:get_storage/get_storage.dart';

class Token {
  checkTokenCalls() {
    GetStorage box = GetStorage();
    var getApiCalls = box.read("getApiCalls") ?? 0;

    if (getApiCalls != null) {
      if (getApiCalls > 2000) {
        // delete token if many calls
        return "null";
      } else {
        // set token if calls accepted
        return box.read("token") ?? "f156f72186d543ffb34135421230403";
      }
    }
  }
}
