import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

TextButton playButton(BuildContext context, Function() action) {
  return TextButton(
    onPressed: action,
    child: Container(
      width: defaultWidth * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          "JUGAR",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    ),
  );
}
