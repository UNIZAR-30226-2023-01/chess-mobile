import 'package:flutter/material.dart';
import '../../components/communications/socket_io.dart';
import '../../components/visual/custom_shape.dart';
import '../game_pages/game.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../components/visual/screen_size.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/buttons/home_long_button.dart';
import '../../components/buttons/home_short_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final timeItems = ['3 minutos', '5 minutos', '10 minutos'];
  String timeValue = '3 minutos';

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
                    "Partida competitiva", popupCompetitive),
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
                shortButton(context, false, "Computer.png", "Contra la IA",
                    _handleTapAI),
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

  Object popupCompetitive() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        content: SizedBox(
          height: defaultWidth * 0.5,
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.25,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  iconStyleData: const IconStyleData(iconSize: 0),
                  value: timeValue,
                  isExpanded: true,
                  items: timeItems.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 19,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => timeValue = value ?? ""),
                ),
              ),
            ),
            SizedBox(height: defaultWidth * 0.075),
            TextButton(
              onPressed: _handleTapCOMP,
              child: Container(
                width: defaultWidth * 0.3,
                padding: const EdgeInsets.symmetric(vertical: 12.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(
                  child: Text(
                    "JUGAR",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
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
