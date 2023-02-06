abstract class Ficha {
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

  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero);
}

class Vacia extends Ficha {
  Vacia({required super.isWhite}) {
    _value = 0;
    _img = "";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];
    return movimientos;
  }

  @override
  bool esVacia() {
    return true;
  }
}

class Torre extends Ficha {
  Torre({required super.isWhite}) {
    _value = 5;
    _img = "torre${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];

    for (int i = y + 1; i < 8; i++) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([x, i]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([x, i]);
        }
        break;
      }
    }

    for (int i = y - 1; i >= 0; i--) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([x, i]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([x, i]);
        }
        break;
      }
    }

    for (int i = x + 1; i < 8; i++) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([i, y]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([i, y]);
        }
        break;
      }
    }

    for (int i = x - 1; i >= 0; i--) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([i, y]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([i, y]);
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
    _img = "alfil${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y + i < 8) && tablero[y + i][x + i].esVacia()) {
        movimientos.add([x + i, y + i]);
      } else {
        if ((x + i < 8 && y + i < 8) &&
            tablero[y + i][x + i].isWhite != isWhite) {
          movimientos.add([x + i, y + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y - i >= 0) && tablero[y - i][x - i].esVacia()) {
        movimientos.add([x - i, y - i]);
      } else {
        if ((x - i >= 0 && y - i >= 0) &&
            tablero[y - i][x - i].isWhite != isWhite) {
          movimientos.add([x - i, y - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y - i >= 0) && tablero[y - i][x + i].esVacia()) {
        movimientos.add([x + i, y - i]);
      } else {
        if ((x + i < 8 && y - i >= 0) &&
            tablero[y - i][x + i].isWhite != isWhite) {
          movimientos.add([x + i, y - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y + i < 8) && tablero[y + i][x - i].esVacia()) {
        movimientos.add([x - i, y + i]);
      } else {
        if ((x - i >= 0 && y + i < 8) &&
            tablero[y + i][x - i].isWhite != isWhite) {
          movimientos.add([x - i, y + i]);
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
    _img = "caballo${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];

    movimientos.add([x + 2, y + 1]);
    movimientos.add([x + 2, y - 1]);
    movimientos.add([x - 2, y + 1]);
    movimientos.add([x - 2, y - 1]);
    movimientos.add([x + 1, y + 2]);
    movimientos.add([x - 1, y + 2]);
    movimientos.add([x + 1, y - 2]);
    movimientos.add([x - 1, y - 2]);

    return movimientos;
  }
}

class Peon extends Ficha {
  Peon({required super.isWhite}) {
    _value = 1;
    _img = "peon${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];
    int aux = super.isWhite ? -1 : 1;

    if (tablero[y + aux][x].esVacia()) movimientos.add([x, y + aux]);
    if (x < 7 &&
        tablero[y + aux][x + 1].color() != isWhite &&
        !tablero[y + aux][x + 1].esVacia()) {
      movimientos.add([x + 1, y + aux]);
    }
    if (x > 0 &&
        tablero[y + aux][x - 1].color() != isWhite &&
        !tablero[y + aux][x - 1].esVacia()) {
      movimientos.add([x - 1, y + aux]);
    }
    aux = super.isWhite ? -2 : 2;
    if (super.isWhite && y == 6 || !super.isWhite && y == 1) {
      if (tablero[y + aux][x].esVacia()) movimientos.add([x, y + aux]);
    }
    return movimientos;
  }
}

class Reina extends Ficha {
  Reina({required super.isWhite}) {
    _value = 10;
    _img = "reina${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];

    for (int i = y + 1; i < 8; i++) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([x, i]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([x, i]);
        }
        break;
      }
    }

    for (int i = y - 1; i >= 0; i--) {
      if (tablero[i][x].esVacia()) {
        movimientos.add([x, i]);
      } else {
        if (tablero[i][x].isWhite != isWhite) {
          movimientos.add([x, i]);
        }
        break;
      }
    }

    for (int i = x + 1; i < 8; i++) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([i, y]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([i, y]);
        }
        break;
      }
    }

    for (int i = x - 1; i >= 0; i--) {
      if (tablero[y][i].esVacia()) {
        movimientos.add([i, y]);
      } else {
        if (tablero[y][i].isWhite != isWhite) {
          movimientos.add([i, y]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y + i < 8) && tablero[y + i][x + i].esVacia()) {
        movimientos.add([x + i, y + i]);
      } else {
        if ((x + i < 8 && y + i < 8) &&
            tablero[y + i][x + i].isWhite != isWhite) {
          movimientos.add([x + i, y + i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y - i >= 0) && tablero[y - i][x - i].esVacia()) {
        movimientos.add([x - i, y - i]);
      } else {
        if ((x - i >= 0 && y - i >= 0) &&
            tablero[y - i][x - i].isWhite != isWhite) {
          movimientos.add([x - i, y - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x + i < 8 && y - i >= 0) && tablero[y - i][x + i].esVacia()) {
        movimientos.add([x + i, y - i]);
      } else {
        if ((x + i < 8 && y - i >= 0) &&
            tablero[y - i][x + i].isWhite != isWhite) {
          movimientos.add([x + i, y - i]);
        }
        break;
      }
    }

    for (int i = 1; i < 8; i++) {
      if ((x - i >= 0 && y + i < 8) && tablero[y + i][x - i].esVacia()) {
        movimientos.add([x - i, y + i]);
      } else {
        if ((x - i >= 0 && y + i < 8) &&
            tablero[y + i][x - i].isWhite != isWhite) {
          movimientos.add([x - i, y + i]);
        }
        break;
      }
    }

    return movimientos;
  }
}

class Rey extends Ficha {
  Rey({required super.isWhite}) {
    _value = 10000;
    _img = "rey${super.isWhite ? "B" : "N"}";
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y, List<List<Ficha>> tablero) {
    List<List<int>> movimientos = [];

    movimientos.add([x - 1, y - 1]);
    movimientos.add([x - 1, y]);
    movimientos.add([x - 1, y + 1]);
    movimientos.add([x, y - 1]);
    movimientos.add([x, y + 1]);
    movimientos.add([x + 1, y - 1]);
    movimientos.add([x + 1, y]);
    movimientos.add([x + 1, y + 1]);

    return movimientos;
  }
}
