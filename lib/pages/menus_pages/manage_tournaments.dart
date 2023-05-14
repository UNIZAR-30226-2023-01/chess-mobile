import '../../components/singletons/manage_tournaments_data.dart';

import '../../components/visual/tournament_tag.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/tournament_tag_options.dart';
import '../../components/communications/api.dart';

class ManageTournamentPage extends StatefulWidget {
  const ManageTournamentPage({super.key});

  @override
  State<ManageTournamentPage> createState() => _ManageTournamentPageState();
}

class ActualSelection {
  static bool isSelected = false;
  static String id = "null";
  static List<ManageTournamentData> manageTournamentDatas =
      List.empty(growable: true);
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
                        onTap: () async {
                          ActualSelection.manageTournamentDatas =
                              List.empty(growable: true);
                          await apiMyTournaments();
                          setState(() {
                            myTournaments = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
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
                        onTap: () async {
                          ActualSelection.manageTournamentDatas =
                              List.empty(growable: true);
                          await apiOtherTournaments();
                          setState(() {
                            myTournaments = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: !myTournaments
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            "Buscar torneos",
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
                          for (ManageTournamentData m
                              in ActualSelection.manageTournamentDatas) ...[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: suscribed(
                                  context,
                                  tournamentTag(
                                      "avatars${m.creatorImage}",
                                      m.creatorName,
                                      m.creatorElo,
                                      m.startTime,
                                      m.rounds,
                                      m.duration,
                                      m.increment,
                                      m.finished,
                                      m.hasStarted,
                                      ActualSelection.id != m.id &&
                                          ActualSelection.isSelected,
                                      context),
                                  m.finished,
                                  counter,
                                  m.id,
                                  m.hasStarted,
                                  m.creatorId),
                            ),
                          ],
                        ],
                        if (!myTournaments) ...[
                          for (ManageTournamentData m
                              in ActualSelection.manageTournamentDatas) ...[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: unsuscribed(
                                  context,
                                  tournamentTag(
                                      "avatars${m.creatorImage}",
                                      m.creatorName,
                                      m.creatorElo,
                                      m.startTime,
                                      m.rounds,
                                      m.duration,
                                      m.increment,
                                      m.finished,
                                      m.hasStarted,
                                      ActualSelection.id != m.id &&
                                          ActualSelection.isSelected,
                                      context),
                                  counter,
                                  m.id,
                                  m.hasStarted,
                                  m.creatorId),
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
