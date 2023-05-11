import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

TextButton deleteButton(BuildContext context, String text, Function() action) {
  return TextButton(
    onPressed: () => action,
    child: Container(
      width: defaultWidth * 0.15,
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          text,
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
