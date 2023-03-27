import 'package:flutter/material.dart';
import '../game_pages/game.dart';
import '../../components/communications/socket_io.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/visual/screen_size.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/buttons/home_long_button.dart';
import '../../components/buttons/home_short_button.dart';
import '../../components/buttons/home_play_button.dart';
import '../../components/buttons/selection_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SelectionMenu selectTime =
      SelectionMenu(["3 minutos", "5 minutos", "10 minutos"], "3 minutos");
  SelectionMenu selectLevel =
      SelectionMenu(["Fácil", "Normal", "Difícil", "Imposible"], "Normal");

  void _handleTapAI() async {
    await startGame(context, "AI");
  }

  void _handleTapCOMP() async {
    await startGame(context, "COMP");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(children: [
        header(),
        Expanded(
          child: Center(
            child: ListView(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                longButton(context, true, "Competitive.png",
                    "Partida competitiva", popupCOMP),
              ]),
              SizedBox(height: defaultWidth * 0.075),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                shortButton(context, false, "Private.png", "Partida privada",
                    temporalPlay),
                SizedBox(width: defaultWidth * 0.075),
                shortButton(
                    context, false, "Tournaments.png", "Torneo", temporalPlay),
              ]),
              SizedBox(height: defaultWidth * 0.075),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                shortButton(
                    context, false, "Computer.png", "Contra la IA", popupAI),
                SizedBox(width: defaultWidth * 0.075),
                shortButton(context, false, "Spectator.png", "Espectar juego",
                    temporalPlay),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }

  SizedBox header() {
    return SizedBox(
      height: defaultHeight * 0.325,
      child: Stack(children: [
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: defaultHeight * 0.275,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Center(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: defaultHeight * 0.025, top: defaultHeight * 0.075),
              child: Text(
                "Elige un modo de juego",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SizedBox(
              height: defaultHeight * 0.15,
              width: defaultHeight * 0.15,
              child: setImageColor(context, "Logo_app_chess_white.png",
                  Theme.of(context).colorScheme.primary),
            ),
          ]),
        ),
      ]),
    );
  }

  Object popupCOMP() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        content: SizedBox(
          height: defaultWidth * 0.45,
          width: defaultWidth * 0.85,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Duración:",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.0375),
            selectTime.selectionMenu(context),
            SizedBox(height: defaultWidth * 0.075),
            playButton(context, _handleTapCOMP),
          ]),
        ),
      ),
    );
  }

  Object popupAI() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        content: SizedBox(
          height: defaultWidth * 0.75,
          width: defaultWidth * 0.85,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Duración:",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.0375),
            selectTime.selectionMenu(context),
            SizedBox(height: defaultWidth * 0.075),
            Text(
              "Dificultad:",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.0375),
            selectLevel.selectionMenu(context),
            SizedBox(height: defaultWidth * 0.075),
            playButton(context, _handleTapAI),
          ]),
        ),
      ),
    );
  }

  Object temporalPlay() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GamePage(),
      ),
    );
  }
}
