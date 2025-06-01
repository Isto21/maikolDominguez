import 'package:dartz/dartz.dart';
import 'package:maikol_tesis/config/helpers/failures.dart';
import 'package:maikol_tesis/data/datasources/models/guardia_model.dart';

abstract class GuardiasRepository {
  Future<Either<Failure, List<Guardia>?>> getGuardias({
    int? month,
    int? year,
    int? studentId,
  });
  Future<Either<Failure, Guardia>> createGuardia(CreateGuardiaRequest request);
  Future<Either<Failure, Guardia>> updateGuardia(
    int id,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, void>> deleteGuardia(int id);
}
