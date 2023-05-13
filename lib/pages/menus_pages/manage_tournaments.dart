import 'package:ajedrez/components/buttons/round.dart';
import 'package:ajedrez/components/visual/screen_size.dart';

import '../../components/visual/tournament_tag.dart';
import 'package:flutter/material.dart';

class ManageTournamentPage extends StatefulWidget {
  const ManageTournamentPage({super.key});

  @override
  State<ManageTournamentPage> createState() => _ManageTournamentPageState();
}

class _ManageTournamentPageState extends State<ManageTournamentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          tournamentTag("avatars/animals/5.webp", "Antoniddo",
              "15-10-2056 20:48", 4, 10, 10, true, true, context),
        ],
      )),
    );
  }
}
