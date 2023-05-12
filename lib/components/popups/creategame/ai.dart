import 'package:flutter/material.dart';
import '../../visual/screen_size.dart';
import '../../communications/socket_io.dart';
import '../../buttons/home/play.dart';
import '../../buttons/home/selection.dart';

class AI {
  static final SelectionMenu<int> selectTime = SelectionMenu(
    ["3 minutos", "5 minutos", "10 minutos"],
    [180, 300, 600],
    "5 minutos",
  );
  static final SelectionMenu<int> selectIncrement = SelectionMenu(
    ["3 segundos", "5 segundos", "10 segundos"],
    [3, 5, 10],
    "5 segundos",
  );
  static final SelectionMenu<String> selectColor = SelectionMenu(
    ["Aleatorio", "Blanco", "Negro"],
    ["RANDOM", "LIGHT", "DARK"],
    "Aleatorio",
  );
  static final SelectionMenu<int> selectDifficulty = SelectionMenu(
    ["Fácil", "Normal", "Difícil", "Imposible"],
    [0, 1, 2, 3],
    "Normal",
  );

  void _handleTapAI(BuildContext context) async {
    Arguments arguments = Arguments.forAI(
        selectTime.selectedCorrectValue,
        selectIncrement.selectedCorrectValue,
        selectColor.selectedCorrectValue,
        selectDifficulty.selectedCorrectValue);
    await startGame(context, "AI", arguments);
  }

  Object popupAI(BuildContext context) {
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
            SelectionMenu.rowOption(
                context, "Duración:", selectTime.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            SelectionMenu.rowOption(
                context, "Incremento:", selectIncrement.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            SelectionMenu.rowOption(
                context, "Color:", selectColor.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            SelectionMenu.rowOption(context, "Dificultad:",
                selectDifficulty.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Jugar", () => _handleTapAI(context)),
          ]),
        ),
      ),
    );
  }
}
