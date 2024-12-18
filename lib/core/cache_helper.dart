import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;
  static initSharedPres() async {
    prefs = await SharedPreferences.getInstance();
  }

  //set all data
  static setDataAll({required String key, required dynamic value}) async {
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else {
      await prefs.setInt(key, value);
    }
  }

  static dynamic getData({required String Key}) {
    return prefs.get(Key);
  }
}

//set data
  // _setData({required String key, required double value}) async {
  //   await prefs.setDouble(key, value); //key,value
  // }

  // //set integer value
  // _setInteger({required String key, required int value}) async {
  //   await prefs.setInt(key, value);
  // }

  // //set String value
  // void _setString({required String key, required String value}) async {
  //   await prefs.setString(key, value);
  // }

  // void _setbool({required String key, required bool value}) async {
  //   await prefs.setBool(key, value);
  // }