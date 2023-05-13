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

Widget tagCreator(String small, String big, BuildContext context) {
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

Widget tagInfo(String small, String big, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
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
          fontWeight: FontWeight.bold, ////
          fontSize: 17,
        ),
      ),
    ],
  );
}

Widget tournamentTag(
  String creatorImage,
  String creatorName,
  String startTime,
  int rounds,
  int duration,
  int increments,
  bool finished,
  bool hasStarted,
  bool notFocused,
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
            foregroundDecoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              color: Colors.black.withOpacity(notFocused ? 0.35 : 0.0),
            ),
            decoration: BoxDecoration(
              color: finished
                  ? Colors.red
                  : hasStarted
                      ? Colors.orange
                      : Colors.green,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            width: defaultWidth * 0.85,
            child: Center(
              child: Text(
                finished
                    ? "Finalizado"
                    : hasStarted
                        ? "En curso..."
                        : "Esperando jugadores...",
                overflow: TextOverflow.visible,
                style: const TextStyle(
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
              foregroundDecoration: BoxDecoration(
                color: Colors.black
                    .withOpacity(finished || notFocused ? 0.35 : 0.0),
              ),
              padding: EdgeInsets.symmetric(vertical: defaultWidth * 0.0175),
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                children: [
                  // Creator picture
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: imageItem(
                        defaultHeight * 0.08, 2, creatorImage, context),
                  ),

                  // Tag info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Creator Name
                      tagCreator("Torneo de:", creatorName, context),

                      SizedBox(height: defaultWidth * 0.0175),

                      // Match duration & Increment & Round number
                      Row(
                        children: [
                          tagInfo("Rondas", rounds.toString(), context),
                          SizedBox(width: defaultWidth * 0.05),
                          tagInfo("Duración", "${duration.toString()} min",
                              context),
                          SizedBox(width: defaultWidth * 0.05),
                          tagInfo("Incremento", "${increments.toString()} seg",
                              context),
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
            foregroundDecoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
              color:
                  Colors.black.withOpacity(finished || notFocused ? 0.35 : 0.0),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15)),
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
