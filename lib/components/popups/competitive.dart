import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../../components/communications/socket_io.dart';
import '../buttons/home_play_button.dart';
import '../buttons/home_selection_button.dart';

class Competitive {
  static final SelectionMenu<int> selectTime = SelectionMenu(
    ["3 minutos", "5 minutos", "10 minutos"],
    [180, 300, 600],
    "5 minutos",
  );

  void _handleTapCOMP(BuildContext context) async {
    Arguments arguments = Arguments.forCOMP(selectTime.selectedCorrectValue);
    await startGame(context, "COMP", arguments);
  }

  Object popupCOMP(BuildContext context) async {
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
            playButton(context, "Jugar", () {
              _handleTapCOMP(context);
              popupWAITING(context);
            }),
          ]),
        ),
      ),
    );
  }

  Object popupWAITING(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          contentPadding: EdgeInsets.all(defaultWidth * 0.05),
          content: SizedBox(
            width: defaultWidth * 0.85,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                "Buscando partida...",
                style: TextStyle(
                  fontSize: 19,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: defaultWidth * 0.05),
              SizedBox(
                height: defaultWidth * 0.3,
                child: Image.asset('images/waiting.gif'),
              ),
              SizedBox(height: defaultWidth * 0.05),
              playButton(context, "Cancelar", () => Navigator.pop(context)),
            ]),
          ),
        ),
      ),
    );
  }
}
