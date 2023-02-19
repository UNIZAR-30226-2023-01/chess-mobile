import 'package:flutter/material.dart';

Object alertaGanador(BuildContext context, bool whiteTurn) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Partida finalizada"),
      content: Text(
          "Ha ganado el jugador con las piezas ${whiteTurn ? "blancas" : "negras"}"),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
          },
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}
