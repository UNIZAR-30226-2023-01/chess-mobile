import 'package:ajedrez/components/buttons/round_button.dart';
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
  static int currentRound = 1;
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
      body: SafeArea(
        child: Column(
          children: [
            // Round header
            SizedBox(
              height: defaultHeight * 0.2,
              child: Row(
                children: [
                  // Return round
                  SizedBox(
                    child: (TournamentData.currentRound > 1)
                        ? roundButton(
                            context,
                            true,
                            () {
                              TournamentData.currentRound--;
                              setState(() {});
                            },
                          )
                        : SizedBox(),
                    width: defaultWidth * 0.15,
                  ),

                  // Round text
                  SizedBox(
                    child: Center(
                      child: Text(
                        "Ronda ${TournamentData.currentRound}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    width: defaultWidth * 0.7,
                  ),

                  // Advance round
                  SizedBox(
                    child: (TournamentData.currentRound <
                            TournamentData.totalRounds)
                        ? roundButton(
                            context,
                            false,
                            () {
                              TournamentData.currentRound++;
                              setState(() {});
                            },
                          )
                        : SizedBox(),
                    width: defaultWidth * 0.15,
                  ),
                ],
              ),
            ),

            Divider(),

            // List for matches in a round
            Expanded(
              child: ListView(
                children: [
                  for (int i = 0; i < 10; i++)
                    Center(
                      child: tournamentNode(
                          "11-05-2023", "Alvaro", "pingüino", context),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
