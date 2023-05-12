import '../singletons/profile_data.dart';

abstract class Piece {
  final UserData userData = UserData();
  bool isWhite;
  String _img = "";
  int _value = 0;
  Piece({required this.isWhite});

  bool color() {
    return isWhite;
  }

  bool isEmpty() {
    return false;
  }

  int getValue() {
    return _value;
  }

  String getImg() {
    return _img;
  }

  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement);
}

class Empty extends Piece {
  Empty({required super.isWhite}) {
    _value = 0;
    _img = "";
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];
    return movements;
  }

  @override
  bool isEmpty() {
    return true;
  }
}

class Rook extends Piece {
  bool alreadyMoved = false;
  Rook({required super.isWhite}) {
    _value = 5;
    _img = super.isWhite
        ? "${userData.lightPieces}/torreB"
        : "${userData.darkPieces}/torreN";
    alreadyMoved = false;
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];

    for (int i = y + 1; i < 8; i++) {
      if (board[i][x].isEmpty()) {
        movements.add([i, x]);
      } else {
        if (board[i][x].isWhite != isWhite) {
          movements.add([i, x]);
        }
        break;
      }
    }

    for (int i = y - 1; i >= 0; i--) {
      if (board[i][x].isEmpty()) {
        movements.add([i, x]);
      } else {
        if (board[i][x].isWhite != isWhite) {
          movements.add([i, x]);
        }
        break;
      }
    }

    for (int i = x + 1; i < 8; i++) {
      if (board[y][i].isEmpty()) {
        movements.add([y, i]);
      } else {
        if (board[y][i].isWhite != isWhite) {
          movements.add([y, i]);
        }
        break;
      }
    }

    for (int i = x - 1; i >= 0; i--) {
      if (board[y][i].isEmpty()) {
        movements.add([y, i]);
      } else {
        if (board[y][i].isWhite != isWhite) {
          movements.add([y, i]);
        }
        break;
      }
    }

    return movements;
  }
}

class Bishop extends Piece {
  Bishop({required super.isWhite}) {
    _value = 3;
    _img = super.isWhite
        ? "${userData.lightPieces}/alfilB"
        : "${userData.darkPieces}/alfilN";
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y + i < 8) && board[y + i][x + i].isEmpty()) {
        movements.add([y + i, x + i]);
      } else {
        if ((x + i < 8 && y + i < 8) &&
            board[y + i][x + i].isWhite != isWhite) {
          movements.add([y + i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y - i >= 0) && board[y - i][x - i].isEmpty()) {
        movements.add([y - i, x - i]);
      } else {
        if ((x - i >= 0 && y - i >= 0) &&
            board[y - i][x - i].isWhite != isWhite) {
          movements.add([y - i, x - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y - i >= 0) && board[y - i][x + i].isEmpty()) {
        movements.add([y - i, x + i]);
      } else {
        if ((x + i < 8 && y - i >= 0) &&
            board[y - i][x + i].isWhite != isWhite) {
          movements.add([y - i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y + i < 8) && board[y + i][x - i].isEmpty()) {
        movements.add([y + i, x - i]);
      } else {
        if ((x - i >= 0 && y + i < 8) &&
            board[y + i][x - i].isWhite != isWhite) {
          movements.add([y + i, x - i]);
        }
        break;
      }
    }

    return movements;
  }
}

class Knight extends Piece {
  Knight({required super.isWhite}) {
    _value = 3;
    _img = super.isWhite
        ? "${userData.lightPieces}/caballoB"
        : "${userData.darkPieces}/caballoN";
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];

    movements.add([y + 1, x + 2]);
    movements.add([y - 1, x + 2]);
    movements.add([y + 1, x - 2]);
    movements.add([y - 1, x - 2]);
    movements.add([y + 2, x + 1]);
    movements.add([y + 2, x - 1]);
    movements.add([y - 2, x + 1]);
    movements.add([y - 2, x - 1]);

    return movements;
  }
}

class Pawn extends Piece {
  Pawn({required super.isWhite}) {
    _value = 1;

    _img = super.isWhite
        ? "${userData.lightPieces}/peonB"
        : "${userData.darkPieces}/peonN";
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];
    int aux1 = 0, aux2 = 0;
    aux1 = !reversedBoard ? (super.isWhite ? -1 : 1) : (super.isWhite ? 1 : -1);

    if (board[y + aux1][x].isEmpty()) movements.add([y + aux1, x]);
    if (x < 7 &&
        board[y + aux1][x + 1].color() != isWhite &&
        !board[y + aux1][x + 1].isEmpty()) {
      movements.add([y + aux1, x + 1]);
    }
    if (x > 0 &&
        board[y + aux1][x - 1].color() != isWhite &&
        !board[y + aux1][x - 1].isEmpty()) {
      movements.add([y + aux1, x - 1]);
    }
    aux2 = !reversedBoard ? (super.isWhite ? -2 : 2) : (super.isWhite ? 2 : -2);
    if ((!reversedBoard &&
            (super.isWhite && y == 6 || !super.isWhite && y == 1)) ||
        (reversedBoard &&
            (super.isWhite && y == 1 || !super.isWhite && y == 6))) {
      if (board[y + aux2][x].isEmpty() && board[y + aux1][x].isEmpty()) {
        movements.add([y + aux2, x]);
      }
    }
    //comer al paso
    if (lastMovement !=
            [
              [-1, -1],
              [-1, -1]
            ] &&
        (lastMovement[0][0] - lastMovement[1][0]).abs() > 1 &&
        ((x < 7 &&
                lastMovement[0][1] == x + 1 &&
                board[y][x + 1] is Pawn &&
                board[y][x + 1].color() != isWhite) ||
            (x > 0 &&
                lastMovement[0][1] == x - 1 &&
                board[y][x - 1] is Pawn &&
                board[y][x - 1].color() != isWhite))) {
      movements.add([y + aux1, lastMovement[0][1]]);
    }

    return movements;
  }
}

class Queen extends Piece {
  Queen({required super.isWhite}) {
    _value = 10;
    _img = super.isWhite
        ? "${userData.lightPieces}/reinaB"
        : "${userData.darkPieces}/reinaN";
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];

    for (int i = y + 1; i < 8; i++) {
      if (board[i][x].isEmpty()) {
        movements.add([i, x]);
      } else {
        if (board[i][x].isWhite != isWhite) {
          movements.add([i, x]);
        }
        break;
      }
    }

    for (int i = y - 1; i >= 0; i--) {
      if (board[i][x].isEmpty()) {
        movements.add([i, x]);
      } else {
        if (board[i][x].isWhite != isWhite) {
          movements.add([i, x]);
        }
        break;
      }
    }

    for (int i = x + 1; i < 8; i++) {
      if (board[y][i].isEmpty()) {
        movements.add([y, i]);
      } else {
        if (board[y][i].isWhite != isWhite) {
          movements.add([y, i]);
        }
        break;
      }
    }

    for (int i = x - 1; i >= 0; i--) {
      if (board[y][i].isEmpty()) {
        movements.add([y, i]);
      } else {
        if (board[y][i].isWhite != isWhite) {
          movements.add([y, i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y + i < 8) && board[y + i][x + i].isEmpty()) {
        movements.add([y + i, x + i]);
      } else {
        if ((x + i < 8 && y + i < 8) &&
            board[y + i][x + i].isWhite != isWhite) {
          movements.add([y + i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y - i >= 0) && board[y - i][x - i].isEmpty()) {
        movements.add([y - i, x - i]);
      } else {
        if ((x - i >= 0 && y - i >= 0) &&
            board[y - i][x - i].isWhite != isWhite) {
          movements.add([y - i, x - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y - i >= 0) && board[y - i][x + i].isEmpty()) {
        movements.add([y - i, x + i]);
      } else {
        if ((x + i < 8 && y - i >= 0) &&
            board[y - i][x + i].isWhite != isWhite) {
          movements.add([y - i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y + i < 8) && board[y + i][x - i].isEmpty()) {
        movements.add([y + i, x - i]);
      } else {
        if ((x - i >= 0 && y + i < 8) &&
            board[y + i][x - i].isWhite != isWhite) {
          movements.add([y + i, x - i]);
        }
        break;
      }
    }

    return movements;
  }
}

class King extends Piece {
  bool alreadyMoved = false;
  King({required super.isWhite}) {
    _value = 10000;
    _img = super.isWhite
        ? "${userData.lightPieces}/reyB"
        : "${userData.darkPieces}/reyN";
    alreadyMoved = false;
  }

  @override
  List<List<int>> possibleMovements(int x, int y, List<List<Piece>> board,
      bool reversedBoard, List<List<int>> lastMovement) {
    List<List<int>> movements = [];

    movements.add([y - 1, x - 1]);
    movements.add([y, x - 1]);
    movements.add([y + 1, x - 1]);
    movements.add([y - 1, x]);
    movements.add([y + 1, x]);
    movements.add([y - 1, x + 1]);
    movements.add([y, x + 1]);
    movements.add([y + 1, x + 1]);

    if ((x + 3) < 8 &&
        board[y][x + 3] is Rook &&
        board[y][x + 2] is Empty &&
        board[y][x + 1] is Empty &&
        board[y][x] is King &&
        !(board[y][x + 3] as Rook).alreadyMoved &&
        !(board[y][x] as King).alreadyMoved) {
      movements.add([y, x + 2]);
    }
    if ((x - 4) >= 0 &&
        board[y][x - 4] is Rook &&
        board[y][x - 3] is Empty &&
        board[y][x - 2] is Empty &&
        board[y][x - 1] is Empty &&
        board[y][x] is King &&
        !(board[y][x - 4] as Rook).alreadyMoved &&
        !(board[y][x] as King).alreadyMoved) {
      movements.add([y, x - 2]);
    }
    return movements;
  }
}
