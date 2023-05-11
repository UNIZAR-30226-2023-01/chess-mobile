import 'package:flutter/material.dart';
import 'package:ajedrez/components/popups/saved_games.dart';
import 'package:ajedrez/components/popups/played_games.dart';
import '../../components/profile_data.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/visual/customization_constants.dart';
import '../../components/visual/screen_size.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/visual/get_elo.dart';
import '../../components/buttons/profile_boxes.dart';
import '../../components/buttons/profile_options_button.dart';
import '../../components/buttons/profile_short_button.dart';
import '../../components/buttons/profile_theme_button.dart';
import '../../components/communications/api.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserData userData = UserData();
  final SavedGames savedGames = SavedGames();
  final PlayedGames playedGames = PlayedGames();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          header(),
          Expanded(
            child: Center(
              child: ListView(
                children: [
                  divider("Estadísticas"),
                  SizedBox(height: defaultWidth * 0.075),
                  statistics(),
                  SizedBox(height: defaultWidth * 0.075),
                  divider("Logros"),
                  SizedBox(height: defaultWidth * 0.075),
                  achievements(),
                  SizedBox(height: defaultWidth * 0.075),
                  divider("Tema"),
                  SizedBox(height: defaultWidth * 0.075),
                  theme(),
                  SizedBox(height: defaultWidth * 0.075),
                  divider("Actividad"),
                  SizedBox(height: defaultWidth * 0.075),
                  activity(),
                  SizedBox(height: defaultWidth * 0.075),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ValueListenableBuilder header() {
    ValueNotifier<int> counter = ValueNotifier<int>(0);
    return ValueListenableBuilder(
        valueListenable: counter,
        builder: (context, value, child) {
          return SizedBox(
            height: defaultHeight * 0.35,
            child: Stack(children: [
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: defaultHeight * 0.335,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: defaultHeight * 0.04,
                    right: defaultHeight * 0.015,
                  ),
                  child: optionsButton(context, counter),
                ),
              ),
              Center(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: defaultHeight * 0.025,
                        top: defaultHeight * 0.1),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              showElo(userData.elo),
                              Text(
                                userData.username,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultHeight * 0.01),
                          Text(
                            userData.email,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: defaultHeight * 0.14,
                    width: defaultHeight * 0.14,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 4,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/avatars${userData.avatar}"),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          );
        });
  }

  Column statistics() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        statisticBox(context, "Puntuación", userData.elo.toString()),
        SizedBox(width: defaultWidth * 0.075),
        statisticBox(context, "Rango", "#${userData.rank.toString()}"),
      ]),
      SizedBox(height: defaultWidth * 0.075),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        statisticBox(context, "Ratio de victorias",
            "${userData.winRate.toStringAsFixed(2)}%"),
        SizedBox(width: defaultWidth * 0.075),
        statisticBox(context, "Ratio de logros",
            "${userData.achievementRate.toStringAsFixed(2)}%"),
      ]),
    ]);
  }

  Column achievements() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        achievementBox(1),
        SizedBox(width: defaultWidth * 0.05),
        achievementBox(2),
        SizedBox(width: defaultWidth * 0.05),
        achievementBox(3),
        SizedBox(width: defaultWidth * 0.05),
        achievementBox(4),
      ]),
      SizedBox(height: defaultWidth * 0.05),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        achievementBox(5),
        SizedBox(width: defaultWidth * 0.05),
        achievementBox(6),
        SizedBox(width: defaultWidth * 0.05),
        achievementBox(7),
        SizedBox(width: defaultWidth * 0.05),
        achievementBox(8),
      ]),
    ]);
  }

  Column theme() {
    ValueNotifier<int> counter = ValueNotifier<int>(0);
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultWidth * 0.075),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          boardTheme(counter),
          SizedBox(width: defaultWidth * 0.075),
          Column(children: [
            buttonTheme(context, counter, 0, "Tablero", boardTypes),
            SizedBox(height: defaultWidth * 0.048),
            buttonTheme(context, counter, 1, "Piezas negras", piecesTypes),
            SizedBox(height: defaultWidth * 0.048),
            buttonTheme(context, counter, 2, "Piezas blancas", piecesTypes),
          ])
        ]),
      ),
    ]);
  }

  Column activity() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        shortButton(context, false, "Partidas\nguardadas", () async {
          restartInfoGames();
          String next = await apiGames(userData.games);
          while (next != "null") {
            next = await apiGames(next);
          }
          if (context.mounted) {
            savedGames.popupSAVEDGAMES(context);
          }
        }),
        SizedBox(width: defaultWidth * 0.075),
        shortButton(context, false, "Historial\nde partidas", () async {
          restartInfoGames();
          String next = await apiGames(userData.games);
          while (next != "null") {
            next = await apiGames(next);
          }
          if (context.mounted) {
            playedGames.popupPLAYEDGAMES(context);
          }
        }),
      ]),
    ]);
  }

  ValueListenableBuilder boardTheme(ValueNotifier counter) {
    return ValueListenableBuilder(
      valueListenable: counter,
      builder: (context, value, child) {
        return SizedBox(
          height: defaultWidth * 0.3875,
          width: defaultWidth * 0.3875,
          child: Stack(children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(userData.boardTypeB),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: setImageColor(
                    context, "current_board.png", Color(userData.boardTypeN)),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: defaultWidth * 0.15,
                width: defaultWidth * 0.15,
                margin: EdgeInsets.all(defaultWidth * 0.0325),
                child: Image.asset(
                    "images/pieces/${userData.darkPieces}/caballoN.png"),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: defaultWidth * 0.15,
                width: defaultWidth * 0.15,
                margin: EdgeInsets.all(defaultWidth * 0.0325),
                child: Image.asset(
                    "images/pieces/${userData.lightPieces}/caballoB.png"),
              ),
            ),
          ]),
        );
      },
    );
  }

  divider(String texto) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.25,
            indent: defaultWidth * 0.1,
            endIndent: defaultWidth * 0.05,
          ),
        ),
        Text(
          texto,
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
            endIndent: defaultWidth * 0.1,
          ),
        ),
      ],
    );
  }
}
