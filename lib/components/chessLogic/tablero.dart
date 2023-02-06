import 'fichas.dart';
import 'package:flutter/material.dart';
List<Ficha> piezasNegras() {
  return [
    Torre(isWhite: false),
    Caballo(isWhite: false),
    Alfil(isWhite: false),
    Reina(isWhite: false),
    Rey(isWhite: false),
    Alfil(isWhite: false),
    Caballo(isWhite: false),
    Torre(isWhite: false)
  ];
}

List<Ficha> piezasBlancas() {
  return [
    Torre(isWhite: true),
    Caballo(isWhite: true),
    Alfil(isWhite: true),
    Reina(isWhite: true),
    Rey(isWhite: true),
    Alfil(isWhite: true),
    Caballo(isWhite: true),
    Torre(isWhite: true)
  ];
}

class SharedData {
  static final SharedData _singleton = SharedData._internal();
  List<List<Ficha>> tablero = _initTablero();
  List<List<bool>> tableroMovimientos = initEmptyMovements();
  List<State> casillas = [];
  bool whiteTurn = true;
  List<int> casillaSeleccionada = [-1, -1];
  factory SharedData() {
    return _singleton;
  }

  SharedData._internal();
}

void resetSingleton() {
  SharedData sharedData = SharedData();
  sharedData.tablero = _initTablero();
  sharedData.tableroMovimientos = initEmptyMovements();
  sharedData.casillas = [];
  sharedData.whiteTurn = true;
  sharedData.casillaSeleccionada = [-1, -1];
}

List<List<Ficha>> _initTablero() {
  List<List<Ficha>> tab = [];
  tab.add(piezasNegras());
  var aux = <Ficha>[];
  aux = List.filled(8, Peon(isWhite: false));
  tab.add(aux);
  for (int i = 0; i < 4; i++) {
    aux = List.filled(8, Vacia(isWhite: false));
    tab.add(aux);
  }
  aux = List.filled(8, Peon(isWhite: true));
  tab.add(aux);
  tab.add(piezasBlancas());
  return tab;
}

List<List<bool>> initEmptyMovements() {
  List<List<bool>> movements = [];
  for (int i = 0; i < 64; i++) {
    if (i % 8 == 0) movements.add([]);
    movements[i ~/ 8].add(false);
  }
  return movements;
}

List<List<int>> validateMovements(List<List<int>> movimientos) {
  List<List<int>> movimientosValidos = [];
  final SharedData sharedData = SharedData();
  int temp = 0;
  for (int i = 0; i < movimientos.length; i++) {
    _validateMovement(movimientos[i], temp, sharedData, movimientosValidos);
  }
  return movimientosValidos;
}

void _validateMovement(List<int> movimiento, int temp, SharedData sharedData,
    List<List<int>> movimientosValidos) {
  /// Transponemos para que encaje con la definición del tablero(y,x)
  temp = movimiento[0];
  movimiento[0] = movimiento[1];
  movimiento[1] = temp;
  if (movimiento[0] >= 0 &&
      movimiento[0] < 8 &&
      movimiento[1] >= 0 &&
      movimiento[1] < 8 &&
      (sharedData.tablero[movimiento[0]][movimiento[1]].esVacia() ||
          sharedData.tablero[movimiento[0]][movimiento[1]].color() !=
              sharedData.whiteTurn)) {
    movimientosValidos.add(movimiento);
  }
}