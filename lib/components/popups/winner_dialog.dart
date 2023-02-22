import 'package:flutter/material.dart';

Object alertaGanador(BuildContext context, bool whiteTurn) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Partida finalizada"),
      content: Text(
          "Ha ganado el jugador con las piezas ${whiteTurn ? "blancas" : "negras"}"),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Ok"),
        ),
      ],
    ),
  ).then((value) => Navigator.of(context).pop());
}
