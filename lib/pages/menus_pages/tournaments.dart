import '../../components/visual/tournament_node.dart';
import 'package:flutter/material.dart';

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
