import 'package:flutter/material.dart';
import '../../communications/socket_io.dart';

TextButton drawButton(BuildContext context) {
  return TextButton(
    onPressed: () => draw(),
    child: Container(
      padding: const EdgeInsets.all(12.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          "Proponer tablas",
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
