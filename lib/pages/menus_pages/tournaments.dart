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
  List<List> players = List.empty(growable: true);
  int totalRounds = 1;

  // Update every single time user decides to check another round
  List<TournamentMatch> matches = List.empty(growable: true);
  int currentRound = 1;
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
        child: tournamentNode(
            "2021-05-30", "PatriciaS979", "BanqueroJudio", context),
      ),
    );
  }
}
