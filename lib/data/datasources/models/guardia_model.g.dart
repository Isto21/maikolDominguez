// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guardia _$GuardiaFromJson(Map<String, dynamic> json) => Guardia(
  id: (json['id'] as num).toInt(),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  status: $enumDecode(_$GuardiaStatusEnumMap, json['status']),
  guardiasUsuarios: (json['guardiasUsuarios'] as List)
      .map((e) => GuardiaUsuario.fromJson(e as Map<String, dynamic>))
      .toList(),
  incidencias: (json['incidencias'] as List)
      .map((e) => Incident.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GuardiaToJson(Guardia instance) => <String, dynamic>{
  'id': instance.id,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'status': _$GuardiaStatusEnumMap[instance.status]!,
  'guardiasUsuarios': instance.guardiasUsuarios.map((e) => e.toJson()).toList(),
  'incidencias': instance.incidencias.map((e) => e.toJson()).toList(),
};

GuardiaStatus $enumDecode(
  Map<GuardiaStatus, String> map,
  Object? value, {
  bool notFoundOk = false,
}) {
  assert(value != null, 'Enum value must not be null');
  return map.entries
      .singleWhere(
        (e) => e.value == value,
        orElse: () {
          if (notFoundOk) {
            // return GuardiaStatus.values.firstWhere((e) => e.name == value);
          }
          throw Exception('Invalid enum value: $value');
        },
      )
      .key;
}

const _$GuardiaStatusEnumMap = {
  GuardiaStatus.planificada: 'planificada',
  GuardiaStatus.realizada: 'realizada',
  GuardiaStatus.pendiente: 'pendiente',
};

GuardiaStatus $enumEncode(GuardiaStatus e) => e;

CreateGuardiaRequest _$CreateGuardiaRequestFromJson(
  Map<String, dynamic> json,
) => CreateGuardiaRequest.fromJson(json);

Map<String, dynamic> _$CreateGuardiaRequestToJson(
  CreateGuardiaRequest instance,
) => <String, dynamic>{
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'usersId': instance.usersId,
};

UpdateGuardiaRequest _$UpdateGuardiaRequestFromJson(
  Map<String, dynamic> json,
) => UpdateGuardiaRequest(
  status: json['status'] != null
      ? GuardiaStatus.values.firstWhere((e) => e.name == json['status']).name
      : null,
  // startTime: json['startTime'] == null
  //     ? null
  //     : DateTime.parse(json['startTime'] as String),
  // endTime: json['endTime'] == null
  //     ? null
  //     : DateTime.parse(json['endTime'] as String),
);

Map<String, dynamic> _$UpdateGuardiaRequestToJson(
  UpdateGuardiaRequest instance,
) => <String, dynamic>{
  'status': instance.status,
  // 'startTime': instance.startTime?.toIso8601String(),
  // 'endTime': instance.endTime?.toIso8601String(),
};

GuardiaUsuario _$GuardiaUsuarioFromJson(Map<String, dynamic> json) =>
    GuardiaUsuario(
      id: (json['id'] as num).toInt(),
      user: json['usuario'] == null
          ? null
          : User.fromJson(json['usuario'] as Map<String, dynamic>),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$GuardiaUsuarioToJson(GuardiaUsuario instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'status': instance.status,
    };
