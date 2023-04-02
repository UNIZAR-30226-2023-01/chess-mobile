import 'package:flutter/material.dart';
import '../../components/communications/socket_io.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/visual/screen_size.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/buttons/home_long_button.dart';
import '../../components/buttons/home_short_button.dart';
import '../../components/buttons/home_play_button.dart';
import '../../components/buttons/home_selection_button.dart';
import '../../components/buttons/home_textfield_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SelectionMenu<int> selectTime = SelectionMenu(
      ["3 minutos", "5 minutos", "10 minutos"], [180, 300, 600], "5 minutos");
  SelectionMenu<int> selectIncrement = SelectionMenu(
      ["3 segundos", "5 segundos", "10 segundos"], [3, 5, 10], "5 segundos");
  SelectionMenu<String> selectColor = SelectionMenu(
      ["Aleatorio", "Blanco", "Negro"],
      ["RANDOM", "LIGHT", "DARK"],
      "Aleatorio");
  SelectionMenu<int> selectDifficulty = SelectionMenu(
      ["Fácil", "Normal", "Difícil", "Imposible"], [0, 1, 2, 3], "Normal");
  final TextEditingController roomController = TextEditingController();

  void _handleTapAI() async {
    Arguments arguments = Arguments.forAI(
        selectTime.selectedCorrectValue,
        selectIncrement.selectedCorrectValue,
        selectColor.selectedCorrectValue,
        selectDifficulty.selectedCorrectValue);
    await startGame(context, "AI", arguments);
  }

  void _handleTapCOMP() async {
    Arguments arguments = Arguments.forCOMP(selectTime.selectedCorrectValue);
    await startGame(context, "COMP", arguments);
  }

  void _handleTapCREATECUSTOM() async {
    Arguments arguments = Arguments.forCREATECUSTOM(
        selectTime.selectedCorrectValue,
        selectIncrement.selectedCorrectValue,
        selectColor.selectedCorrectValue);
    await startGame(context, "CREATECUSTOM", arguments);
  }

  void _handleTapJOINCUSTOM() async {
    Arguments arguments = Arguments.forJOINCUSTOM(roomController.text);
    await startGame(context, "JOINCUSTOM", arguments);
  }

  void _handleTapSPECTATOR() async {
    Arguments arguments = Arguments.forSPECTATOR(roomController.text);
    await startGame(context, "SPECTATOR", arguments);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(children: [
          header(),
          Expanded(
            child: Center(
              child: ListView(children: [
                SizedBox(height: defaultWidth * 0.05),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  longButton(context, true, "Competitive.png",
                      "Partida competitiva", popupCOMP),
                ]),
                SizedBox(height: defaultWidth * 0.075),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  shortButton(context, false, "Private.png", "Partida privada",
                      popupCUSTOM),
                  SizedBox(width: defaultWidth * 0.075),
                  shortButton(context, false, "Tournaments.png", "Torneo",
                      _handleTapJOINCUSTOM),
                ]),
                SizedBox(height: defaultWidth * 0.075),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  shortButton(
                      context, false, "Computer.png", "Contra la IA", popupAI),
                  SizedBox(width: defaultWidth * 0.075),
                  shortButton(context, false, "Spectator.png", "Espectar juego",
                      popupSPECTATOR),
                ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Stack header() {
    return Stack(children: [
      ClipPath(
        clipper: CustomShape(),
        child: Container(
          height: defaultHeight * 0.35,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      Center(
        child: Padding(
          padding: EdgeInsets.only(top: defaultHeight * 0.0375),
          child: Text(
            "Elige un modo de juego",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: EdgeInsets.only(top: defaultHeight * 0.1),
          child: SizedBox(
            height: defaultHeight * 0.1625,
            child: setImageColor(context, "Logo_app_chess_white.png",
                Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    ]);
  }

  Object popupCOMP() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            popupRowOption("Duración:", selectTime.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Jugar", _handleTapCOMP),
          ]),
        ),
      ),
    );
  }

  Object popupCUSTOM() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Crea una nueva ...",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            popupRowOption("Duración:", selectTime.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            popupRowOption(
                "Incremento:", selectIncrement.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            popupRowOption("Color:", selectColor.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Crear", _handleTapCREATECUSTOM),
            SizedBox(height: defaultWidth * 0.075),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1.25,
                    indent: defaultWidth * 0.05,
                    endIndent: defaultWidth * 0.05,
                  ),
                ),
                Text(
                  " o ",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1.25,
                    indent: defaultWidth * 0.05,
                    endIndent: defaultWidth * 0.05,
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultWidth * 0.075),
            Text(
              "... únete a otra",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            textField(context, roomController),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Unirse", _handleTapJOINCUSTOM),
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
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            popupRowOption("Duración:", selectTime.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            popupRowOption(
                "Incremento:", selectIncrement.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            popupRowOption("Color:", selectColor.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            popupRowOption(
                "Dificultad:", selectDifficulty.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Jugar", _handleTapAI),
          ]),
        ),
      ),
    );
  }

  Object popupSPECTATOR() {
    roomController.text = "";
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            textField(context, roomController),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Espectar", _handleTapSPECTATOR),
          ]),
        ),
      ),
    );
  }

  Row popupRowOption(String text, Widget widget) {
    return Row(children: [
      SizedBox(
        width: defaultWidth * 0.25,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      SizedBox(width: defaultWidth * 0.05),
      widget,
    ]);
  }
}
