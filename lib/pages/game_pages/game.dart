import 'package:ajedrez/components/chessLogic/casilla.dart';

///import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../components/chessLogic/tablero.dart';

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
    resetSingleton(Random().nextBool());

    ///resetProfileData(Random().nextBool());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 4,

              /// Devuelve una tabla de 64 elementos ordenados por filas de 8
              child: GridView.builder(
                  itemCount: 64,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (BuildContext context, int index) {
                    /// Cada elemento es una casilla
                    return Casilla(index: index);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
