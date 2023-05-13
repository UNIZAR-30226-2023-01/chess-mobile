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
  if (getElo(elo) != "null") {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        getElo(elo),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}
