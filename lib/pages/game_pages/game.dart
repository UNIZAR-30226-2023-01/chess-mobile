import 'package:ajedrez/components/buttons/ingame/save.dart';
import 'package:ajedrez/components/chessLogic/square.dart';
import 'package:ajedrez/components/chessLogic/timer.dart';
import 'package:ajedrez/components/singletons/profile_data.dart';
import 'package:ajedrez/components/visual/screen_size.dart';

//import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../components/buttons/ingame/draw.dart';
import '../../components/buttons/ingame/surrender.dart';
import '../../components/chessLogic/board.dart';
import '../../components/communications/socket_io.dart';


class Players {
  String dark = "null", light = "null";
  String darkName = "null", lightName = "null";
  String darkImage = "", lightImage = "null";
  int darkElo = 0, lightElo = 0;

  Future<void> assign(String dark, String light) async {
    this.dark = dark;
    this.light = light;
  }

  Future<void> updateDark(String name, String image, int elo) async {
    darkName = name;
    darkImage = image;
    darkElo = elo;
  }

  Future<void> updateLight(String name, String image, int elo) async {
    lightName = name;
    lightImage = image;
    lightElo = elo;
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  @override
  void dispose() {
    super.dispose();
    resetSingleton(Random().nextBool());
    resetSocket();
  }

  late CustomTimer _player1Timer;
  late CustomTimer _player2Timer;

  final int _maxTime = GameSocket().timer;
  BoardData b = BoardData();
  UserData u = UserData();
  @override
  void initState() {
    super.initState();
    GameSocket s = GameSocket();
    _player1Timer = CustomTimer(
      label: s.player1,
      duration: Duration(seconds: _maxTime),
      onTimerEnd: () {
        //Pendiente de implementar
      },
      isWhite: true,
    );
    _player2Timer = CustomTimer(
      label: s.player2,
      duration: Duration(seconds: _maxTime),
      onTimerEnd: () {
        //Pendiente de implementar
      },
      isWhite: false,
    );
    // apiGetGame(s.room, Players()).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // print("gameStart");
    GameSocket s = GameSocket();
    // Players players = Players();
    String idR = s.room;
    listenGame(context);
    resetSingleton(!s.iAmWhite);
    // print(s.type);
    if (s.pendingMovements.isNotEmpty) {
      for (var mov in s.pendingMovements) {
        loadMovement(decodeMovement(mov));
      }
      s.pendingMovements = [];
    }
    BoardData().spectatorMode = s.spectatorMode;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: defaultWidth * 0.075),
              if (s.iAmWhite) ...[
                _player2Timer,
              ] else ...[
                _player1Timer,
              ],
              SizedBox(height: defaultWidth * 0.075),
              Expanded(
                flex: 4,

                /// Devuelve una tabla de 64 elementos ordenados por filas de 8
                child: GridView.builder(
                  itemCount: 64,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (BuildContext context, int index) {
                    /// Cada elemento es una casilla
                    return Square(index: index);
                  },
                ),
              ),
              SizedBox(height: defaultWidth * 0.075),
              if (s.iAmWhite) ...[
                _player1Timer,
              ] else ...[
                _player2Timer,
              ],
              SizedBox(height: defaultWidth * 0.125),
              // SizedBox(height: defaultWidth * 0.15),
              s.type == "COMP" || s.type == "CUSTOM"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        surrenderButton(context),
                        drawButton(context),
                      ],
                    )
                  : Container(),
              s.type == "AI"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        surrenderButton(context),
                      ],
                    )
                  : SizedBox(height: defaultWidth * 0.025),
              SizedBox(height: defaultWidth * 0.0125),
              s.type == "CUSTOM" || (s.type == "AI" && u.id != "")
                  ? saveButton(context)
                  : SizedBox(height: defaultWidth * 0.025),
              SizedBox(height: defaultWidth * 0.025),
              Text(
                "Código de partida: $idR",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 19,
                ),
              ),
              SizedBox(height: defaultWidth * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
