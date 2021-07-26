import 'package:cek_ongkir_app/common/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPData {
  Future loadFromSP(String key, SharedDataType type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (type) {
      case SharedDataType.bool:
        return prefs.getBool(key);
        break;
      case SharedDataType.int:
        return prefs.getInt(key);
        break;
      case SharedDataType.string:
        return prefs.getString(key);
        break;
      default:
        return null;
        break;
    }
  }

  void saveToSP(String key, SharedDataType type, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      switch (type) {
        case SharedDataType.bool:
          await prefs.setBool(key, value);
          break;
        case SharedDataType.int:
          await prefs.setInt(key, value);
          break;
        case SharedDataType.string:
          await prefs.setString(key, value);
          break;
        default:
          return null;
          break;
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<bool> resetSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.clear();
    } catch (e) {
      return e;
    }
  }
}
