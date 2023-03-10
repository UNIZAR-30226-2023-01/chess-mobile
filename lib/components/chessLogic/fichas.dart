import '../profile_data.dart';

abstract class Ficha {
  final UserData userData = UserData();
  bool isWhite;
  String _img = "";
  int _value = 0;
  Ficha({required this.isWhite});

  bool color() {
    return isWhite;
  }

  bool esVacia() {
    return false;
  }

  int getValue() {
    return _value;
  }

  String getImg() {
    return _img;
  }

  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento);
}

class Vacia extends Ficha {
  Vacia({required super.isWhite}) {
    _value = 0;
    _img = "";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];
    return movimientos;
  }

  @override
  bool esVacia() {
    return true;
  }
}

class Torre extends Ficha {
  bool alreadyMoved = false;
  Torre({required super.isWhite}) {
    _value = 5;
    _img = "${userData.tipo}/torre${super.isWhite ? "B" : "N"}";
    alreadyMoved = false;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];

    for (int i = y + 1; i < 8; i++) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([i, x]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([i, x]);
        }
        break;
      }
    }

    for (int i = y - 1; i >= 0; i--) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([i, x]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([i, x]);
        }
        break;
      }
    }

    for (int i = x + 1; i < 8; i++) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([y, i]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([y, i]);
        }
        break;
      }
    }

    for (int i = x - 1; i >= 0; i--) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([y, i]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([y, i]);
        }
        break;
      }
    }

    return movimientos;
  }
}

class Alfil extends Ficha {
  Alfil({required super.isWhite}) {
    _value = 3;
    _img = "${userData.tipo}/alfil${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y + i < 8) && tablero[y + i][x + i].esVacia()) {
        movimientos.add([y + i, x + i]);
      } else {
        if ((x + i < 8 && y + i < 8) &&
            tablero[y + i][x + i].isWhite != isWhite) {
          movimientos.add([y + i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y - i >= 0) && tablero[y - i][x - i].esVacia()) {
        movimientos.add([y - i, x - i]);
      } else {
        if ((x - i >= 0 && y - i >= 0) &&
            tablero[y - i][x - i].isWhite != isWhite) {
          movimientos.add([y - i, x - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y - i >= 0) && tablero[y - i][x + i].esVacia()) {
        movimientos.add([y - i, x + i]);
      } else {
        if ((x + i < 8 && y - i >= 0) &&
            tablero[y - i][x + i].isWhite != isWhite) {
          movimientos.add([y - i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y + i < 8) && tablero[y + i][x - i].esVacia()) {
        movimientos.add([y + i, x - i]);
      } else {
        if ((x - i >= 0 && y + i < 8) &&
            tablero[y + i][x - i].isWhite != isWhite) {
          movimientos.add([y + i, x - i]);
        }
        break;
      }
    }

    return movimientos;
  }
}

class Caballo extends Ficha {
  Caballo({required super.isWhite}) {
    _value = 3;
    _img = "${userData.tipo}/caballo${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];

    movimientos.add([y + 1, x + 2]);
    movimientos.add([y - 1, x + 2]);
    movimientos.add([y + 1, x - 2]);
    movimientos.add([y - 1, x - 2]);
    movimientos.add([y + 2, x + 1]);
    movimientos.add([y + 2, x - 1]);
    movimientos.add([y - 2, x + 1]);
    movimientos.add([y - 2, x - 1]);

    return movimientos;
  }
}

class Peon extends Ficha {
  Peon({required super.isWhite}) {
    _value = 1;

    _img = "${userData.tipo}/peon${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];
    int aux1 = 0, aux2 = 0;
    aux1 = !reversedBoard ? (super.isWhite ? -1 : 1) : (super.isWhite ? 1 : -1);

    if (tablero[y + aux1][x].esVacia()) movimientos.add([y + aux1, x]);
    if (x < 7 &&
        tablero[y + aux1][x + 1].color() != isWhite &&
        !tablero[y + aux1][x + 1].esVacia()) {
      movimientos.add([y + aux1, x + 1]);
    }
    if (x > 0 &&
        tablero[y + aux1][x - 1].color() != isWhite &&
        !tablero[y + aux1][x - 1].esVacia()) {
      movimientos.add([y + aux1, x - 1]);
    }
    aux2 = !reversedBoard ? (super.isWhite ? -2 : 2) : (super.isWhite ? 2 : -2);
    if ((!reversedBoard &&
            (super.isWhite && y == 6 || !super.isWhite && y == 1)) ||
        (reversedBoard &&
            (super.isWhite && y == 1 || !super.isWhite && y == 6))) {
      if (tablero[y + aux2][x].esVacia() && tablero[y + aux1][x].esVacia()) {
        movimientos.add([y + aux2, x]);
      }
    }
    //comer al paso
    if (ultimoMovimiento !=
            [
              [-1, -1],
              [-1, -1]
            ] &&
        (ultimoMovimiento[0][0] - ultimoMovimiento[1][0]).abs() > 1 &&
        ((x < 7 &&
                ultimoMovimiento[0][1] == x + 1 &&
                tablero[y][x + 1] is Peon &&
                tablero[y][x + 1].color() != isWhite) ||
            (x > 0 &&
                ultimoMovimiento[0][1] == x - 1 &&
                tablero[y][x - 1] is Peon &&
                tablero[y][x - 1].color() != isWhite))) {
      movimientos.add([y + aux1, ultimoMovimiento[0][1]]);
    }

    return movimientos;
  }
}

class Reina extends Ficha {
  Reina({required super.isWhite}) {
    _value = 10;
    _img = "${userData.tipo}/reina${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];

    for (int i = y + 1; i < 8; i++) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([i, x]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([i, x]);
        }
        break;
      }
    }

    for (int i = y - 1; i >= 0; i--) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([i, x]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([i, x]);
        }
        break;
      }
    }

    for (int i = x + 1; i < 8; i++) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([y, i]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([y, i]);
        }
        break;
      }
    }

    for (int i = x - 1; i >= 0; i--) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([y, i]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([y, i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y + i < 8) && tablero[y + i][x + i].esVacia()) {
        movimientos.add([y + i, x + i]);
      } else {
        if ((x + i < 8 && y + i < 8) &&
            tablero[y + i][x + i].isWhite != isWhite) {
          movimientos.add([y + i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y - i >= 0) && tablero[y - i][x - i].esVacia()) {
        movimientos.add([y - i, x - i]);
      } else {
        if ((x - i >= 0 && y - i >= 0) &&
            tablero[y - i][x - i].isWhite != isWhite) {
          movimientos.add([y - i, x - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y - i >= 0) && tablero[y - i][x + i].esVacia()) {
        movimientos.add([y - i, x + i]);
      } else {
        if ((x + i < 8 && y - i >= 0) &&
            tablero[y - i][x + i].isWhite != isWhite) {
          movimientos.add([y - i, x + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y + i < 8) && tablero[y + i][x - i].esVacia()) {
        movimientos.add([y + i, x - i]);
      } else {
        if ((x - i >= 0 && y + i < 8) &&
            tablero[y + i][x - i].isWhite != isWhite) {
          movimientos.add([y + i, x - i]);
        }
        break;
      }
    }

    return movimientos;
  }
}

class Rey extends Ficha {
  bool alreadyMoved = false;
  Rey({required super.isWhite}) {
    _value = 10000;
    _img = "${userData.tipo}/rey${super.isWhite ? "B" : "N"}";
    alreadyMoved = false;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero,
      bool reversedBoard, List<List<int>> ultimoMovimiento) {
    List<List<int>> movimientos = [];

    movimientos.add([y - 1, x - 1]);
    movimientos.add([y, x - 1]);
    movimientos.add([y + 1, x - 1]);
    movimientos.add([y - 1, x]);
    movimientos.add([y + 1, x]);
    movimientos.add([y - 1, x + 1]);
    movimientos.add([y, x + 1]);
    movimientos.add([y + 1, x + 1]);

    if ((x + 3) < 8 &&
        tablero[y][x + 3] is Torre &&
        tablero[y][x + 2] is Vacia &&
        tablero[y][x + 1] is Vacia &&
        tablero[y][x] is Rey &&
        !(tablero[y][x + 3] as Torre).alreadyMoved &&
        !(tablero[y][x] as Rey).alreadyMoved) {
      movimientos.add([y, x + 2]);
    }
    if ((x - 4) >= 0 &&
        tablero[y][x - 4] is Torre &&
        tablero[y][x - 3] is Vacia &&
        tablero[y][x - 2] is Vacia &&
        tablero[y][x - 1] is Vacia &&
        tablero[y][x] is Rey &&
        !(tablero[y][x - 4] as Torre).alreadyMoved &&
        !(tablero[y][x] as Rey).alreadyMoved) {
      movimientos.add([y, x - 2]);
    }
    return movimientos;
  }
}
