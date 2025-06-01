import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart';
import 'package:maikol_tesis/data/datasources/usecases/auth_repository_impl.dart';
import 'package:maikol_tesis/data/dio/dio_client.dart';
import 'package:maikol_tesis/data/shared_preferences/token_storage.dart';
import 'package:maikol_tesis/domain/repositories/remote/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthRepositoryImpl(apiClient, tokenStorage);
});

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({User? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get isAuthenticated => user != null;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<bool> validateToken() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _repository.getCurrentUser();

      return result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
            user: null,
          );
          return false;
        },
        (user) {
          state = state.copyWith(user: user, isLoading: false, error: null);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al validar token',
        user: null,
      );
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _repository.login(email, password);

      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (loginResponse) async {
          // Después del login exitoso, obtener datos del usuario
          final userResult = await _repository.getCurrentUser();

          return userResult.fold(
            (failure) {
              state = state.copyWith(
                isLoading: false,
                error: 'Error al obtener datos del usuario',
              );
              return false;
            },
            (user) {
              state = state.copyWith(user: user, isLoading: false, error: null);
              return true;
            },
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> register(RegisterRequest request) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _repository.register(request);

      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (response) {
          state = state.copyWith(isLoading: false, error: null);
          return true;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> activateAccount(String email, String activationCode) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final result = await _repository.activateAccount(email, activationCode);

      return result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
          return false;
        },
        (response) async {
          // Si la activación es exitosa y tenemos token, obtener datos del usuario
          if (response.token != null && response.token!.isNotEmpty) {
            final userResult = await _repository.getCurrentUser();

            return userResult.fold(
              (failure) {
                state = state.copyWith(
                  isLoading: false,
                  error:
                      'Cuenta activada pero error al obtener datos del usuario',
                );
                return true; // Consideramos la activación exitosa aunque falle obtener el usuario
              },
              (user) {
                state = state.copyWith(
                  user: user,
                  isLoading: false,
                  error: null,
                );
                return true;
              },
            );
          } else {
            state = state.copyWith(isLoading: false, error: null);
            return true;
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error de conexión: ${e.toString()}',
      );
      return false;
    }
  }

  Future<void> logout() async {
    // Solo limpiar el token local, no hacer petición al servidor
    await _repository.clearToken();
    state = const AuthState();
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
