/// Popup when a game ends.
import 'package:flutter/material.dart';

Object alertWinner(BuildContext context, bool whiteTurn, String msg) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      title: const Text("Partida finalizada"),
      content: Text("$msg ${whiteTurn ? "blancas" : "negras"}."),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15,
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ).then((value) => Navigator.of(context).pop());
}
