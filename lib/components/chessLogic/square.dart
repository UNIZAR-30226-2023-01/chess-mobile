import 'package:ajedrez/components/profile_data.dart';
import 'package:ajedrez/components/communications/socket_io.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../popups/winner_dialog.dart';

import 'pieces.dart';
import 'board.dart';
import '../popups/promotion.dart';

class Square extends StatefulWidget {
  final int index;
  const Square({super.key, required this.index});
  @override
  State<Square> createState() => SquareState();
}

class SquareState extends State<Square> {
  /// Contiene el índice de la casilla(0-63)
  int i = 0;
  int x = 0;
  int y = 0;
  final BoardData board = BoardData();
  final GameSocket s = GameSocket();
  final UserData userData = UserData();
  @override
  void initState() {
    super.initState();
    i = widget.index;
    board.squares.add(this);
    y = i ~/ 8;
    x = i % 8;
  }

  void actualizarEstado() {
    setState(() {});
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
          color: _calculateSquareColor(),
          child: Container(
            decoration: BoxDecoration(
                image: board.currentBoard[y][x].getImg() != ""
                    ? DecorationImage(
                        image: AssetImage(
                            "images/${board.currentBoard[y][x].getImg()}.png"),
                        fit: BoxFit.cover)
                    : null),
          ),
        ),
      ),
    );
  }

  /// Se llama al tocar una casilla
  Future<Object> _tapped(BuildContext context) async {
    if (board.whiteTurn == s.iAmWhite &&
        board.currentBoard[y][x].isWhite == board.whiteTurn &&
        !board.boardMovements[y][x] &&
        !board.currentBoard[y][x].isEmpty()) {
      var auxY = board.selectedSquare[0];
      var auxX = board.selectedSquare[1];
      board.selectedSquare = [y, x];

      if (auxX != -1) {
        board.squares[8 * auxY + auxX].setState(() {});
      }

      updateSquares();
      var possibleMovements = validateMovements(board.currentBoard[y][x]
          .possibleMovements(x, y, board.currentBoard, board.reversedBoard,
              board.lastMovement));
      List<List<int>> allowedMovements = [];
      for (int i = 0; i < possibleMovements.length; i++) {
        if (_processIfSolvesCheckMate(possibleMovements[i])) {
          allowedMovements.add(possibleMovements[i]);
        }
      }

      allowedMovements.forEach(_processValidMovement);
    } else if (board.whiteTurn == s.iAmWhite &&
        (board.currentBoard[y][x].isEmpty() ||
            board.currentBoard[y][x].isWhite != board.whiteTurn) &&
        board.boardMovements[y][x]) {
      final musicPlayer = AudioPlayer();
      if (board.currentBoard[y][x].isEmpty()) {
        musicPlayer.play(AssetSource("sounds/movePiece.mp3"));
      } else {
        musicPlayer.play(AssetSource("sounds/capturePiece.mp3"));
      }

      var auxY = board.selectedSquare[0];
      var auxX = board.selectedSquare[1];

      if (board.currentBoard[y][x] is King) {
        //Se ha comido el rey => mensaje de fin
        alertWinner(context, board.whiteTurn);
      }

      //enroque
      _processCastling(auxY, auxX);
      _procesarComerAlPaso(auxY, auxX);
      board.lastMovement = [
        [auxY, auxX],
        [y, x]
      ];
      board.currentBoard[y][x] = board.currentBoard[auxY][auxX];
      board.currentBoard[auxY][auxX] = Empty(isWhite: false);
      _processPromotion();
      var jugada = _encodeMovement(auxX, auxY);
      // print(jugada);
      var movimiento = {"move": jugada};
      s.socket.emit('move', movimiento);
      board.selectedSquare = [-1, -1];
      board.squares[auxY * 8 + auxX].setState(() {});
      board.whiteTurn = !board.whiteTurn;
      updateSquares();

      _checkIfWin();
    }
    setState(() {});
    return Container();
  }

  ///Sino el foreach se queja el flutter analyze
  void _processValidMovement(List<int> movimientoValido) {
    board.boardMovements[movimientoValido[0]][movimientoValido[1]] = true;
    board.squares[movimientoValido[0] * 8 + movimientoValido[1]]
        .setState(() {});
  }

  bool _processIfSolvesCheckMate(List<int> movimiento) {
    //hace el posible movimiento
    Piece tmp;
    List<List<int>> tmpLastBoardMove;
    tmp = board.currentBoard[movimiento[0]][movimiento[1]];
    board.currentBoard[movimiento[0]][movimiento[1]] = board.currentBoard[y][x];
    board.currentBoard[y][x] = Empty(isWhite: false);
    board.whiteTurn = !board.whiteTurn;
    bool solvesCheckMate = true;
    int yRey = -1, xRey = -1;
    var movements = [];
    tmpLastBoardMove = board.lastMovement;
    board.lastMovement = [
      [y, x],
      [movimiento[0], movimiento[1]]
    ];
    //analiza todos los posibles movements de respuesta a este
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board.currentBoard[i][j] is King &&
            board.currentBoard[i][j].color() == !board.whiteTurn) {
          yRey = i;
          xRey = j;
        } else if (!board.currentBoard[i][j].isEmpty() &&
            board.currentBoard[i][j].color() == board.whiteTurn) {
          var tmpMovements = validateMovements(board.currentBoard[i][j]
              .possibleMovements(j, i, board.currentBoard, board.reversedBoard,
                  board.lastMovement));

          for (int k = 0; k < tmpMovements.length; k++) {
            movements.add(tmpMovements[k]);
          }
        }
      }
    }
    //comprueba las consecuencias del movimiento hecho
    for (int i = 0; i < movements.length; i++) {
      if (movements[i][0] == yRey && movements[i][1] == xRey) {
        solvesCheckMate = false;
      }
    }
    //lo deshace
    board.lastMovement = tmpLastBoardMove;
    board.whiteTurn = !board.whiteTurn;
    board.currentBoard[y][x] = board.currentBoard[movimiento[0]][movimiento[1]];
    board.currentBoard[movimiento[0]][movimiento[1]] = tmp;
    return solvesCheckMate;
  }

  Color _calculateSquareColor() {
    Color whiteTile, blackTile;
    whiteTile = Color(userData.boardTypeB);
    blackTile = Color(userData.boardTypeN);
    return board.selectedSquare[0] == y && board.selectedSquare[1] == x
        ? const Color(0xffbaca44)
        : board.boardMovements[y][x]
            ? (!board.currentBoard[y][x].isEmpty() &&
                    board.currentBoard[y][x].color() != board.whiteTurn)
                ? const Color(0xffFF4D4D)
                : const Color(0xfff2ca5c)
            : (((i % 2 + ((i ~/ 8) % 2)) % 2 == 0) && !board.reversedBoard) ||
                    (((i % 2 + ((i ~/ 8) % 2)) % 2 == 1) && board.reversedBoard)

                /// Formula que determina el color de la casilla
                ? whiteTile
                : blackTile;
  }

  void _processCastling(int auxY, int auxX) {
    if (board.currentBoard[auxY][auxX] is King) {
      (board.currentBoard[auxY][auxX] as King).alreadyMoved = true;
    } else if (board.currentBoard[auxY][auxX] is Rook) {
      (board.currentBoard[auxY][auxX] as Rook).alreadyMoved = true;
    }
    if (board.currentBoard[auxY][auxX] is King && (auxX - x).abs() > 1) {
      if (x == 6) {
        board.currentBoard[y][5] = board.currentBoard[y][7];
        board.currentBoard[y][7] = Empty(isWhite: false);
        board.squares[y * 8 + 5].setState(() {});
        board.squares[y * 8 + 7].setState(() {});
      } else if (x == 2) {
        board.currentBoard[y][3] = board.currentBoard[y][0];
        board.currentBoard[y][0] = Empty(isWhite: false);
        board.squares[y * 8 + 0].setState(() {});
        board.squares[y * 8 + 3].setState(() {});
      }
    }
  }

  Future<void> _processPromotion() async {
    if (board.currentBoard[y][x] is Pawn && (y == 0 || y == 7)) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset position = box.localToGlobal(Offset.zero);
      PieceOption? selectedPiece;
      while (selectedPiece == null) {
        selectedPiece = await showPieceSelectionDialog(
            context, position, board.currentBoard[y][x].color());
      }
      switch (selectedPiece) {
        case PieceOption.reina:
          board.currentBoard[y][x] =
              Queen(isWhite: board.currentBoard[y][x].color());
          break;
        case PieceOption.torre:
          board.currentBoard[y][x] =
              Rook(isWhite: board.currentBoard[y][x].color());
          break;
        case PieceOption.alfil:
          board.currentBoard[y][x] =
              Bishop(isWhite: board.currentBoard[y][x].color());
          break;
        case PieceOption.caballo:
          board.currentBoard[y][x] =
              Knight(isWhite: board.currentBoard[y][x].color());
          break;
      }
      setState(() {});
    }
  }

  void _procesarComerAlPaso(int auxY, int auxX) {
    if ((x - auxX).abs() > 0 &&
        board.currentBoard[auxY][auxX] is Pawn &&
        board.currentBoard[y][x].isEmpty()) {
      board.currentBoard[auxY][x] = Empty(isWhite: false);
      board.squares[auxY * 8 + x].setState(() {});
    }
  }

  void _checkIfWin() {
    var tmpX = x;
    var tmpY = y;
    List<List<int>> allowedMovements = [];
    //Para cada ficha del contrario simulamos sus movements como si la hubiese
    //elegido el en su turno, si al juntar todos los movements obtenidos por la
    //función _processIfSolvesCheckMate hay un total de 0 significa que es jaque mate
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if ((!board.currentBoard[i][j].isEmpty()) &&
            board.currentBoard[i][j].color() == board.whiteTurn) {
          var tmpMovements = validateMovements(board.currentBoard[i][j]
              .possibleMovements(j, i, board.currentBoard, board.reversedBoard,
                  board.lastMovement));
          //asignación temporal para simular que se mueve esa ficha
          y = i;
          x = j;

          for (int k = 0; k < tmpMovements.length; k++) {
            if (_processIfSolvesCheckMate(tmpMovements[k])) {
              allowedMovements.add(tmpMovements[k]);
            }
          }
        }
      }
    }
    x = tmpX;
    y = tmpY;
    //falta el condicional que distingue si es jaque mate o ahogado
    if (allowedMovements.isEmpty) {
      alertWinner(context, !board.whiteTurn);
    }
  }

  void updateSquares() {
    BoardData board = BoardData();
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board.boardMovements[i][j]) {
          board.boardMovements[i][j] = false;
          board.squares[i * 8 + j].setState(() {});
        }
      }
    }
  }

  String _encodeMovement(int prevX, prevY) {
    var jugadas = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    var invertedPrevY = !board.reversedBoard ? 8 - prevY : prevY + 1;
    var invertedY = !board.reversedBoard ? 8 - y : y + 1;
    String jugada = jugadas[prevX] +
        (invertedPrevY).toString() +
        jugadas[x] +
        (invertedY).toString();
    return jugada;
  }
}

List<List<int>> decodeMovement(String jugada) {
  var jugadas = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
  int prevX = jugadas.indexOf(jugada[0]);
  int x = jugadas.indexOf(jugada[2]);
  int prevy = jugada[1].codeUnitAt(0) - '0'.codeUnitAt(0);
  int y = jugada[3].codeUnitAt(0) - '0'.codeUnitAt(0);
  BoardData board = BoardData();
  prevy = board.reversedBoard ? prevy - 1 : 8 - prevy;
  y = board.reversedBoard ? y - 1 : 8 - y;
  return [
    [prevy, prevX],
    [y, x]
  ];
}

void simulateMovement(List<List<int>> movements) {
  BoardData b = BoardData();
  int auxY = movements[0][0];
  int auxX = movements[0][1];
  int y = movements[1][0];
  int x = movements[1][1];
  // print(movements);
  b.lastMovement = movements;
  b.currentBoard[y][x] = b.currentBoard[auxY][auxX];
  b.currentBoard[auxY][auxX] = Empty(isWhite: false);
  b.selectedSquare = [-1, -1];
  (b.squares[auxY * 8 + auxX] as SquareState).actualizarEstado();

  (b.squares[y * 8 + x] as SquareState).actualizarEstado();
  // updateSquares();
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (b.boardMovements[i][j]) {
        b.boardMovements[i][j] = false;
        (b.squares[i * 8 + j] as SquareState).actualizarEstado();
      }
    }
  }

  b.whiteTurn = !b.whiteTurn;
}
