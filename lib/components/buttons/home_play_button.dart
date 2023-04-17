import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

Material playButton(BuildContext context, String text, Function() action) {
  return Material(
    color: Theme.of(context).colorScheme.primary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: action,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: defaultWidth * 0.03,
          horizontal: defaultWidth * 0.06,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
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
