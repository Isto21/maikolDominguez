import 'package:dartz/dartz.dart';
import 'package:maikol_tesis/config/helpers/failures.dart';
import 'package:maikol_tesis/data/datasources/models/incident_model.dart';

abstract class IncidentsRepository {
  Future<Either<Failure, List<Incident>>> getIncidents({
    int? guardiaId,
    bool? resolved,
  });
  Future<Either<Failure, Incident>> createIncident(
    CreateIncidentRequest request,
  );
  Future<Either<Failure, Incident>> updateIncident(
    int id,
    UpdateIncidentRequest request,
  );
  Future<Either<Failure, void>> deleteIncident(int id);
  Future<Either<Failure, Incident>> getIncidentById(int id);
}
