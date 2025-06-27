// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:maikol_tesis/data/datasources/models/incident_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: 'name')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  final String? email;
  final String? role;
  final String? ci;
  final String? card;
  final String? cardNumber;
  final String? group;
  final String? apto;
  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.ci,
    this.card,
    this.cardNumber,
    this.group,
    this.apto,
  });

  // final String? phone;
  // final String? brigade;
  // final int? year;
  // @JsonKey(name: 'is_active')
  // final bool isActive;
  // @JsonKey(name: 'created_at')
  // final DateTime createdAt;
  // @JsonKey(name: 'updated_at')
  // final DateTime updatedAt;

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;
  @JsonKey(name: 'token_type')
  // final String tokenType;
  // @JsonKey(name: 'expires_in')
  // final int expiresIn;
  final User? user; // Opcional, algunos backends no lo incluyen en login

  LoginResponse({
    required this.token,
    // required this.tokenType,
    // required this.expiresIn,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String? name;
  final String? lastName;
  final String? ci;
  final String? email;
  final String? cardNumber;
  final String? password;
  final String? role;
  final String? apto;
  final String? group;

  RegisterRequest({
    this.name,
    this.lastName,
    this.ci,
    this.email,
    this.cardNumber,
    this.password,
    this.role,
    this.apto,
    this.group,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  final String message;
  final User? user;

  RegisterResponse({required this.message, this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class ActivationRequest {
  final String email;
  final String activationCode;

  ActivationRequest({required this.email, required this.activationCode});

  factory ActivationRequest.fromJson(Map<String, dynamic> json) =>
      _$ActivationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ActivationRequestToJson(this);
}

@JsonSerializable()
class ActivationResponse {
  final String message;
  final String? token;

  ActivationResponse({required this.message, this.token});

  factory ActivationResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActivationResponseToJson(this);
}

@JsonSerializable()
class UpdateUserRequest {
  final String? name;
  final String? lastName;
  final String? email;
  final String? role;
  final String? apto;
  final String? group;
  final String? cardNumber;
  final String? ci;
  final Map<String, dynamic>? activationCode;

  UpdateUserRequest({
    this.name,
    this.lastName,
    this.email,
    this.role,
    this.apto,
    this.group,
    this.cardNumber,
    this.ci,
    this.activationCode,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (name != null) data['name'] = name;
    if (lastName != null) data['lastName'] = lastName;
    if (email != null) data['email'] = email;
    if (role != null) data['role'] = role;
    if (apto != null) data['apto'] = apto;
    if (group != null) data['group'] = group;
    if (cardNumber != null) data['cardNumber'] = cardNumber;
    if (ci != null) data['ci'] = ci;
    if (activationCode != null) data['activationCode'] = activationCode;
    return data;
  }
}
