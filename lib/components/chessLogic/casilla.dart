import 'package:flutter/material.dart';
import '../winner_dialog.dart';
// import 'fichas.dart';
import 'fichas.dart';
import 'tablero.dart';

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
  final SharedData board = SharedData();

  @override
  void initState() {
    super.initState();
    i = widget.index;
    board.casillas.add(this);
    y = i ~/ 8;
    x = i % 8;
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("Build method called for widget with index ${widget.index}");
    return GestureDetector(
      onTap: () {
        _tapped(context);
      },
      child: SizedBox(
        width: 5,
        height: 5,
        child: Container(
          color: _calcularColorCasilla(),
          child: Container(
            decoration: BoxDecoration(
                image: board.tablero[y][x].getImg() != ""
                    ? DecorationImage(
                        image: AssetImage(
                            "images/${board.tablero[y][x].getImg()}.png"),
                        fit: BoxFit.cover)
                    : null),
          ),
        ),
      ),
    );
  }

  /// Se llama al tocar una casilla
  Object _tapped(BuildContext context) {
    if (board.tablero[y][x].isWhite == board.whiteTurn &&
        !board.tableroMovimientos[y][x] &&
        !board.tablero[y][x].esVacia()) {
      var auxY = board.casillaSeleccionada[0];
      var auxX = board.casillaSeleccionada[1];
      board.casillaSeleccionada = [y, x];
      if (auxX != -1) {
        board.casillas[8 * auxY + auxX].setState(() {});
      }

      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (board.tableroMovimientos[i][j]) {
            board.tableroMovimientos[i][j] = false;
            board.casillas[i * 8 + j].setState(() {});
          }
        }
      }
      var posiblesMovimientos = validateMovements(board.tablero[y][x]
          .posiblesMovimientos(x, y, board.tablero, board.reversedBoard));

      posiblesMovimientos.forEach(_processValidMovement);
    } else if ((board.tablero[y][x].esVacia() ||
            board.tablero[y][x].isWhite != board.whiteTurn) &&
        board.tableroMovimientos[y][x]) {
      var auxY = board.casillaSeleccionada[0];
      var auxX = board.casillaSeleccionada[1];
      if (board.tablero[y][x].getValue() == 10000) {
        //Se ha comido el rey => mensaje de fin
        alertaGanador(context, board.whiteTurn);
      }
      if (board.tablero[auxY][auxX] is Rey) {
        (board.tablero[auxY][auxX] as Rey).alreadyMoved = true;
      } else if (board.tablero[auxY][auxX] is Torre) {
        (board.tablero[auxY][auxX] as Torre).alreadyMoved = true;
      }
      //enroque
      if (board.tablero[auxY][auxX] is Rey && (auxX - x).abs() > 1) {
        if (x == 6) {
          board.tablero[y][5] = board.tablero[y][7];
          board.tablero[y][7] = Vacia(isWhite: false);
          board.casillas[y * 8 + 5].setState(() {});
          board.casillas[y * 8 + 7].setState(() {});
        } else if (x == 2) {
          board.tablero[y][3] = board.tablero[y][0];
          board.tablero[y][0] = Vacia(isWhite: false);
          board.casillas[y * 8 + 0].setState(() {});
          board.casillas[y * 8 + 3].setState(() {});
        }
      }
      board.tablero[y][x] = board.tablero[auxY][auxX];
      board.tablero[auxY][auxX] = Vacia(isWhite: false);

      board.casillaSeleccionada = [-1, -1];
      board.casillas[auxY * 8 + auxX].setState(() {});
      board.whiteTurn = !board.whiteTurn;
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (board.tableroMovimientos[i][j]) {
            board.tableroMovimientos[i][j] = false;
            board.casillas[i * 8 + j].setState(() {});
          }
        }
      }
    }
    setState(() {});
    return Container();
  }

  ///Sino el foreach se queja el flutter analyze
  void _processValidMovement(List<int> movimientoValido) {
    board.tableroMovimientos[movimientoValido[0]][movimientoValido[1]] = true;
    board.casillas[movimientoValido[0] * 8 + movimientoValido[1]]
        .setState(() {});
  }

  Color _calcularColorCasilla() {
    Color whiteTile, blackTile;
    if (board.shiny) {
      whiteTile = const Color(0xffeeeed2);
      blackTile = const Color(0xff769656);
    } else {
      whiteTile = const Color(0xffE3C16F);
      blackTile = const Color(0xffB88B4A);
    }
    return board.casillaSeleccionada[0] == y &&
            board.casillaSeleccionada[1] == x
        ? const Color(0xffbaca44)
        : board.tableroMovimientos[y][x]
            ? (!board.tablero[y][x].esVacia() &&
                    board.tablero[y][x].color() != board.whiteTurn)
                ? const Color(0xffFF4D4D)
                : const Color(0xfff2ca5c)
            : (((i % 2 + ((i ~/ 8) % 2)) % 2 == 0) && !board.reversedBoard) ||
                    (((i % 2 + ((i ~/ 8) % 2)) % 2 == 1) && board.reversedBoard)

                /// Formula que determina el color de la casilla
                ? whiteTile
                : blackTile;
  }
}
