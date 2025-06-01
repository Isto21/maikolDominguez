import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maikol_tesis/config/helpers/failures.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart';
import 'package:maikol_tesis/data/dio/api_client.dart';
import 'package:maikol_tesis/data/shared_preferences/token_storage.dart';
import 'package:maikol_tesis/domain/repositories/remote/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._apiClient, this._tokenStorage);

  @override
  Future<Either<Failure, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await _apiClient.login({
        'email': email,
        'password': password,
      });

      // Guardar el token
      await _tokenStorage.saveToken(response.token);

      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await _apiClient.getCurrentUser();
      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> register(
    RegisterRequest request,
  ) async {
    try {
      final response = await _apiClient.register(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, ActivationResponse>> activateAccount(
    String email,
    String activationCode,
  ) async {
    try {
      final request = ActivationRequest(
        email: email,
        activationCode: activationCode,
      );

      final response = await _apiClient.activateAccount(request);

      // Si la activación es exitosa y devuelve un token, guardarlo
      if (response.token != null && response.token!.isNotEmpty) {
        await _tokenStorage.saveToken(response.token!);
      }

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    }
  }

  @override
  Future<bool> hasValidToken() async {
    try {
      final token = await _tokenStorage.getToken();
      return token != null && token.isNotEmpty;
    } on DioException catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Intentar hacer logout en el servidor
      await _apiClient.logout();
    } catch (e) {
      // Ignorar errores del servidor en logout
    } finally {
      // Siempre limpiar el token local
      // await _tokenStorage.clearToken();
    }
  }

  @override
  Future<void> clearToken() async {
    await _tokenStorage.clearToken();
  }

  String _getErrorMessage(DioException error) {
    if (error.toString().contains('401')) {
      return 'Credenciales incorrectas';
    } else if (error.toString().contains('404')) {
      return 'Usuario no encontrado';
    } else if (error.toString().contains('500')) {
      return 'Error del servidor. Intente más tarde';
    } else if (error.toString().contains('timeout')) {
      return 'Tiempo de espera agotado. Verifique su conexión';
    } else if (error.toString().contains('SocketDioException')) {
      return 'Sin conexión a internet';
    } else {
      return error.response?.data['message'] ?? 'Error desconocido';
    }
  }
}
