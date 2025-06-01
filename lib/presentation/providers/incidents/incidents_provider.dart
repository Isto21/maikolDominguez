import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maikol_tesis/data/datasources/models/incident_model.dart';
import 'package:maikol_tesis/data/datasources/usecases/incidents_repository_impl.dart';
import 'package:maikol_tesis/data/dio/dio_client.dart';
import 'package:maikol_tesis/domain/repositories/remote/incidents_repository.dart';

final incidentsRepositoryProvider = Provider<IncidentsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return IncidentsRepositoryImpl(apiClient);
});

class IncidentsState {
  final List<Incident> incidents;
  final bool isLoading;
  final String? error;

  const IncidentsState({
    this.incidents = const [],
    this.isLoading = false,
    this.error,
  });

  IncidentsState copyWith({
    List<Incident>? incidents,
    bool? isLoading,
    String? error,
  }) {
    return IncidentsState(
      incidents: incidents ?? this.incidents,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class IncidentsNotifier extends StateNotifier<IncidentsState> {
  final IncidentsRepository _repository;

  IncidentsNotifier(this._repository) : super(const IncidentsState());

  Future<void> loadIncidents({int? guardiaId, bool? resolved}) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getIncidents(
      guardiaId: guardiaId,
      resolved: resolved,
    );

    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.message),
      (incidents) => state = state.copyWith(
        isLoading: false,
        incidents: incidents,
        error: null,
      ),
    );
  }

  Future<bool> createIncident(CreateIncidentRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.createIncident(request);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: "No se pudo crear la incidencia",
        );
        return false;
      },
      (incident) {
        state = state.copyWith(
          isLoading: false,
          incidents: [...state.incidents, incident],
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateIncident(int id, UpdateIncidentRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.updateIncident(id, request);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (updatedIncident) {
        final updatedIncidents = state.incidents.map((incident) {
          return incident.id == id ? updatedIncident : incident;
        }).toList();

        state = state.copyWith(
          isLoading: false,
          incidents: updatedIncidents,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteIncident(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.deleteIncident(id);

    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
      (_) {
        final updatedIncidents = state.incidents
            .where((incident) => incident.id != id)
            .toList();
        state = state.copyWith(
          isLoading: false,
          incidents: updatedIncidents,
          error: null,
        );
        return true;
      },
    );
  }
}

final incidentsProvider =
    StateNotifierProvider<IncidentsNotifier, IncidentsState>((ref) {
      final repository = ref.watch(incidentsRepositoryProvider);
      return IncidentsNotifier(repository);
    });
