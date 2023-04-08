import 'package:flutter/material.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/visual/screen_size.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/buttons/home_long_button.dart';
import '../../components/buttons/home_short_button.dart';
import '../../components/popups/spectator.dart';
import '../../components/popups/competitive.dart';
import '../../components/popups/ai.dart';
import '../../components/popups/custom.dart';
import '../../components/profile_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserData userData = UserData();
  final Spectator spectator = Spectator();
  final Competitive competitive = Competitive();
  final AI ai = AI();
  final Custom custom = Custom();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(children: [
          header(),
          userData.isRegistered
              ? Expanded(
                  child: Center(
                    child: ListView(children: [
                      SizedBox(height: defaultWidth * 0.05),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            longButton(
                                context,
                                true,
                                "Competitive.png",
                                "Partida competitiva",
                                () => competitive.popupCOMP(context)),
                          ]),
                      SizedBox(height: defaultWidth * 0.075),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            shortButton(
                                context,
                                false,
                                "Private.png",
                                "Partida privada",
                                () => custom.popupCUSTOM(context)),
                            SizedBox(width: defaultWidth * 0.075),
                            shortButton(context, false, "Tournaments.png",
                                "Torneo", () => null),
                          ]),
                      SizedBox(height: defaultWidth * 0.075),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            shortButton(context, false, "Computer.png",
                                "Contra la IA", () => ai.popupAI(context)),
                            SizedBox(width: defaultWidth * 0.075),
                            shortButton(
                                context,
                                false,
                                "Spectator.png",
                                "Espectar juego",
                                () => spectator.popupSPECTATOR(context)),
                          ]),
                      SizedBox(height: defaultWidth * 0.05),
                    ]),
                  ),
                )
              : Expanded(
                  child: Center(
                    child: ListView(children: [
                      SizedBox(height: defaultWidth * 0.05),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            longButton(
                                context,
                                false,
                                "Private.png",
                                "Partida privada",
                                () => custom.popupANONYMOUS(context)),
                          ]),
                      SizedBox(height: defaultWidth * 0.15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            longButton(
                                context,
                                false,
                                "Spectator.png",
                                "Espectar juego",
                                () => spectator.popupSPECTATOR(context)),
                            SizedBox(height: defaultWidth * 0.05),
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
}
