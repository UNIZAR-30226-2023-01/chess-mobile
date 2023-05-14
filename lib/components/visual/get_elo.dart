import 'package:flutter/material.dart';

String getElo(int score) {
  if (2000 < score && score <= 2199) {
    return "EN";
  } else if (2200 <= score && score <= 2299) {
    return "MI";
  } else if (2300 <= score && score <= 2499) {
    return "MF";
  } else if (2500 <= score && score <= 2599) {
    return "GM";
  } else if (2600 <= score && score <= 2799) {
    return "SGM";
  } else if (2800 <= score) {
    return "CM";
  } else {
    return "null";
  }
}

showElo(int elo) {
  return printElo(elo, false);
}

showEloWithOpacity(int elo, bool opacity) {
  return printElo(elo, opacity);
}

printElo(int elo, bool opacity) {
  if (getElo(elo) != "null") {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: !opacity ? Colors.red : Colors.red.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        getElo(elo),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: !opacity ? Colors.white : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
