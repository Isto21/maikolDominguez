// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Incident _$IncidentFromJson(Map<String, dynamic> json) => Incident(
  id: (json['id'] as num).toInt(),
  // guardiaId: (json['guardia']['id'] != null)
  //     ? (json['guardia']['id'] as num?)?.toInt()
  //     : null,
  title: json['title'] as String?,
  description: json['description'] as String,
  severity: json['severity'] as String?,
  reportedAt: json['reported_at'] == null
      ? null
      : DateTime.parse(json['reported_at'] as String),
  resolved: json['resolved'] as bool?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$IncidentToJson(Incident instance) => <String, dynamic>{
  'userId': instance.id,
  'guardiaId': instance.guardiaId,
  // 'title': instance.title,
  'description': instance.description,
  // 'severity': instance.severity,
  // 'reported_at': instance.reportedAt.toIso8601String(),
  // 'resolved': instance.resolved,
  // 'created_at': instance.createdAt?.toIso8601String(),
  // 'updated_at': instance.updatedAt?.toIso8601String(),
};

CreateIncidentRequest _$CreateIncidentRequestFromJson(
  Map<String, dynamic> json,
) => CreateIncidentRequest(
  guardiaId: (json['guardiaId'] as num).toInt(),
  // title: json['title'] as String,
  userId: json['userId'] as int,
  description: json['description'] as String,
  // severity: json['severity'] as String,
);

Map<String, dynamic> _$CreateIncidentRequestToJson(
  CreateIncidentRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'guardiaId': instance.guardiaId,
  // 'title': instance.title,
  'description': instance.description,
  // 'severity': instance.severity,
};

UpdateIncidentRequest _$UpdateIncidentRequestFromJson(
  Map<String, dynamic> json,
) => UpdateIncidentRequest(
  title: json['title'] as String?,
  description: json['description'] as String?,
  severity: json['severity'] as String?,
  resolved: json['resolved'] as bool?,
);

Map<String, dynamic> _$UpdateIncidentRequestToJson(
  UpdateIncidentRequest instance,
) => <String, dynamic>{
  // 'title': instance.title,
  'description': instance.description,
  // 'severity': instance.severity,
  // 'resolved': instance.resolved,
};
