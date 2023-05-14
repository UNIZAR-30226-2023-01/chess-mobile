import 'package:ajedrez/components/visual/convert_date.dart';
import 'package:ajedrez/components/visual/screen_size.dart';
import 'package:ajedrez/components/visual/get_elo.dart';

import '../../components/visual/tournament_node.dart';
import 'package:flutter/material.dart';

// Data structure for matches
class TournamentMatch {
  String matchID = "null";
  String startTime = "null";
  String player1ID = "null";
  String player1Name = "null";
  String player1Image = "null";
  int player1Elo = 0;
  String player2ID = "null";
  String player2Name = "null";
  String player2Image = "null";
  int player2Elo = 0;
  bool hasStarted = false;
  bool finished = false;
  String winner = "null";

  void update(
      String matchID,
      String startTime,
      String player1ID,
      String player1Name,
      String player1Image,
      int player1Elo,
      String player2ID,
      String player2Name,
      String player2Image,
      int player2Elo,
      bool hasStarted,
      bool finished,
      String winner) {
    this.matchID = matchID;
    this.startTime = convertirFecha(startTime);
    this.player1ID = player1ID;
    this.player1Name = player1Name;
    this.player1Image = player1Image;
    this.player1Elo = player1Elo;
    this.player2ID = player2ID;
    this.player2Name = player2Name;
    this.player2Image = player2Image;
    this.player2Elo = player2Elo;
    this.hasStarted = hasStarted;
    this.finished = finished;
    this.winner = winner;
  }
}

// Data structure for rounds
class TournamentData {
  // Update only first time the tournament itself is fethed
  static List<List> players = List.empty(growable: true);
  static int totalRounds = 5;

  // Update every single time user decides to check another round
  // matches[numRound][TournamentMatch]
  static List<List<TournamentMatch>> matches = List.empty(growable: true);
  static int visualCurrentRound = 1;
  static int realCurrentRound() {
    return TournamentData.totalRounds - TournamentData.visualCurrentRound + 1;
  }
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Text(
                      "Torneo de  ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    showElo(2300),
                    Text(
                      "Antonio Antoniddo",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 75,
              child: TournamentData.totalRounds > 3
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: defaultWidth * 0.05),
                        for (int i = 1;
                            i <= TournamentData.totalRounds;
                            i++) ...[
                          roundField(i),
                          SizedBox(width: defaultWidth * 0.05),
                        ],
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (TournamentData.totalRounds >= 1) roundField(1),
                        if (TournamentData.totalRounds >= 2) roundField(2),
                        if (TournamentData.totalRounds >= 3) roundField(3),
                      ],
                    ),
            ),

            // List for matches in a round
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ListView(
                  children: [
                    for (TournamentMatch m in TournamentData
                        .matches[TournamentData.realCurrentRound() - 1]) ...[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: tournamentNode(
                              m.startTime,
                              m.player1Name,
                              m.player2Name,
                              "avatars${m.player1Image}",
                              "avatars${m.player2Image}",
                              m.player1Elo,
                              m.player2Elo,
                              m.hasStarted,
                              m.finished,
                              m.winner == m.player1ID,
                              context),
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget roundField(int i) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            TournamentData.visualCurrentRound = i;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: TournamentData.visualCurrentRound == i
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              i == TournamentData.totalRounds
                  ? "Final"
                  : i == TournamentData.totalRounds - 1
                      ? "Semifinal"
                      : "Ronda $i",
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
    );
  }
}
