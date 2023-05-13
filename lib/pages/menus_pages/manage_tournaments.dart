import 'package:ajedrez/components/buttons/round.dart';
import 'package:ajedrez/components/visual/screen_size.dart';

import '../../components/visual/tournament_tag.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/tournament_tag_options.dart';

class ManageTournamentPage extends StatefulWidget {
  const ManageTournamentPage({super.key});

  @override
  State<ManageTournamentPage> createState() => _ManageTournamentPageState();
}

class actualSelection {
  static bool isSelected = false;
  static int id = 2;
}

class _ManageTournamentPageState extends State<ManageTournamentPage> {
  bool myTournaments = true;
  ValueNotifier<int> counter = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: counter,
          builder: (context, value, child) {
            return Column(
              children: [
                SizedBox(
                  height: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // actualizar aqui
                          setState(() {
                            myTournaments = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: myTournaments
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            "Mis torneos",
                            style: TextStyle(
                              color: myTournaments
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // actualizar aqui
                          setState(() {
                            myTournaments = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: !myTournaments
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            "Torneos que no son tuyos",
                            style: TextStyle(
                              color: !myTournaments
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: ListView(
                      children: [
                        if (myTournaments) ...[
                          for (int i = 0; i < 20; i++) ...[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: suscribed(
                                  context,
                                  tournamentTag(
                                      "avatars/animals/5.webp",
                                      "Antoniddo",
                                      "15-10-2056 20:48",
                                      4,
                                      10,
                                      10,
                                      false,
                                      false,
                                      actualSelection.id != i &&
                                          actualSelection.isSelected,
                                      context),
                                  true,
                                  counter,
                                  i),
                            ),
                          ],
                        ],
                        if (!myTournaments) ...[
                          for (int i = 0; i < 20; i++) ...[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: unsuscribed(
                                  context,
                                  tournamentTag(
                                      "avatars/animals/5.webp",
                                      "Antoniddo",
                                      "15-10-2056 20:48",
                                      4,
                                      10,
                                      10,
                                      true,
                                      true,
                                      actualSelection.id != i &&
                                          actualSelection.isSelected,
                                      context),
                                  counter,
                                  i),
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
