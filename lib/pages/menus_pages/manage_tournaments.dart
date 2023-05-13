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
  bool myTournaments = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
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
              ))
            ],
          ),
        )

        // Column(
        //   children: [
        //     SizedBox(
        //       height: defaultHeight / 2,
        //       child: Expanded(
        //         child: ListView(
        //           scrollDirection: Axis.horizontal,
        //           children: [
        //             for (int i = 0; i < 5; i++)
        //               tournamentTag("avatars/animals/5.webp", "Antoniddo",
        //                   "15-10-2056 20:48", 4, 10, 10, false, false, context),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Divider(
        //       height: 1,
        //       thickness: 2,
        //       color: Theme.of(context).colorScheme.primary,
        //     ),
        //     SizedBox(
        //       child: Expanded(
        //         child: ListView(
        //           children: [
        //             for (int i = 0; i < 5; i++)
        //               tournamentTag("avatars/animals/5.webp", "Antoniddo",
        //                   "15-10-2056 20:48", 4, 10, 10, false, false, context),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
