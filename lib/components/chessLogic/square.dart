import 'dart:async';

import 'package:ajedrez/components/singletons/profile_data.dart';
import 'package:ajedrez/components/communications/socket_io.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../popups/ingame/winner_dialog.dart';

import 'pieces.dart';
import 'board.dart';
import '../popups/ingame/promotion.dart';

/// Base widget of the board squares.
/// 
/// It has a associated index € [0,63].
class Square extends StatefulWidget {
  final int index;
  const Square({super.key, required this.index});
  @override
  State<Square> createState() => SquareState();
}

/// Dynamic state of a single square.
/// 
/// It contains references to the following singleton instances:
/// - BoardData
/// - GameSocket
/// - UserData
/// The build method which displays the piece that is in that position.
/// The _tapped methos is called when the Square is pressed, it has all the relevant logic.
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

  /// Auxiliar method to update a square state from outside.
  void actualizarEstado() {
    setState(() {});
  }

  /// Returns a box which contains the piece image and a button, also displays the background color.
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
                            "images${board.currentBoard[y][x].getImg()}.png"),
                        fit: BoxFit.cover)
                    : null),
          ),
        ),
      ),
    );
  }

  /// Manages all the taps in the current square it has inside all the logic.
  Future<Object> _tapped(BuildContext context) async {
    if (!board.spectatorMode) {

      /// If is our turn and we are selecting one of our pieces and the square is not empty.
      /// 
      /// We mark the selected position for the next tap in other square.
      /// We calculate all the possible movements that start using this piece.
      /// We render all the possible squares new colors.
      /// We check all the movements and discard all which arent valid.
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
      } 
      
      /// If is our turn and the square is among the possible movements of the previously selected one we do the movement.
      /// 
      /// Plays the sound of capture/move.
      /// Sets the previous selected square in aux vars.
      /// Checks if it is a complex movement(castling/promotion).
      /// Moves the piece from the last square to this one and updates both squares.
      /// Encodes the movement and sends it trough the socket.
      else if (board.whiteTurn == s.iAmWhite &&
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
          alertWinner(
              context, board.whiteTurn, "Ha ganado el jugador con las fichas ");
        }

        //enroque
        processCastling(auxY, auxX, y, x);
        procesarComerAlPaso(auxY, auxX,y,x);
        board.lastMovement = [
          [auxY, auxX],
          [y, x]
        ];
        board.currentBoard[y][x] = board.currentBoard[auxY][auxX];
        board.currentBoard[auxY][auxX] = Empty(isWhite: false);
        await _processPromotion();

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
    }
    return Container();
  }

  ///Sino el foreach se queja el flutter analyze
  void _processValidMovement(List<int> movimientoValido) {
    board.boardMovements[movimientoValido[0]][movimientoValido[1]] = true;
    board.squares[movimientoValido[0] * 8 + movimientoValido[1]]
        .setState(() {});
  }

  /// Function that checks if a given movement solves the current checkmate or not.
  /// 
  /// It returns if the movement solves the checkmate.
  /// Inside it simulates all the oponents possible movements after doing this move.
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

  /// Function that returns the expected color of the square depending of its current state.
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
            : (((i % 2 + ((i ~/ 8) % 2)) % 2 == 0))

                /// Formula que determina el color de la casilla
                ? whiteTile
                : blackTile;
  }

  /// Function that shows a popup to choose the kind of piece we want to promote our Pawn.
  /// 
  /// This functions returns the information inside the singleton BoardDato.
  /// Also destroys the pawn and replaces it with the new piece.
  Future<void> _processPromotion() async {
    BoardData b = BoardData();
    Completer completer = Completer<void>();
    b.prom = "";
    if (board.currentBoard[y][x] is Pawn && (y == 0 || y == 7)) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset position = box.localToGlobal(Offset.zero);
      PieceOption? selectedPiece;
      while (selectedPiece == null) {
        selectedPiece =
            await showPieceSelectionDialog(context, position, board.whiteTurn);
      }
      switch (selectedPiece) {
        case PieceOption.reina:
          board.currentBoard[y][x] = Queen(isWhite: board.whiteTurn);
          b.prom = "q";
          break;
        case PieceOption.torre:
          board.currentBoard[y][x] = Rook(isWhite: board.whiteTurn);
          b.prom = "r";
          break;
        case PieceOption.alfil:
          board.currentBoard[y][x] = Bishop(isWhite: board.whiteTurn);
          b.prom = "b";
          break;
        case PieceOption.caballo:
          board.currentBoard[y][x] = Knight(isWhite: board.whiteTurn);
          b.prom = "n";
          break;
      }
      setState(() {});
    }
    completer.complete();
    return completer.future;
  }

  /// Function that checks locally if the game has ended.
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
      alertWinner(
          context, !board.whiteTurn, "Ha ganado el jugador con las fichas ");
    }
  }

  /// Auxiliar function that updates all the squares states.
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

  /// Function that given a movement coords encodes it in standard notation and returns it.
  String _encodeMovement(int prevX, prevY) {
    BoardData b = BoardData();
    var jugadas = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    var invertedPrevY = !board.reversedBoard ? 8 - prevY : prevY + 1;
    var invertedY = !board.reversedBoard ? 8 - y : y + 1;
    var invertedPrevX = !board.reversedBoard ? prevX : 7 - prevX;
    var invertedX = !board.reversedBoard ? x : 7 - x;
    String jugada = jugadas[invertedPrevX] +
        (invertedPrevY).toString() +
        jugadas[invertedX] +
        (invertedY).toString() +
        b.prom;
    b.prom = "";

    return jugada;
  }
}

/// Function that given a string movement decodes it in movement coords.
List<List<int>> decodeMovement(String jugada) {
  var jugadas = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
  int prevx = jugadas.indexOf(jugada[0]);
  int x = jugadas.indexOf(jugada[2]);
  int prevy = jugada[1].codeUnitAt(0) - '0'.codeUnitAt(0);
  int y = jugada[3].codeUnitAt(0) - '0'.codeUnitAt(0);
  BoardData board = BoardData();
  if (jugada.length == 5) {
    board.prom = jugada[4];
  } else {
    board.prom = "";
  }
  prevy = board.reversedBoard ? prevy - 1 : 8 - prevy;
  y = board.reversedBoard ? y - 1 : 8 - y;

  prevx = !board.reversedBoard ? prevx : 7 - prevx;
  x = !board.reversedBoard ? x : 7 - x;
  return [
    [prevy, prevx],
    [y, x]
  ];
}

/// Function that given a movement coords simulates it, is used to simulate opponents moves.
void simulateMovement(List<List<int>> movements) {
  BoardData b = BoardData();
  int auxY = movements[0][0];
  int auxX = movements[0][1];
  int y = movements[1][0];
  int x = movements[1][1];
  processCastling(auxY, auxX, y, x);
  procesarComerAlPaso(auxY, auxX,y,x);
  b.lastMovement = movements;
  final musicPlayer = AudioPlayer();
  if (b.currentBoard[y][x].isEmpty()) {
    musicPlayer.play(AssetSource("sounds/movePiece.mp3"));
  } else {
    musicPlayer.play(AssetSource("sounds/capturePiece.mp3"));
  }
  b.currentBoard[y][x] = b.currentBoard[auxY][auxX];
  if (b.prom != "") {
    switch (b.prom) {
      case "q":
        b.currentBoard[y][x] = Queen(isWhite: b.whiteTurn);
        break;
      case "r":
        b.currentBoard[y][x] = Rook(isWhite: b.whiteTurn);
        break;
      case "b":
        b.currentBoard[y][x] = Bishop(isWhite: b.whiteTurn);
        break;
      case "n":
        b.currentBoard[y][x] = Knight(isWhite: b.whiteTurn);
        break;
    }
  }
  b.prom = "";
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

/// Function that given a movement coords loads it in the current game before showing the game.
/// 
/// Is called before the start to load previous movements.
void loadMovement(List<List<int>> movements) {
  BoardData b = BoardData();
  int auxY = movements[0][0];
  int auxX = movements[0][1];
  int y = movements[1][0];
  int x = movements[1][1];
  processCastling(auxY, auxX, y, x);
  procesarComerAlPaso(auxY, auxX,y,x);
  b.lastMovement = movements;
  b.currentBoard[y][x] = b.currentBoard[auxY][auxX];
  if (b.prom != "") {
    switch (b.prom) {
      case "q":
        b.currentBoard[y][x] = Queen(isWhite: b.whiteTurn);
        break;
      case "r":
        b.currentBoard[y][x] = Rook(isWhite: b.whiteTurn);
        break;
      case "b":
        b.currentBoard[y][x] = Bishop(isWhite: b.whiteTurn);
        break;
      case "n":
        b.currentBoard[y][x] = Knight(isWhite: b.whiteTurn);
        break;
    }
  }
  b.prom = "";
  b.currentBoard[auxY][auxX] = Empty(isWhite: false);
  b.selectedSquare = [-1, -1];
  b.whiteTurn = !b.whiteTurn;
}

/// Function that simulates the castling move.
void processCastling(int auxY, int auxX, int y, int x) {
  BoardData board = BoardData();
  if (board.currentBoard[auxY][auxX] is King) {
    (board.currentBoard[auxY][auxX] as King).alreadyMoved = true;
  } else if (board.currentBoard[auxY][auxX] is Rook) {
    (board.currentBoard[auxY][auxX] as Rook).alreadyMoved = true;
  }
  if (board.currentBoard[auxY][auxX] is King && (auxX - x).abs() > 1) {
    if (x == 6) {
      board.currentBoard[y][5] = board.currentBoard[y][7];
      board.currentBoard[y][7] = Empty(isWhite: false);
      (board.squares[y * 8 + 5] as SquareState).actualizarEstado();
      (board.squares[y * 8 + 7] as SquareState).actualizarEstado();
    } else if (x == 2) {
      board.currentBoard[y][3] = board.currentBoard[y][0];
      board.currentBoard[y][0] = Empty(isWhite: false);
      (board.squares[y * 8 + 0] as SquareState).actualizarEstado();
      (board.squares[y * 8 + 3] as SquareState).actualizarEstado();
    }

    else if (x == 1) {
      board.currentBoard[y][2] = board.currentBoard[y][0];
      board.currentBoard[y][0] = Empty(isWhite: false);
      (board.squares[y * 8 + 0] as SquareState).actualizarEstado();
      (board.squares[y * 8 + 2] as SquareState).actualizarEstado();
    }
    else if (x == 5) {
      board.currentBoard[y][4] = board.currentBoard[y][7];
      board.currentBoard[y][7] = Empty(isWhite: false);
      (board.squares[y * 8 + 4] as SquareState).actualizarEstado();
      (board.squares[y * 8 + 7] as SquareState).actualizarEstado();
    }
  }
}

/// Function that simulates the eat on the fly move.
void procesarComerAlPaso(int auxY, int auxX, int y, int x) {
    BoardData board = BoardData();
    if ((x - auxX).abs() > 0 &&
        board.currentBoard[auxY][auxX] is Pawn &&
        board.currentBoard[y][x].isEmpty()) {
      board.currentBoard[auxY][x] = Empty(isWhite: false);
      (board.squares[auxY * 8 + x] as SquareState).actualizarEstado();
    }
  }