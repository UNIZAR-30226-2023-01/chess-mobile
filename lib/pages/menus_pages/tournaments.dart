
import 'package:ajedrez/components/visual/screen_size.dart';


import '../../components/visual/tournament_node.dart';
import 'package:flutter/material.dart';

// Data structure for matches
class TournamentMatch {
  String matchID = "null";
  String nextMatchID = "null";
  String startTime = "null";
  String player1ID = "null";
  String player2ID = "null";
  bool played = false;
}

// Data structure for rounds
class TournamentData {
  // Update only first time the tournament itself is fethed
  static List<List> players = List.empty(growable: true);
  static int totalRounds = 5;

  // Update every single time user decides to check another round
  static List<TournamentMatch> matches = List.empty(growable: true);
  static int visualCurrentRound = 3;
}

class TournamentPage extends StatefulWidget {
  const TournamentPage({super.key});

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: defaultWidth * 0.05),
                  for (int i = 1; i <= TournamentData.totalRounds; i++) ...[
                    Container(
                      width: defaultWidth * 0.265,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            TournamentData.totalRounds = 3;
                            TournamentData.visualCurrentRound = i;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: TournamentData.visualCurrentRound == i
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              "Ronda $i",
                              style: TextStyle(
                                color: TournamentData.visualCurrentRound == i
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: defaultWidth * 0.05),
                  ],
                ],
              ),
            ),

            // List for matches in a round
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ListView(
                  children: [
                    for (int i = 0; i < 10; i++)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: tournamentNode(
                              "11-05-2023",
                              "Alvaro",
                              "pingüino",
                              "avatars/animals/1.webp",
                              "avatars/animals/40.webp",
                              0,
                              0,
                              true,
                              true,
                              context),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
