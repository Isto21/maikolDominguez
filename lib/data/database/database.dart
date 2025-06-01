// import 'package:maikol_tesis/data/shared_preferences/constants_shared_prefs.dart';
// import 'package:maikol_tesis/data/shared_preferences/shared_prefs.dart';
// import 'package:maikol_tesis/domain/repositories/local/local_repository.dart';

// class Database extends LocalRepository {
//   static Database? _instance;
//   // Avoid self instance
//   Database._();
//   static Database get instance => _instance ??= Database._();

//   @override
//   void saveLanguage(String language) {
//     Prefs.instance.saveValue(ConstantsSharedPrefs.language, language);
//   }

//   @override
//   String getLanguage() {
//     return Prefs.instance.getValue(ConstantsSharedPrefs.language);
//   }
// }
