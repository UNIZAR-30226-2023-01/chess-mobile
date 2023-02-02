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
    y = i ~/ 8;
    x = i % 8;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build method called for widget with index ${widget.index}");
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
                  ? const Color(0xffbaca44)
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
    if (sharedData.tablero[y][x].isWhite == sharedData.whiteTurn) {
      sharedData.casillaSeleccionada = [y, x];
      sharedData.whiteTurn = !sharedData.whiteTurn;
      var posiblesMovimientos =
          validateMovements(sharedData.tablero[y][x].posiblesMovimientos(x, y));

      // print(sharedData.tableroMovimientos);
      posiblesMovimientos.forEach((movimientoValido) {
        sharedData.tableroMovimientos[movimientoValido[0]]
            [movimientoValido[1]] = true;
      });
      sharedData.tableroMovimientos.forEach((filaMov) {
        print(filaMov);
      });
    }

    setState(() {});
  }
}
