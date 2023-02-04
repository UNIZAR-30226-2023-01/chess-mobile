import 'package:flutter/material.dart';
import 'fichas.dart';

class Casilla extends StatefulWidget {
  final int index;
  const Casilla({super.key, required this.index});
  @override
  State<Casilla> createState() => _CasillaState();
}

class _CasillaState extends State<Casilla> {
  /// Contiene el índice de la casilla(0-63)
  int i = 0;
  int x = 0;
  int y = 0;
  final SharedData sharedData = SharedData();

  @override
  void initState() {
    super.initState();
    i = widget.index;
    sharedData.casillas.add(this);
    y = i ~/ 8;
    x = i % 8;
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("Build method called for widget with index ${widget.index}");
    return GestureDetector(
      onTap: () {
        _tapped();
      },
      child: SizedBox(
        width: 5,
        height: 5,
        child: Container(
          color: sharedData.casillaSeleccionada[0] == y &&
                  sharedData.casillaSeleccionada[1] == x
              ? const Color(0xffbaca44)
              : sharedData.tableroMovimientos[y][x]
                  ? const Color(0xfff2ca5c)
                  : ((i % 2 + ((i ~/ 8) % 2)) % 2 == 0)

                      /// Formula que determina el color de la casilla
                      ? const Color(0xffeeeed2)
                      : const Color(0xff769656),
          child: Container(
            decoration: BoxDecoration(
                image: sharedData.tablero[y][x].getImg() != ""
                    ? DecorationImage(
                        image: AssetImage(
                            "lib/images/${sharedData.tablero[y][x].getImg()}.png"),
                        fit: BoxFit.cover)
                    : null),
          ),
        ),
      ),
    );
  }

  /// Se llama al tocar una casilla
  void _tapped() {
    if (sharedData.tablero[y][x].isWhite == sharedData.whiteTurn &&
        !sharedData.tableroMovimientos[y][x]) {
      var auxY = sharedData.casillaSeleccionada[0];
      var auxX = sharedData.casillaSeleccionada[1];
      sharedData.casillaSeleccionada = [y, x];
      if (auxX != -1) {
        sharedData.casillas[8 * auxY + auxX].setState(() {});
      }

      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (sharedData.tableroMovimientos[i][j]) {
            sharedData.tableroMovimientos[i][j] = false;
            sharedData.casillas[i * 8 + j].setState(() {});
          }
        }
      }
      var posiblesMovimientos = validateMovements(sharedData.tablero[y][x]
          .posiblesMovimientos(x, y, sharedData.tablero));

      posiblesMovimientos.forEach(_processValidMovement);
    } else if ((sharedData.tablero[y][x].esVacia() ||
            sharedData.tablero[y][x].isWhite != sharedData.whiteTurn) &&
        sharedData.tableroMovimientos[y][x]) {
      var auxY = sharedData.casillaSeleccionada[0];
      var auxX = sharedData.casillaSeleccionada[1];
      sharedData.tablero[y][x] = sharedData.tablero[auxY][auxX];
      sharedData.tablero[auxY][auxX] = Vacia(isWhite: false);
      sharedData.casillaSeleccionada = [-1, -1];
      sharedData.casillas[auxY * 8 + auxX].setState(() {});
      sharedData.whiteTurn = !sharedData.whiteTurn;
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (sharedData.tableroMovimientos[i][j]) {
            sharedData.tableroMovimientos[i][j] = false;
            sharedData.casillas[i * 8 + j].setState(() {});
          }
        }
      }
    }

    setState(() {});
  }

  ///Sino el foreach se queja el flutter analyze
  void _processValidMovement(List<int> movimientoValido) {
    sharedData.tableroMovimientos[movimientoValido[0]][movimientoValido[1]] =
        true;
    sharedData.casillas[movimientoValido[0] * 8 + movimientoValido[1]]
        .setState(() {});
  }
}
