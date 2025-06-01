// import 'package:maikol_tesis/data/datasources/usecases/auth_api.dart';
// import 'package:maikol_tesis/data/dio/my_dio.dart';
// import 'package:maikol_tesis/domain/repositories/remote/remote_repository.dart';
// import 'package:maikol_tesis/domain/repositories/remote/usecases/auth_remote_repository.dart';

// class ApiConsumer extends RemoteRepository {
//   final String language;
//   static RemoteRepository _instace({required language}) =>
//       ApiConsumer._(language: language);
//   late MyDio _myDio;
//   late AuthApi _authApi;
//   static RemoteRepository getInstance({required language}) =>
//       _instace(language: language);

//   ApiConsumer._({required this.language}) {
//     _myDio = MyDio(language: language);
//     _authApi = AuthApi(_myDio);
//   }

//   @override
//   AuthRemoteRepository get auth => _authApi;
// }
