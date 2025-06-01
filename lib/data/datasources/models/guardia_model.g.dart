// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guardia _$GuardiaFromJson(Map<String, dynamic> json) => Guardia(
      id: (json['id'] as num).toInt(),
      location: json['location'] as String,
      studentName: json['student_name'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      status: $enumDecode(_$GuardiaStatusEnumMap, json['status']),
      observations: json['observations'] as String?,
    );

Map<String, dynamic> _$GuardiaToJson(Guardia instance) => <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'student_name': instance.studentName,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime.toIso8601String(),
      'status': _$GuardiaStatusEnumMap[instance.status]!,
      'observations': instance.observations,
    };

const _$GuardiaStatusEnumMap = {
  GuardiaStatus.planificada: 'planificada',
  GuardiaStatus.realizada: 'realizada',
  GuardiaStatus.pendiente: 'pendiente',
  GuardiaStatus.cancelada: 'cancelada',
};

CreateGuardiaRequest _$CreateGuardiaRequestFromJson(
        Map<String, dynamic> json) =>
    CreateGuardiaRequest(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      usersId:
          (json['usersId'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateGuardiaRequestToJson(
        CreateGuardiaRequest instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'usersId': instance.usersId,
    };
