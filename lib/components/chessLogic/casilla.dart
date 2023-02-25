import 'package:ajedrez/components/profile_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../popups/winner_dialog.dart';

import 'fichas.dart';
import 'tablero.dart';
import '../popups/promotion.dart';

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
  final BoardData board = BoardData();
  final UserData userData = UserData();
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
      onTap: () async {
        await _tapped(context);
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
  Future<Object> _tapped(BuildContext context) async {
    if (board.tablero[y][x].isWhite == board.whiteTurn &&
        !board.tableroMovimientos[y][x] &&
        !board.tablero[y][x].esVacia()) {
      var auxY = board.casillaSeleccionada[0];
      var auxX = board.casillaSeleccionada[1];
      board.casillaSeleccionada = [y, x];

      if (auxX != -1) {
        board.casillas[8 * auxY + auxX].setState(() {});
      }

      _actualizarCasillas();
      var posiblesMovimientos = validateMovements(board.tablero[y][x]
          .posiblesMovimientos(x, y, board.tablero, board.reversedBoard,
              board.ultimoMovimiento));
      List<List<int>> movimientosPermitidos = [];
      for (int i = 0; i < posiblesMovimientos.length; i++) {
        if (_processIfSolvesCheckMate(posiblesMovimientos[i])) {
          movimientosPermitidos.add(posiblesMovimientos[i]);
        }
      }

      movimientosPermitidos.forEach(_processValidMovement);
    } else if ((board.tablero[y][x].esVacia() ||
            board.tablero[y][x].isWhite != board.whiteTurn) &&
        board.tableroMovimientos[y][x]) {
      final player = AudioPlayer();
      player.play(AssetSource("sounds/movePiece.mp3"));

      var auxY = board.casillaSeleccionada[0];
      var auxX = board.casillaSeleccionada[1];

      if (board.tablero[y][x] is Rey) {
        //Se ha comido el rey => mensaje de fin
        alertaGanador(context, board.whiteTurn);
      }

      //enroque
      _procesarEnroque(auxY, auxX);
      _procesarComerAlPaso(auxY, auxX);
      board.ultimoMovimiento = [
        [auxY, auxX],
        [y, x]
      ];
      board.tablero[y][x] = board.tablero[auxY][auxX];
      board.tablero[auxY][auxX] = Vacia(isWhite: false);
      _procesarPromocion();

      board.casillaSeleccionada = [-1, -1];
      board.casillas[auxY * 8 + auxX].setState(() {});
      board.whiteTurn = !board.whiteTurn;
      _actualizarCasillas();

      // _checkIfWin();
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

  bool _processIfSolvesCheckMate(List<int> movimiento) {
    //hace el posible movimiento
    Ficha tmp;
    List<List<int>> tmpLastBoardMove;
    tmp = board.tablero[movimiento[0]][movimiento[1]];
    board.tablero[movimiento[0]][movimiento[1]] = board.tablero[y][x];
    board.tablero[y][x] = Vacia(isWhite: false);
    board.whiteTurn = !board.whiteTurn;
    bool solvesCheckMate = true;
    int yRey = -1, xRey = -1;
    var movimientos = [];
    tmpLastBoardMove = board.ultimoMovimiento;
    board.ultimoMovimiento = [
      [y, x],
      [movimiento[0], movimiento[1]]
    ];
    //analiza todos los posibles movimientos de respuesta a este
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board.tablero[i][j] is Rey &&
            board.tablero[i][j].color() == !board.whiteTurn) {
          yRey = i;
          xRey = j;
        } else if (!board.tablero[i][j].esVacia() &&
            board.tablero[i][j].color() == board.whiteTurn) {
          var tmpMovements = validateMovements(board.tablero[i][j]
              .posiblesMovimientos(j, i, board.tablero, board.reversedBoard,
                  board.ultimoMovimiento));

          for (int k = 0; k < tmpMovements.length; k++) {
            movimientos.add(tmpMovements[k]);
          }
        }
      }
    }
    //comprueba las consecuencias del movimiento hecho
    for (int i = 0; i < movimientos.length; i++) {
      if (movimientos[i][0] == yRey && movimientos[i][1] == xRey) {
        solvesCheckMate = false;
      }
    }
    //lo deshace
    board.ultimoMovimiento = tmpLastBoardMove;
    board.whiteTurn = !board.whiteTurn;
    board.tablero[y][x] = board.tablero[movimiento[0]][movimiento[1]];
    board.tablero[movimiento[0]][movimiento[1]] = tmp;
    return solvesCheckMate;
  }

  Color _calcularColorCasilla() {
    Color whiteTile, blackTile;
    whiteTile = Color(userData.tableroB);
    blackTile = Color(userData.tableroN);
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

  void _procesarEnroque(int auxY, int auxX) {
    if (board.tablero[auxY][auxX] is Rey) {
      (board.tablero[auxY][auxX] as Rey).alreadyMoved = true;
    } else if (board.tablero[auxY][auxX] is Torre) {
      (board.tablero[auxY][auxX] as Torre).alreadyMoved = true;
    }
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
  }

  Future<void> _procesarPromocion() async {
    if (board.tablero[y][x] is Peon && (y == 0 || y == 7)) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset position = box.localToGlobal(Offset.zero);
      PieceOption? selectedPiece;
      while (selectedPiece == null) {
        selectedPiece = await showPieceSelectionDialog(
            context, position, board.tablero[y][x].color());
      }
      switch (selectedPiece) {
        case PieceOption.reina:
          board.tablero[y][x] = Reina(isWhite: board.tablero[y][x].color());
          break;
        case PieceOption.torre:
          board.tablero[y][x] = Torre(isWhite: board.tablero[y][x].color());
          break;
        case PieceOption.alfil:
          board.tablero[y][x] = Alfil(isWhite: board.tablero[y][x].color());
          break;
        case PieceOption.caballo:
          board.tablero[y][x] = Caballo(isWhite: board.tablero[y][x].color());
          break;
      }
      setState(() {});
    }
  }

  void _procesarComerAlPaso(int auxY, int auxX) {
    if ((x - auxX).abs() > 0 &&
        board.tablero[auxY][auxX] is Peon &&
        board.tablero[y][x].esVacia()) {
      board.tablero[auxY][x] = Vacia(isWhite: false);
      board.casillas[auxY * 8 + x].setState(() {});
    }
  }

  void _actualizarCasillas() {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board.tableroMovimientos[i][j]) {
          board.tableroMovimientos[i][j] = false;
          board.casillas[i * 8 + j].setState(() {});
        }
      }
    }
  }

  // void _checkIfWin() {
  //   var movimientosPermitidos = [];
  //   for (int i = 0; i < 8; i++) {
  //     for (int j = 0; j < 8; j++) {
  //       if (!board.tablero[i][j].esVacia() &&
  //           board.tablero[i][j].color() == board.whiteTurn) {
  //         var tmpMovements = validateMovements(board.tablero[i][j]
  //             .posiblesMovimientos(j, i, board.tablero, board.reversedBoard,
  //                 board.ultimoMovimiento));

  //         for (int k = 0; k < tmpMovements.length; k++) {
  //           if (_processIfSolvesCheckMate(tmpMovements[k])) {
  //             movimientosPermitidos.add(tmpMovements[k]);
  //           }
  //         }
  //       }
  //     }
  //   }
  //   if (movimientosPermitidos.isEmpty) {
  //     alertaGanador(context, !board.whiteTurn);
  //   }
  //   //print(movimientosPermitidos.length);
  // }
}
