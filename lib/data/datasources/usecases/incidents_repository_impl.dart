import 'package:dartz/dartz.dart';
import 'package:maikol_tesis/config/helpers/failures.dart';
import 'package:maikol_tesis/data/datasources/models/incident_model.dart';
import 'package:maikol_tesis/data/dio/api_client.dart';
import 'package:maikol_tesis/domain/repositories/remote/incidents_repository.dart';

class IncidentsRepositoryImpl implements IncidentsRepository {
  final ApiClient _apiClient;

  IncidentsRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, List<Incident>>> getIncidents({
    int? guardiaId,
    bool? resolved,
  }) async {
    try {
      final incidents = await _apiClient.getIncidents(
        guardiaId: guardiaId,
        resolved: resolved,
      );
      return Right(incidents);
    } catch (e) {
      return Left(
        ServerFailure('Error al cargar incidencias: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Incident>> createIncident(
    CreateIncidentRequest request,
  ) async {
    try {
      final incident = await _apiClient.createIncident(request);
      return Right(incident);
    } catch (e) {
      return Left(ServerFailure('Error al crear incidencia: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Incident>> updateIncident(
    int id,
    UpdateIncidentRequest request,
  ) async {
    try {
      final incident = await _apiClient.updateIncident(id, request);
      return Right(incident);
    } catch (e) {
      return Left(
        ServerFailure('Error al actualizar incidencia: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncident(int id) async {
    try {
      await _apiClient.deleteIncident(id);
      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure('Error al eliminar incidencia: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Incident>> getIncidentById(int id) async {
    try {
      final incident = await _apiClient.getIncidentById(id);
      return Right(incident);
    } catch (e) {
      return Left(
        ServerFailure('Error al obtener incidencia: ${e.toString()}'),
      );
    }
  }
}
