import 'package:dartz/dartz.dart';
import 'package:maikol_tesis/config/helpers/failures.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(String email, String password);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest request);
  Future<Either<Failure, ActivationResponse>> activateAccount(
    String email,
    String activationCode,
  );
  Future<bool> hasValidToken();
  Future<void> logout();
  Future<void> clearToken();
  Future<Either<Failure, bool>> updateProfile(UpdateUserRequest request);
  Future<Either<Failure, bool>> deleteAccount();
}
