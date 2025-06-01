// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  firstName: json['name'] as String,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  role: json['role'] as String?,
  ci: json['ci'] as String?,
  card: json['card'] as String?,
  cardNumber: json['cardNumber'] as String?,
  group: json['group'] as String?,
  apto: json['apto'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'role': instance.role,
  'ci': instance.ci,
  'card': instance.card,
  'cardNumber': instance.cardNumber,
  'group': instance.group,
  'apto': instance.apto,
};

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(token: json['data']['token'] as String);

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{'token': instance.token, 'token_type': instance.user};

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      password: json['password'] as String,
      apto: json['apto'] as String?,
      group: json['group'] as String?,
      role: json['role'] as String?,
      name: json['name'] as String,
      lastName: json['lastName'] as String,
      ci: json['ci'] as String?,
      email: json['email'] as String?,
      cardNumber: json['cardNumber'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'lastName': instance.lastName,
      'email': instance.email,
      'role': instance.role,
      'ci': instance.ci,
      'name': instance.name,
      'cardNumber': instance.cardNumber,
      'group': instance.group,
      'apto': instance.apto,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      message: json['message'] as String,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{'message': instance.message, 'user': instance.user};

Incident _$IncidentFromJson(Map<String, dynamic> json) => Incident(
  id: (json['id'] as num).toInt(),
  guardiaId: (json['guardia_id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  severity: json['severity'] as String,
  reportedAt: DateTime.parse(json['reported_at'] as String),
  resolved: json['resolved'] as bool,
);

Map<String, dynamic> _$IncidentToJson(Incident instance) => <String, dynamic>{
  'id': instance.id,
  'guardia_id': instance.guardiaId,
  'title': instance.title,
  'description': instance.description,
  'severity': instance.severity,
  'reported_at': instance.reportedAt.toIso8601String(),
  'resolved': instance.resolved,
};
ActivationRequest _$ActivationRequestFromJson(Map<String, dynamic> json) =>
    ActivationRequest(
      email: json['email'] as String,
      activationCode: json['activationCode'] as String,
    );

Map<String, dynamic> _$ActivationRequestToJson(ActivationRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'activationCode': instance.activationCode,
    };

ActivationResponse _$ActivationResponseFromJson(Map<String, dynamic> json) =>
    ActivationResponse(
      message: json['message'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ActivationResponseToJson(ActivationResponse instance) =>
    <String, dynamic>{'message': instance.message, 'token': instance.token};
