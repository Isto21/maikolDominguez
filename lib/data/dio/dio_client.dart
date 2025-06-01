import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maikol_tesis/data/shared_preferences/token_storage.dart';

import 'api_client.dart';
import 'api_endpoints.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // Configuración base
  dio.options = BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  // Interceptor para logs
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
      error: true,
    ),
  );

  // Interceptor para autenticación
  dio.interceptors.add(AuthInterceptor(ref.read(tokenStorageProvider)));

  // Interceptor para manejo de errores
  dio.interceptors.add(ErrorInterceptor());

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
});

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // No agregar token para endpoints de auth
    final isAuthEndpoint =
        options.path.contains('/auth/login') ||
        options.path.contains('/auth/register');

    if (!isAuthEndpoint) {
      final token = await _tokenStorage.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expirado o inválido
      // await _tokenStorage.clearToken();
      handler.next(err);
    }
    handler.next(err);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = 'Error de conexión';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Tiempo de espera agotado. Verifique su conexión';
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        switch (statusCode) {
          case 400:
            message = 'Datos inválidos';
            break;
          case 401:
            message = 'No autorizado';
            break;
          case 403:
            message = 'Acceso denegado';
            break;
          case 404:
            message = 'Recurso no encontrado';
            break;
          case 422:
            message = _extractValidationErrors(err.response?.data);
            break;
          case 500:
            message = 'Error del servidor';
            break;
          default:
            message = 'Error del servidor ($statusCode)';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Solicitud cancelada';
        break;
      case DioExceptionType.unknown:
        if (err.message?.contains('SocketException') == true) {
          message = 'Sin conexión a internet';
        } else {
          message = 'Error desconocido';
        }
        break;
      default:
        message = 'Error de conexión';
    }

    final dioError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: message,
      message: message,
    );

    handler.next(dioError);
  }

  String _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey('errors')) {
        final errors = data['errors'] as Map<String, dynamic>;
        final messages = <String>[];
        errors.forEach((key, value) {
          if (value is List) {
            messages.addAll(value.cast<String>());
          } else {
            messages.add(value.toString());
          }
        });
        return messages.join(', ');
      } else if (data.containsKey('message')) {
        return data['message'].toString();
      }
    }
    return 'Datos inválidos';
  }
}
