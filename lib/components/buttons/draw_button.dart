import 'package:flutter/material.dart';
import '../communications/socket_io.dart';
import '../visual/screen_size.dart';

TextButton drawButton(BuildContext context) {
  return TextButton(
    onPressed: () => draw(),
    child: Container(
      width: defaultWidth * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          "PROPONER TABLAS",
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
