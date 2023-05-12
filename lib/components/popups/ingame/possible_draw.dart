import 'package:ajedrez/components/communications/socket_io.dart';
import 'package:flutter/material.dart';

Object alertPossibleDraw(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      title: const Text("TABLAS"),
      content: const Text("El otro jugador ha propuesto pactar tablas."),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Navigator.of(context).pop(),
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text(
                "KEEP PLAYING",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => {Navigator.of(context).pop(), draw()},
          child: Container(
            width: MediaQuery.of(context).size.width * 0.20,
            padding: const EdgeInsets.symmetric(vertical: 12.5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
              child: Text(
                "DRAW",
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
  );
}
