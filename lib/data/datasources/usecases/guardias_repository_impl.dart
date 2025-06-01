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
      final guardias = await _apiClient.getGuardias(
        month: month,
        year: year,
        studentId: studentId,
      );
      return Right(guardias);
    } catch (e) {
      return Left(ServerFailure('Error al cargar guardias: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Guardia>> createGuardia(
    CreateGuardiaRequest request,
  ) async {
    try {
      final guardia = await _apiClient.createGuardia(request);
      return Right(guardia);
    } catch (e) {
      return Left(ServerFailure('Error al crear guardia: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Guardia>> updateGuardia(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final guardia = await _apiClient.updateGuardia(id, data);
      return Right(guardia);
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
}
