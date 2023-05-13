import 'package:ajedrez/components/visual/set_image_color.dart';

import '../../components/visual/screen_size.dart';
import 'package:flutter/material.dart';

Widget imageItem(
    double tamanyo, double circle, String image, BuildContext context) {
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
          image: AssetImage('images/$image'),
        ),
      ),
    ),
  );
}

Widget tagInfo(String small, String big, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Small subtext
      Text(
        small,
        overflow: TextOverflow.visible,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 15,
        ),
      ),

      // Big title
      Text(
        big,
        overflow: TextOverflow.visible,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    ],
  );
}

Widget tournamentTag(
  String creator_image,
  String creator_name,
  String startTime,
  int rounds,
  int duration,
  int increments,
  bool finished,
  bool status,
  BuildContext context,
) {
  return Center(
    child: SizedBox(
      width: defaultWidth * 0.85,
      child: Column(
        children: [
          // Tournament status
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            width: defaultWidth * 0.85,
            child: Center(
              child: Text(
                "Esperando jugadores...",
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ),

          // Tournament info
          Container(
            color: Colors.green,
            child: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                children: [
                  // Creator picture
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: imageItem(
                        defaultHeight * 0.07, 2, creator_image, context),
                  ),

                  // Tag info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Creator Name
                      tagInfo("Torneo de:", creator_name, context),

                      SizedBox(height: defaultWidth * 0.0175),

                      // Match duration & Increment & Round number
                      Row(
                        children: [
                          Text(
                            rounds.toString(),
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            duration.toString(),
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            increments.toString(),
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            width: defaultWidth * 0.85,
            child: Center(
              child: Text(
                startTime,
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
      ),
    ),
  );
}
