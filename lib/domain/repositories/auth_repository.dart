import 'package:dartz/dartz.dart';
import 'package:maikol_tesis/data/datasources/models/user_model.dart';
import 'package:maikol_tesis/domain/entities/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(String email, String password);
  Future<Either<Failure, bool>> register(RegisterRequest request);
  Future<Either<Failure, bool>> activateAccount(String email, String code);
  Future<Either<Failure, bool>> resendActivationCode(String email);
  Future<Either<Failure, bool>> updateProfile(UpdateUserRequest request);
  Future<Either<Failure, bool>> deleteAccount();
}
