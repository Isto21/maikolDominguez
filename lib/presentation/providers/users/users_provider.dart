import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart';
import 'package:maikol_tesis/data/dio/api_client.dart';
import 'package:maikol_tesis/data/dio/dio_client.dart';

class UsersState {
  final List<User> users;
  final bool isLoading;
  final String? error;

  const UsersState({this.users = const [], this.isLoading = false, this.error});

  UsersState copyWith({List<User>? users, bool? isLoading, String? error}) {
    return UsersState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UsersNotifier extends StateNotifier<UsersState> {
  final ApiClient _apiClient;

  UsersNotifier(this._apiClient) : super(const UsersState());

  Future<void> loadUsers() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final users = await _apiClient.getUsers();

      state = state.copyWith(users: users, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar usuarios: ${e.toString()}',
      );
    }
  }
}

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UsersNotifier(apiClient);
});
