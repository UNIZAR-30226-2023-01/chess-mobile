import 'package:ajedrez/components/chessLogic/square.dart';

///import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../components/buttons/draw_button.dart';
import '../../components/buttons/surrender_button.dart';
import '../../components/chessLogic/board.dart';
import '../../components/communications/socket_io.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void dispose() {
    super.dispose();
    resetSingleton(Random().nextBool());

    ///resetProfileData(Random().nextBool());
  }

  @override
  void initState() {
    super.initState();
    // resetSingleton(Random().nextBool());

    ///resetProfileData(Random().nextBool());
  }

  @override
  Widget build(BuildContext context) {
    GameSocket s = GameSocket();
    String idR = s.room;
    listenGame(context);
    resetSingleton(!s.iAmWhite);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                surrenderButton(context),
                drawButton(context),
              ],
            ),
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
                  }),
            ),
            Text("Game code:$idR", style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
