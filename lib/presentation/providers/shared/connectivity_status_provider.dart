import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
  Modo de uso:
    - Instalar las librerías: connectivity_plus, dart_ping
    Nota: existe otra alternativa que pregunta cada 3 segundos
    si hay conexión esté o no conectado consumiendo memoria
    y datos en el proceso.
    En caso de querer probarla: internet_connection_checker_plus

    - En caso de ejecutar de usar este provider en IOS se
    debe instalar y leer la documentación: dart_ping_ios

    - En otro provider obtén el notifier
    final connectivityStatusNotifier = ref.watch(connectivityStatusProvider.notifier);

    - En el constructor del notifier de ese provider puedes usar
    connectivityStatusNotifier.addListener((connectivityStatusState) {
      print("Hay conexión: ${connectivityStatusState.isConnected ? "si" : "no"}");
      if (connectivityStatusState.isConnected) {
        // is connected
      } else {
        // connection lost
      }
    });

    - En cualquier parte del provider puedes saber si hay conexión a internet usando
    connectivityStatusNotifier.currentState.isConnected
    o
    connectivityStatusNotifier.isConnected


    - También saber el tipo de conexión con
    connectivityStatusNotifier.currentState.connectivityResult
    o
    connectivityStatusNotifier.connectivityResult
    Nota: debes entrar a la clase ConnectivityResult para saber el tipo de conexión

    - En el momento que necesites saber la conexión a internet en tiempo real
    se puede usar el siguiente método
    connectivityStatusNotifier.startInLiveChecked();
    Nota: puedes enviar por parámetro el tiempo de espera entre comprobaciones,
    por defecto es 3000 milisegundos

    - Y los siguientes métodos para detenerlo y para saber si está en tiempo real o no
    connectivityStatusNotifier.stopInLiveChecked();
    connectivityStatusNotifier.isInLiveChecked;

    - Usar el siguiente método para modificar el tiempo de espera entre comprobaciones
    setDelayedTimeInMilliseconds(5000)

    - Para el caso de estar conectado a una red pero no tener internet
    y no quieras habilitar el InLiveChecked puedes usar la siguiente variante
    Future<void> funcionX() async {
      try {
        if (connectivityStatusNotifier.isConnected) {
          // hacer la petición a internet
        }
      } catch (_) {
        // ante cualquier error que dé chequear la conexión
        connectivityStatusNotifier.checkedConnection();
      }
    }
    Nota: En caso de estar conectado a una red pero no tener internet el
    servicio se quedará verificando la conexión periódicamente
*/

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatusState>(
        (ref) {
  return ConnectivityStatusNotifier();
});

class ConnectivityStatusNotifier
    extends StateNotifier<ConnectivityStatusState> {
  ConnectivityStatusNotifier() : super(ConnectivityStatusState()) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  List<ConnectivityResult> _connectivityType = [ConnectivityResult.none];
  bool _canCheckedConnection = true;
  bool _keepAlive = false;
  int _delayedMilliseconds = -1;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool get isConnected => state.isConnected;
  bool get isNoConnected => !state.isConnected;
  List<ConnectivityResult> get connectivityType => _connectivityType;

  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> connectivityResult) async {
    if (connectivityResult.first == ConnectivityResult.none) {
      if (state.isConnected) {
        state = state.copyWith(isConnected: false);
      }
    } else {
      final hasConnection = await _isRealConnection();
      if (hasConnection) {
        if (!state.isConnected || _connectivityType != connectivityResult) {
          state = state.copyWith(isConnected: true);
        }
      } else {
        if (state.isConnected || _connectivityType != connectivityResult) {
          state = state.copyWith(isConnected: false);
        }
        checkedConnection();
      }
    }
    _connectivityType = connectivityResult;
  }

  Future<bool> _isRealConnection() async {
    try {
      // final result = await InternetAddress.lookup('google.com');
      final result = await Ping('google.com', count: 1).stream.first;
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (result.response != null) {
        return true;
      }
    } on SocketException catch (_) {}
    return false;
  }

  Future<void> checkedConnection([int delayed = -1]) async {
    if (delayed >= 0) {
      setDelayedTimeInMilliseconds(delayed);
    }
    if (!_canCheckedConnection) return;
    if (kDebugMode) {
      print(
          'checkedConnection: ${state.isConnected ? "isConnected" : "isNotConnected"} $_connectivityType');
    }
    _canCheckedConnection = false;
    List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();
    await _updateConnectionStatus(connectivityResult);
    if ((state.isConnected == false &&
            _connectivityType != ConnectivityResult.none) ||
        _keepAlive) {
      Future.delayed(
          Duration(
              milliseconds:
                  _delayedMilliseconds >= 0 ? _delayedMilliseconds : 3000), () {
        _canCheckedConnection = true;
        checkedConnection();
      });
    } else {
      _canCheckedConnection = true;
    }
  }

  void startInLiveChecked([int delayed = -1]) {
    _keepAlive = true;
    checkedConnection(delayed);
  }

  void stopInLiveChecked() {
    _keepAlive = false;
  }

  bool get isInLiveChecked => _keepAlive;

  void setDelayedTimeInMilliseconds(int delayed) {
    _delayedMilliseconds = delayed;
  }
}

class ConnectivityStatusState {
  final bool isConnected;

  ConnectivityStatusState({this.isConnected = false});

  ConnectivityStatusState copyWith({
    bool? isConnected,
  }) {
    return ConnectivityStatusState(
        isConnected: isConnected ?? this.isConnected);
  }
}
