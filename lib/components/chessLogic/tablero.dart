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
  List<List<Ficha>> tablero = _initTablero(true);
  List<List<bool>> tableroMovimientos = initEmptyMovements();
  List<State> casillas = [];
  bool whiteTurn = true;
  bool reversedBoard = true;
  bool shiny = true;
  List<int> casillaSeleccionada = [-1, -1];
  factory SharedData() {
    return _singleton;
  }

  SharedData._internal();
}

void resetSingleton(bool reversedBoard, bool shiny) {
  SharedData board = SharedData();
  board.tablero = _initTablero(reversedBoard);
  board.tableroMovimientos = initEmptyMovements();
  board.casillas = [];
  board.whiteTurn = true;
  board.reversedBoard = reversedBoard;
  board.shiny = shiny;
  board.casillaSeleccionada = [-1, -1];
}

List<List<Ficha>> _initTablero(bool reversedBoard) {
  List<List<Ficha>> tab = [];

  var aux = <Ficha>[];
  if (!reversedBoard) {
    tab.add(piezasNegras());
    aux = List.filled(8, Peon(isWhite: false));
    tab.add(aux);
  } else {
    tab.add(piezasBlancas());
    aux = List.filled(8, Peon(isWhite: true));
    tab.add(aux);
  }
  for (int i = 0; i < 4; i++) {
    aux = List.filled(8, Vacia(isWhite: false));
    tab.add(aux);
  }
  if (!reversedBoard) {
    aux = List.filled(8, Peon(isWhite: true));
    tab.add(aux);
    tab.add(piezasBlancas());
  } else {
    aux = List.filled(8, Peon(isWhite: false));
    tab.add(aux);
    tab.add(piezasNegras());
  }
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
  final SharedData board = SharedData();
  int temp = 0;
  for (int i = 0; i < movimientos.length; i++) {
    _validateMovement(movimientos[i], temp, board, movimientosValidos);
  }
  return movimientosValidos;
}

void _validateMovement(List<int> movimiento, int temp, SharedData board,
    List<List<int>> movimientosValidos) {
  if (movimiento[0] >= 0 &&
      movimiento[0] < 8 &&
      movimiento[1] >= 0 &&
      movimiento[1] < 8 &&
      (board.tablero[movimiento[0]][movimiento[1]].esVacia() ||
          board.tablero[movimiento[0]][movimiento[1]].color() !=
              board.whiteTurn)) {
    movimientosValidos.add(movimiento);
  }
}
