import 'package:ajedrez/components/visual/get_elo.dart';
import 'package:ajedrez/components/visual/set_image_color.dart';

import '../../components/visual/screen_size.dart';
import 'package:flutter/material.dart';

Widget imageItem(double tamanyo, double circle, String imagen,
    BuildContext context, double opacity) {
  return SizedBox(
    height: tamanyo,
    width: tamanyo,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(opacity),
          width: circle,
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/$imagen'),
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(opacity),
            BlendMode.modulate,
          ),
        ),
      ),
    ),
  );
}

Widget tournamentNode(
    String date,
    String player_1,
    String player_2,
    String image_1,
    String image_2,
    int elo_1,
    int elo_2,
    bool hasStarted,
    bool finished,
    bool winner,
    BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Match date
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        decoration: BoxDecoration(
          color: finished
              ? Colors.red
              : hasStarted
                  ? Colors.orange
                  : Colors.green,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        ),
        width: defaultWidth * 0.85,
        child: Center(
          child: Text(
            finished
                ? "Finalizado"
                : hasStarted
                    ? "En curso..."
                    : "Esperando...",
            overflow: TextOverflow.visible,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),

      // Match Box
      SizedBox(
        width: defaultWidth * 0.85,
        child: Column(
          children: [
            // Player 1 cell
            Container(
              decoration: BoxDecoration(
                // borderRadius: const BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15)),
                color: finished && !winner
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: Row(
                children: [
                  // Player 1 picture
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: image_1 != "avatarsnull"
                        ? imageItem(defaultHeight * 0.07, 2, image_1, context,
                            finished && !winner ? 0.5 : 1.0)
                        : SizedBox(
                            width: defaultHeight * 0.07,
                            height: defaultHeight * 0.07,
                          ),
                  ),

                  // Player 1 name
                  SizedBox(
                    width: defaultWidth * 0.85 -
                        defaultHeight * 0.07 -
                        50 -
                        defaultWidth * 0.125,
                    child: Row(
                      children: [
                        showEloWithOpacity(elo_1, finished && !winner),
                        Flexible(
                          child: Text(
                            player_1 == "null" ? "---" : player_1,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(finished && !winner ? 0.5 : 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Show icon if winner
                  finished && winner
                      ? SizedBox(
                          height: defaultWidth * 0.125,
                          child: setImageColor(context, 'trophy.png',
                              Theme.of(context).colorScheme.primary),
                        )
                      : const SizedBox(),
                ],
              ),
            ),

            Divider(
              height: 1,
              thickness: 2,
              color: Theme.of(context).colorScheme.primary,
            ),

            // Player 2 cell
            Container(
              decoration: BoxDecoration(
                // borderRadius: const BorderRadius.only(
                //     bottomLeft: Radius.circular(15),
                //     bottomRight: Radius.circular(15)),
                color: finished && winner
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: Row(
                children: [
                  // Player 2 picture
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: image_2 != "avatarsnull"
                        ? imageItem(defaultHeight * 0.07, 2, image_2, context,
                            finished && winner ? 0.5 : 1)
                        : SizedBox(
                            width: defaultHeight * 0.07,
                            height: defaultHeight * 0.07,
                          ),
                  ),
                  // Player 2 name
                  SizedBox(
                    width: defaultWidth * 0.85 - defaultHeight * 0.07 - 40,
                    child: Row(
                      children: [
                        showEloWithOpacity(elo_2, finished && winner),
                        Flexible(
                          child: Text(
                            player_2 == "null" ? "---" : player_2,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(finished && winner ? 0.5 : 1),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Show icon if winner
                  finished && !winner
                      ? SizedBox(
                          height: defaultWidth * 0.125,
                          child: setImageColor(context, 'trophy.png',
                              Theme.of(context).colorScheme.primary),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(15))),
        width: defaultWidth * 0.85,
        child: Center(
          child: Text(
            date,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    ],
  );
}
