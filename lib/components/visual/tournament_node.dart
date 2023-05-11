import '../../components/visual/screen_size.dart';
import '../../pages/menus_pages/ranking.dart';
import 'package:flutter/material.dart';

Widget imageItem(
    double tamanyo, double circle, String imagen, BuildContext context) {
  return SizedBox(
    height: tamanyo,
    width: tamanyo,
    child: Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: circle,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/$imagen'),
          )),
    ),
  );
}

Widget tournamentNode(String date, String player_1, String player_2,
    String image_1, String image_2, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Match date
      Text(
        date,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 19,
        ),
      ),

      // Match Box
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        width: defaultWidth * 0.75,
        child: Column(
          children: [
            // Player 1 cell
            Row(
              children: [
                // Player 1 picture
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: imageItem(defaultHeight * 0.07, 2, image_1, context),
                ),

                Text(
                  player_1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
                ),
              ],
            ),

            Divider(
              height: 1,
              thickness: 1.25,
              color: Theme.of(context).colorScheme.primary,
            ),

            // Player 2 cell
            Row(
              children: [
                // Player 2 picture
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: imageItem(defaultHeight * 0.07, 2, image_2, context),
                ),

                Text(
                  player_2,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
