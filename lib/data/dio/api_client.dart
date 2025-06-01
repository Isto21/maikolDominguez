import 'package:dio/dio.dart';
import 'package:maikol_tesis/data/datasources/models/guardia_model.dart';
import 'package:maikol_tesis/data/datasources/models/incident_model.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart'
    hide Incident;
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Auth endpoints
  @POST('/api/auth/login')
  Future<LoginResponse> login(@Body() Map<String, dynamic> loginData);

  @POST('/api/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @POST('/api/auth/logout')
  Future<void> logout();

  @POST('/api/auth/activate')
  Future<ActivationResponse> activateAccount(@Body() ActivationRequest request);

  @GET('/api/user/me')
  Future<User> getCurrentUser();

  // User endpoints
  @GET('/api/user')
  Future<List<User>> getUsers();

  @GET('/api/user/{id}')
  Future<User> getUserById(@Path('id') int id);

  @PUT('/api/user/{id}')
  Future<User> updateUser(
    @Path('id') int id,
    @Body() Map<String, dynamic> data,
  );

  // Guardia endpoints
  @GET('/api/guardia')
  Future<List<Guardia>?> getGuardias({
    @Query('month') int? month,
    @Query('year') int? year,
    @Query('student_id') int? studentId,
  });

  @POST('/api/guardia')
  Future<Guardia> createGuardia(@Body() CreateGuardiaRequest request);

  @PUT('/api/guardia/{id}')
  Future<Guardia> updateGuardia(
    @Path('id') int id,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/api/guardia/{id}')
  Future<void> deleteGuardia(@Path('id') int id);

  // Incident endpoints
  @GET('/api/incidents')
  Future<List<Incident>> getIncidents({
    @Query('guardia_id') int? guardiaId,
    @Query('resolved') bool? resolved,
  });

  @POST('/api/incidents')
  Future<Incident> createIncident(@Body() CreateIncidentRequest request);

  @PUT('/api/incidents/{id}')
  Future<Incident> updateIncident(
    @Path('id') int id,
    @Body() UpdateIncidentRequest request,
  );

  @DELETE('/api/incidents/{id}')
  Future<void> deleteIncident(@Path('id') int id);

  @GET('/api/incidents/{id}')
  Future<Incident> getIncidentById(@Path('id') int id);
}
