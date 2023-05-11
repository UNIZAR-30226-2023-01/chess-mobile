import 'package:ajedrez/components/communications/socket_io.dart';
import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../buttons/home_play_button.dart';
import '../../components/profile_data.dart';
import '../../components/game_data.dart';

class SavedGames {
  final UserData userData = UserData();

  Object popupSAVEDGAMES(BuildContext context) {
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
          height: defaultHeight * 0.85,
          child: Column(
            children: [
              Text(
                "Partidas guardadas",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: defaultWidth * 0.05),
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 1.25,
                indent: defaultWidth * 0.05,
                endIndent: defaultWidth * 0.05,
              ),
              SizedBox(height: defaultWidth * 0.05),
              Expanded(
                child: ListView(children: [
                  for (GameData element in userData.savedGames)
                    gameBox(context, element),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container gameBox(BuildContext context, GameData gameData) {
    return Container(
      width: defaultWidth * 0.7,
      margin: EdgeInsets.only(bottom: defaultWidth * 0.05),
      padding: EdgeInsets.all(defaultWidth * 0.05),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.25,
          )),
      child: Column(children: [
        Text(
          "Partida creada en:\n${gameData.createdAt}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: defaultWidth * 0.05),
        playButton(
            context, "Restaurar", () => _handleTapRes(gameData.id, context)),
      ]),
    );
  }

  void _handleTapRes(String id, BuildContext context) async {
    await resume(id, context);
  }
}
