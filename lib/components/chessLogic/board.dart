import 'pieces.dart';
import 'package:flutter/material.dart';

List<Piece> blackPieces() {
  return [
    Rook(isWhite: false),
    Knight(isWhite: false),
    Bishop(isWhite: false),
    Queen(isWhite: false),
    King(isWhite: false),
    Bishop(isWhite: false),
    Knight(isWhite: false),
    Rook(isWhite: false)
  ];
}

List<Piece> whitePieces() {
  return [
    Rook(isWhite: true),
    Knight(isWhite: true),
    Bishop(isWhite: true),
    Queen(isWhite: true),
    King(isWhite: true),
    Bishop(isWhite: true),
    Knight(isWhite: true),
    Rook(isWhite: true)
  ];
}

class BoardData {
  static final BoardData _singleton = BoardData._internal();
  List<List<Piece>> currentBoard = _initTablero(true);
  List<List<bool>> boardMovements = initEmptyMovements();
  List<State> squares = [];
  bool whiteTurn = true;
  bool reversedBoard = true;
  List<int> selectedSquare = [-1, -1];
  List<List<int>> lastMovement = [
    [-1, -1],
    [-1, -1]
  ];
  bool nextMoveIsCheckmate = false;
  bool spectatorMode = false;
  factory BoardData() {
    return _singleton;
  }

  BoardData._internal();
}

void resetSingleton(bool reversedBoard) {
  BoardData board = BoardData();
  board.currentBoard = _initTablero(reversedBoard);
  board.boardMovements = initEmptyMovements();
  board.squares = [];
  board.whiteTurn = true;
  board.reversedBoard = reversedBoard;
  board.selectedSquare = [-1, -1];
  board.lastMovement = [
    [-1, -1],
    [-1, -1]
  ];
  board.nextMoveIsCheckmate = false;
  board.spectatorMode = false;
}

List<List<Piece>> _initTablero(bool reversedBoard) {
  List<List<Piece>> tab = [];

  var aux = <Piece>[];
  if (!reversedBoard) {
    tab.add(blackPieces());
    aux = List.filled(8, Pawn(isWhite: false));
    tab.add(aux);
  } else {
    tab.add(whitePieces());
    aux = List.filled(8, Pawn(isWhite: true));
    tab.add(aux);
  }
  for (int i = 0; i < 4; i++) {
    aux = List.filled(8, Empty(isWhite: false));
    tab.add(aux);
  }
  if (!reversedBoard) {
    aux = List.filled(8, Pawn(isWhite: true));
    tab.add(aux);
    tab.add(whitePieces());
  } else {
    aux = List.filled(8, Pawn(isWhite: false));
    tab.add(aux);
    tab.add(blackPieces());
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

List<List<int>> validateMovements(List<List<int>> movements) {
  List<List<int>> validMovements = [];
  final BoardData board = BoardData();
  int temp = 0;
  for (int i = 0; i < movements.length; i++) {
    _validateMovement(movements[i], temp, board, validMovements);
  }
  return validMovements;
}

void _validateMovement(List<int> movement, int temp, BoardData board,
    List<List<int>> validMovements) {
  if (movement[0] >= 0 &&
      movement[0] < 8 &&
      movement[1] >= 0 &&
      movement[1] < 8 &&
      (board.currentBoard[movement[0]][movement[1]].isEmpty() ||
          board.currentBoard[movement[0]][movement[1]].color() !=
              board.whiteTurn)) {
    validMovements.add(movement);
  }
}
