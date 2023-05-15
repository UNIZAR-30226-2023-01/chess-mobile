import 'package:ajedrez/components/data/profile_data.dart';
import 'package:flutter/material.dart';
import '../../pages/menus_pages/manage_tournaments.dart';
import '../communications/socket_io.dart';
import '../visual/screen_size.dart';

PopupMenuButton options(BuildContext context, Widget widget, bool finished,
    bool hasStarted, String id1, String id2, String matchID) {
  UserData userData = UserData();

  void _handleTapTOURNAMENT(BuildContext context) async {
    Arguments arguments = Arguments.forTOURNAMENT(matchID);
    await startGame(context, "TOURNAMENT", arguments);
  }

  void _handleTapSPECTATOR(BuildContext context) async {
    Arguments arguments = Arguments.forSPECTATOR(matchID);
    await startGame(context, "SPECTATOR", arguments);
  }

  return PopupMenuButton(
    color: Theme.of(context).colorScheme.tertiary,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.25,
      ),
    ),
    child: widget,
    onSelected: (value) async {
      ActualSelection.isSelected = false;
      switch (value) {
        case '_jugar':
          _handleTapTOURNAMENT(context);
          popupWAITING(context);
          break;
        case '_observar':
          _handleTapSPECTATOR(context);
          break;
      }
    },
    itemBuilder: (context) {
      return [
        if (hasStarted &&
            !finished &&
            (id1 == userData.id || id2 == userData.id)) ...[
          const PopupMenuItem(
            value: '_jugar',
            child: Text("Jugar partida"),
          ),
        ] else if (hasStarted &&
            !finished &&
            id1 != "null" &&
            id2 != "null") ...[
          const PopupMenuItem(
            value: '_observar',
            child: Text("Observar partida"),
          ),
        ],
      ];
    },
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
              "Esperando jugador...",
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
          ]),
        ),
      ),
    ),
  );
}
