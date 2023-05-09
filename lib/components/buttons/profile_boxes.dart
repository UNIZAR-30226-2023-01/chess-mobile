import 'package:flutter/material.dart';
import '../profile_data.dart';
import '../../components/visual/screen_size.dart';

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

Image achievementBox(int n) {
  final UserData userData = UserData();
  return Image.asset(
    "images/${userData.achievements[n - 1] ? "achievement_true" : "achievement_false"}/$n.png",
    fit: BoxFit.contain,
    width: defaultWidth * 0.175,
  );
}
