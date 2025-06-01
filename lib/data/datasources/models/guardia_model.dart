import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'guardia_model.g.dart';

enum GuardiaStatus {
  @JsonValue('planificada')
  planificada,
  @JsonValue('realizada')
  realizada,
  @JsonValue('pendiente')
  pendiente,
  @JsonValue('cancelada')
  cancelada,
}

@JsonSerializable()
class Guardia {
  final int id;
  final String location;
  @JsonKey(name: 'student_name')
  final String studentName;
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @JsonKey(name: 'end_time')
  final DateTime endTime;
  final GuardiaStatus status;
  final String? observations;

  Guardia({
    required this.id,
    required this.location,
    required this.studentName,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.observations,
  });

  factory Guardia.fromJson(Map<String, dynamic> json) =>
      _$GuardiaFromJson(json);
  Map<String, dynamic> toJson() => _$GuardiaToJson(this);
}

@JsonSerializable()
class CreateGuardiaRequest {
  @JsonKey(name: 'startTime')
  final DateTime startTime;
  @JsonKey(name: 'endTime')
  final DateTime endTime;
  @JsonKey(name: 'usersId')
  final List<String> usersId;

  CreateGuardiaRequest({
    required this.startTime,
    required this.endTime,
    required this.usersId,
  });

  factory CreateGuardiaRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGuardiaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateGuardiaRequestToJson(this);
}
