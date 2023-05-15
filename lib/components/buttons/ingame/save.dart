import 'package:flutter/material.dart';
import '../../communications/socket_io.dart';

TextButton saveButton(BuildContext context) {
  return TextButton(
    onPressed: () => save(),
    child: Container(
      padding: const EdgeInsets.all(12.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          "Pausar y guardar la partida",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    ),
  );
}
