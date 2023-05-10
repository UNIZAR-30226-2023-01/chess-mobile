import '../../components/visual/screen_size.dart';
import 'package:flutter/material.dart';

Widget tournamentNode(
    String date, String player_1, String player_2, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        date,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).colorScheme.primary,
        ),
        width: defaultWidth * 0.45,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                player_1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            Divider(
              thickness: 1.25,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                player_2,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
