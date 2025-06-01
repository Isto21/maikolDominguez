import 'package:json_annotation/json_annotation.dart';

part 'incident_model.g.dart';

@JsonSerializable()
class Incident {
  final int id;
  @JsonKey(name: 'guardiaId')
  final int guardiaId;
  final String title;
  final String description;
  final String severity;
  @JsonKey(name: 'reported_at')
  final DateTime reportedAt;
  final bool resolved;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  Incident({
    required this.id,
    required this.guardiaId,
    required this.title,
    required this.description,
    required this.severity,
    required this.reportedAt,
    required this.resolved,
    this.createdAt,
    this.updatedAt,
  });

  factory Incident.fromJson(Map<String, dynamic> json) =>
      _$IncidentFromJson(json);
  Map<String, dynamic> toJson() => _$IncidentToJson(this);
}

@JsonSerializable()
class CreateIncidentRequest {
  @JsonKey(name: 'guardiaId')
  final int guardiaId;
  // final String title;
  final String description;
  final int userId;
  // final String severity;

  CreateIncidentRequest({
    required this.guardiaId,
    required this.userId,
    // required this.title,
    required this.description,
    // required this.severity,
  });

  factory CreateIncidentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateIncidentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateIncidentRequestToJson(this);
}

@JsonSerializable()
class UpdateIncidentRequest {
  final String? title;
  final String? description;
  final String? severity;
  final bool? resolved;

  UpdateIncidentRequest({
    this.title,
    this.description,
    this.severity,
    this.resolved,
  });

  factory UpdateIncidentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateIncidentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateIncidentRequestToJson(this);
}
