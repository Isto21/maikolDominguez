import 'package:json_annotation/json_annotation.dart';

import 'incident_model.dart';
import 'user_model.dart';

part 'guardia_model.g.dart';

enum GuardiaStatus {
  @JsonValue('planificada')
  planificada,
  @JsonValue('realizada')
  realizada,
  @JsonValue('pendiente')
  pendiente,
}

@JsonSerializable()
class GuardiaUsuario {
  final int id;
  final User? user; // Información del usuario si viene incluida
  final bool status;

  GuardiaUsuario({required this.id, this.user, required this.status});
  // Getter para saber si está confirmado
  bool get isConfirmado => status;

  // Getter para saber si está pendiente
  bool get isPendiente => !status;

  factory GuardiaUsuario.fromJson(Map<String, dynamic> json) =>
      _$GuardiaUsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$GuardiaUsuarioToJson(this);
}

@JsonSerializable()
class Guardia {
  final int id;
  final GuardiaStatus status;
  @JsonKey(name: 'startTime')
  final DateTime startTime;
  @JsonKey(name: 'endTime')
  final DateTime endTime;
  final List<Incident> incidencias;
  @JsonKey(name: 'guardiasUsuarios')
  final List<GuardiaUsuario> guardiasUsuarios;

  Guardia({
    required this.id,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.incidencias,
    required this.guardiasUsuarios,
  });

  factory Guardia.fromJson(Map<String, dynamic> json) =>
      _$GuardiaFromJson(json);
  Map<String, dynamic> toJson() => _$GuardiaToJson(this);
  // Getter para obtener los nombres de los usuarios asignados
  String get usuariosAsignados {
    if (guardiasUsuarios.isEmpty) return 'Sin asignar';

    final nombres = guardiasUsuarios
        .where((gu) => gu.user != null)
        .map((gu) => gu.user!.fullName)
        .toList();

    if (nombres.isEmpty) {
      return '${guardiasUsuarios.length} usuario(s) asignado(s)';
    }

    return nombres.join(', ');
  }

  // Getter para obtener usuarios confirmados
  List<GuardiaUsuario> get usuariosConfirmados {
    return guardiasUsuarios.where((gu) => gu.isConfirmado).toList();
  }

  // Getter para obtener usuarios pendientes
  List<GuardiaUsuario> get usuariosPendientes {
    return guardiasUsuarios.where((gu) => gu.isPendiente).toList();
  }

  // Getter para verificar si hay usuarios pendientes
  bool get tieneUsuariosPendientes => usuariosPendientes.isNotEmpty;

  // Getter para contar usuarios confirmados
  int get cantidadConfirmados => usuariosConfirmados.length;

  // Getter para contar usuarios pendientes
  int get cantidadPendientes => usuariosPendientes.length;
  // Getter para obtener el color según el status
  String get statusColor {
    switch (status) {
      case GuardiaStatus.planificada:
        return '#2196F3'; // Azul
      case GuardiaStatus.realizada:
        return '#4CAF50'; // Verde
      case GuardiaStatus.pendiente:
        return '#FF9800'; // Naranja
    }
  }

  // Getter para obtener el texto del status
  String get statusText {
    switch (status) {
      case GuardiaStatus.planificada:
        return 'Planificada';
      case GuardiaStatus.realizada:
        return 'Realizada';
      case GuardiaStatus.pendiente:
        return 'Pendiente';
    }
  }

  // Getter para verificar si tiene incidencias
  bool get tieneIncidencias => incidencias.isNotEmpty;

  // Getter para contar incidencias no resueltas
  int get incidenciasNoResueltas =>
      incidencias.where((i) => i.resolved != true).length;
}

@JsonSerializable()
class CreateGuardiaRequest {
  @JsonKey(name: 'startTime')
  final DateTime startTime;
  @JsonKey(name: 'endTime')
  final DateTime endTime;
  @JsonKey(name: 'usersId')
  final List<int> usersId;

  CreateGuardiaRequest({
    required this.startTime,
    required this.endTime,
    required this.usersId,
  });

  factory CreateGuardiaRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGuardiaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateGuardiaRequestToJson(this);
}

@JsonSerializable()
class UpdateGuardiaRequest {
  final String? status;
  // @JsonKey(name: 'startTime')
  // final DateTime? startTime;
  // @JsonKey(name: 'endTime')
  // final DateTime? endTime;

  UpdateGuardiaRequest({
    this.status,
    //  this.startTime, this.endTime
  });

  factory UpdateGuardiaRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateGuardiaRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateGuardiaRequestToJson(this);
}
