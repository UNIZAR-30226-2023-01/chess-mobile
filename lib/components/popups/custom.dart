import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../visual/screen_size.dart';
import '../../components/communications/socket_io.dart';
import '../buttons/home_play_button.dart';
import '../buttons/home_selection_button.dart';
import '../buttons/home_textfield_button.dart';

class Custom {
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
  final TextEditingController roomController = TextEditingController();

  void _handleTapCREATECUSTOM(BuildContext context) async {
    Arguments arguments = Arguments.forCREATECUSTOM(
        selectTime.selectedCorrectValue,
        selectIncrement.selectedCorrectValue,
        selectColor.selectedCorrectValue);
    await startGame(context, "CREATECUSTOM", arguments);
  }

  void _handleTapWAITCUSTOM(BuildContext context) async {
    Arguments arguments = Arguments();
    await startGame(context, "WAITCUSTOM", arguments);
  }

  void _handleTapJOINCUSTOM(BuildContext context) async {
    Arguments arguments = Arguments.forJOINCUSTOM(roomController.text);
    await startGame(context, "JOINCUSTOM", arguments);
  }

  Object popupCUSTOM(BuildContext context) {
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
            Text(
              "Crea una nueva ...",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            SelectionMenu.rowOption(
                context, "Duración:", selectTime.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            SelectionMenu.rowOption(
                context, "Incremento:", selectIncrement.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            SelectionMenu.rowOption(
                context, "Color:", selectColor.selectionMenu(context)),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Crear", (() {
              () => _handleTapCREATECUSTOM(context);
              Navigator.pop(context);
              popupWAITING(context);
              () => _handleTapWAITCUSTOM(context);
            })),
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
            playButton(context, "Unirse", () => _handleTapJOINCUSTOM(context)),
          ]),
        ),
      ),
    );
  }

  Object popupWAITING(BuildContext context) {
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
              "Código de la partida:",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            GestureDetector(
              onTap: () =>
                  Clipboard.setData(ClipboardData(text: GameSocket().room))
                      .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Código de partida copiado.")));
              }),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: defaultWidth * 0.03,
                  horizontal: defaultWidth * 0.03,
                ),
                width: defaultWidth * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.25,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ), // copied successfully
                child: Row(children: [
                  SizedBox(
                    width: defaultWidth * 0.55,
                    child: Center(
                      child: Text(
                        GameSocket().room,
                        style: TextStyle(
                          fontSize: 19,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.copy),
                ]),
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            SizedBox(
              height: defaultWidth * 0.3,
              child: Image.asset('images/waiting.gif'),
            ),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Cancelar", () => null),
          ]),
        ),
      ),
    );
  }

  Object popupANONYMOUS(BuildContext context) {
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
            Text(
              "Únete a otra partida privada",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            textField(context, roomController),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Unirse", () => _handleTapJOINCUSTOM(context)),
          ]),
        ),
      ),
    );
  }
}
