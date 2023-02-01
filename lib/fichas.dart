abstract class Ficha {
  bool isWhite;
  int value = 0;
  Ficha({required this.isWhite});

  bool color() {
    return isWhite;
  }

  int getValue() {
    return value;
  }

  List<List<int>> posiblesMovimientos(int x, int y);
}

class Torre extends Ficha {
  Torre({required super.isWhite}) {
    value = 5;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y) {
    List<List<int>> movimientos = [];

    for (int i = 0; i < 8; i++) {
      if (i != x) movimientos.add([i, y]);
      if (i != y) movimientos.add([x, i]);
    }

    return movimientos;
  }
}

class Alfil extends Ficha {
  Alfil({required super.isWhite}) {
    value = 3;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y) {
    List<List<int>> movimientos = [];

    for (int i = 1; i < 8; i++) {
      if (x + i < 8 && y + i < 8) movimientos.add([x + i, y + i]);
      if (x - i > 0 && y - i > 0) movimientos.add([x - i, y - i]);
      if (x + i < 8 && y - i > 0) movimientos.add([x + i, y - i]);
      if (x - i > 0 && y + i < 8) movimientos.add([x - i, y + i]);
    }

    return movimientos;
  }
}

class Caballo extends Ficha {
  Caballo({required super.isWhite}) {
    value = 3;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y) {
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
    value = 1;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y) {
    List<List<int>> movimientos = [];
    int aux = super.isWhite ? -1 : 1;
    movimientos.add([x, y + aux]);
    aux = super.isWhite ? -2 : 2;
    if (super.isWhite && y == 6 || !super.isWhite && y == 1) {
      movimientos.add([x, y + aux]);
    }
    return movimientos;
  }
}

class Reina extends Ficha {
  Reina({required super.isWhite}) {
    value = 10;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y) {
    List<List<int>> movimientos = [];

    for (int i = 0; i < 8; i++) {
      if (i != x) movimientos.add([i, y]);
      if (i != y) movimientos.add([x, i]);
    }
    for (int i = 1; i < 8; i++) {
      if (x + i < 8 && y + i < 8) movimientos.add([x + i, y + i]);
      if (x - i > 0 && y - i > 0) movimientos.add([x - i, y - i]);
      if (x + i < 8 && y - i > 0) movimientos.add([x + i, y - i]);
      if (x - i > 0 && y + i < 8) movimientos.add([x - i, y + i]);
    }

    return movimientos;
  }
}

class Rey extends Ficha {
  Rey({required super.isWhite}) {
    value = 10000;
  }

  @override
  List<List<int>> posiblesMovimientos(int x, int y) {
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
