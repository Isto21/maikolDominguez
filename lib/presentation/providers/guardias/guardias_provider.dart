import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maikol_tesis/data/datasources/models/guardia_model.dart';
import 'package:maikol_tesis/data/datasources/usecases/guardias_repository_impl.dart';
import 'package:maikol_tesis/data/dio/dio_client.dart';
import 'package:maikol_tesis/domain/repositories/remote/guardias_repository.dart';

final guardiasRepositoryProvider = Provider<GuardiasRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GuardiasRepositoryImpl(apiClient);
});

class GuardiasState {
  final List<Guardia> guardias;
  final bool isLoading;
  final String? error;

  const GuardiasState({
    this.guardias = const [],
    this.isLoading = false,
    this.error,
  });

  GuardiasState copyWith({
    List<Guardia>? guardias,
    bool? isLoading,
    String? error,
  }) {
    return GuardiasState(
      guardias: guardias ?? this.guardias,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class GuardiasNotifier extends StateNotifier<GuardiasState> {
  final GuardiasRepository _repository;

  GuardiasNotifier(this._repository) : super(const GuardiasState());

  Future<void> loadGuardias({int? month, int? year, int? studentId}) async {
    print('🛡️ GuardiasProvider - Iniciando carga de guardias');
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getGuardias(
      month: month,
      year: year,
      studentId: studentId,
    );

    result.fold(
      (failure) {
        print(
          '🛡️ GuardiasProvider - Error al cargar guardias: ${failure.message}',
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (guardias) {
        print(
          '🛡️ GuardiasProvider - Guardias cargadas exitosamente: ${guardias?.length ?? 0} guardias',
        );
        state = state.copyWith(
          isLoading: false,
          guardias: guardias ?? [],
          error: null,
        );
      },
    );
  }

  Future<bool> createGuardia(CreateGuardiaRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.createGuardia(request);
    await loadGuardias();
    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (guardia) {
        state = state.copyWith(isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<bool> updateGuardia(int id, UpdateGuardiaRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.updateGuardia(id, request);
    await loadGuardias();
    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (updatedGuardia) {
        final updatedGuardias = state.guardias.map((guardia) {
          return guardia.id == id ? updatedGuardia : guardia;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          // guardias: updatedGuardias,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteGuardia(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.deleteGuardia(id);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (_) {
        final updatedGuardias = state.guardias
            .where((guardia) => guardia.id != id)
            .toList();
        state = state.copyWith(
          isLoading: false,
          guardias: updatedGuardias,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> confirmarAsistencia(int guardiaId, int usuarioId) async {
    final result = await _repository.confirmarAsistencia(guardiaId, usuarioId);

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
      (_) {
        // Recargar las guardias para obtener el estado actualizado desde el servidor
        loadGuardias();
        return true;
      },
    );
  }
}

final guardiasProvider = StateNotifierProvider<GuardiasNotifier, GuardiasState>(
  (ref) {
    final repository = ref.watch(guardiasRepositoryProvider);
    return GuardiasNotifier(repository);
  },
);
