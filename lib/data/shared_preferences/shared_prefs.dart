// import 'package:shared_preferences/shared_preferences.dart';

// class Prefs<T> {
//   static Prefs? _instance;

//   Prefs() {
//     //  initPrefs();
//   }
//   late SharedPreferences _prefs;

//   static Prefs get instance {
//     _instance ??= Prefs();
//     return _instance!;
//   }

//   Future<void> initPrefs() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   Future<bool> saveValue(String key, T value) async {
//     if (value is String) {
//       return _prefs.setString(key, value);
//     } else if (value is int) {
//       return _prefs.setInt(key, value);
//     } else if (value is bool) {
//       return _prefs.setBool(key, value);
//     } else if (value is double) {
//       return _prefs.setDouble(key, value);
//     } else if (value is List<String>) {
//       return _prefs.setStringList(key, value);
//     } else {
//       throw Exception('Invalid Type');
//     }
//   }

//   T getValue(String key) {
//     var value = _prefs.get(key);
//     return value as T;
//   }
// }
