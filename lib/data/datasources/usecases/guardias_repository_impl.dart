import 'package:dartz/dartz.dart';
import 'package:maikol_tesis/config/helpers/failures.dart';
import 'package:maikol_tesis/data/datasources/models/guardia_model.dart';
import 'package:maikol_tesis/data/dio/api_client.dart';
import 'package:maikol_tesis/domain/repositories/remote/guardias_repository.dart';

class GuardiasRepositoryImpl implements GuardiasRepository {
  final ApiClient _apiClient;

  GuardiasRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, List<Guardia>?>> getGuardias({
    int? month,
    int? year,
    int? studentId,
  }) async {
    try {
      print('🛡️ GuardiasRepositoryImpl - Haciendo petición a /api/guardia');
      final guardias = await _apiClient.getGuardias(
        month: month,
        year: year,
        studentId: studentId,
      );
      print(
        '🛡️ GuardiasRepositoryImpl - Petición exitosa, ${guardias?.length ?? 0} guardias recibidas',
      );
      return Right(guardias);
    } catch (e) {
      print('🛡️ GuardiasRepositoryImpl - Error en petición: $e');
      return Left(ServerFailure('Error al cargar guardias: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> createGuardia(
    CreateGuardiaRequest request,
  ) async {
    try {
      await _apiClient.createGuardia(request);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure('Error al crear guardia: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateGuardia(
    int id,
    UpdateGuardiaRequest request,
  ) async {
    try {
      await _apiClient.updateGuardia(id, request);
      return const Right(true);
    } catch (e) {
      return Left(
        ServerFailure('Error al actualizar guardia: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteGuardia(int id) async {
    try {
      await _apiClient.deleteGuardia(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al eliminar guardia: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> confirmarAsistencia(
    int guardiaId,
    int usuarioId,
  ) async {
    try {
      await _apiClient.confirmarAsistencia(guardiaId, usuarioId);
      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure('Error al confirmar asistencia: ${e.toString()}'),
      );
    }
  }
}
