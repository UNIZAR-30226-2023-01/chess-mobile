/// Contains the board data, checks the valid movements and starts the board.
import 'pieces.dart';
import 'package:flutter/material.dart';

/// Array of the black pieces to setup the board.
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

/// Array of the white pieces to setup the board.
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

/// Array of the black pieces to setup the reversed board.
List<Piece> inversedBlackPieces() {
  return [
    Rook(isWhite: false),
    Knight(isWhite: false),
    Bishop(isWhite: false),
    King(isWhite: false),
    Queen(isWhite: false),
    Bishop(isWhite: false),
    Knight(isWhite: false),
    Rook(isWhite: false)
  ];
}

/// Array of the white pieces to setup the reversed board.
List<Piece> inversedWhitePieces() {
  return [
    Rook(isWhite: true),
    Knight(isWhite: true),
    Bishop(isWhite: true),
    King(isWhite: true),
    Queen(isWhite: true),
    Bishop(isWhite: true),
    Knight(isWhite: true),
    Rook(isWhite: true)
  ];
}

/// Singleton which contains all the ingame info about the pieces and the essential components.
///
/// This singleton contains:
/// - The boards state.
/// - A list of pending movements.
/// - A reference to use the squares and the timers in order to update them.
/// - What color has the current turn.
/// - If the board must be rendered reversed(playing as black) or not.
/// - The last movement done
/// - A few helpers
/// It is a singleton so it is the same instance all along the different components of the app.
class BoardData {
  static final BoardData _singleton = BoardData._internal();
  List<List<Piece>> currentBoard = _initTablero(true);
  List<List<bool>> boardMovements = initEmptyMovements();
  List<State> squares = [];
  List<State> clocks = [];
  bool whiteTurn = true;
  bool reversedBoard = true;
  List<int> selectedSquare = [-1, -1];
  List<List<int>> lastMovement = [
    [-1, -1],
    [-1, -1]
  ];
  String prom = "";
  bool nextMoveIsCheckmate = false;
  bool spectatorMode = false;
  factory BoardData() {
    return _singleton;
  }

  BoardData._internal();
}

/// Function that resets the information of the BoardData singleton.
///
/// It should be used after ending a game in order to clear all the data.
void resetSingleton(bool reversedBoard) {
  BoardData board = BoardData();
  board.currentBoard = _initTablero(reversedBoard);
  board.boardMovements = initEmptyMovements();
  board.squares = [];
  board.clocks = [];
  board.whiteTurn = true;
  board.reversedBoard = reversedBoard;
  board.selectedSquare = [-1, -1];
  board.lastMovement = [
    [-1, -1],
    [-1, -1]
  ];
  board.prom = "";
  board.nextMoveIsCheckmate = false;
  board.spectatorMode = false;
}

/// Function that starts the pieces positions along the board.
///
/// It is used when the BoardData is created.
/// reversedBoard specifies if the current player is playing as black.
/// reversedBoard == True -> Is black.
List<List<Piece>> _initTablero(bool reversedBoard) {
  List<List<Piece>> tab = [];

  var aux = <Piece>[];
  if (!reversedBoard) {
    tab.add(blackPieces());
    aux = List.filled(8, Pawn(isWhite: false));
    tab.add(aux);
  } else {
    tab.add(inversedWhitePieces());
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
    tab.add(inversedBlackPieces());
  }
  return tab;
}

/// Function that starts the movement matrix empty(set as false).
List<List<bool>> initEmptyMovements() {
  List<List<bool>> movements = [];
  for (int i = 0; i < 64; i++) {
    if (i % 8 == 0) movements.add([]);
    movements[i ~/ 8].add(false);
  }
  return movements;
}

/// Function that checks all the movements in a array it only returns the list of valid ones.
List<List<int>> validateMovements(List<List<int>> movements) {
  List<List<int>> validMovements = [];
  final BoardData board = BoardData();
  int temp = 0;
  for (int i = 0; i < movements.length; i++) {
    _validateMovement(movements[i], temp, board, validMovements);
  }
  return validMovements;
}

/// Function that checks if a single movement is valid or not.
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
