import 'package:flutter/material.dart';
import '../../data/profile_data.dart';
import '../../visual/screen_size.dart';

statisticBox(BuildContext context, String title, String body) {
  return SizedBox(
    width: defaultWidth * 0.3875,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(defaultHeight * 0.01),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(height: defaultHeight * 0.005),
          Text(
            body,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ]),
      ),
    ),
  );
}

Widget achievementBox(int n) {
  final UserData userData = UserData();
  return Tooltip(
    message:
        "${userData.achievements[n][1][0].toUpperCase()}${userData.achievements[n][1].substring(1)}",
    child: userData.achievements[n][2]
        ? Image.asset(
            "images${userData.achievements[n][0]}",
            fit: BoxFit.contain,
            width: defaultWidth * 0.175,
          )
        : ColorFiltered(
            colorFilter: greyscale,
            child: Image.asset(
              "images${userData.achievements[n][0]}",
              fit: BoxFit.contain,
              width: defaultWidth * 0.175,
            ),
          ),
  );
}

const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0.2126,
  0.7152,
  0.0722,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
]);
