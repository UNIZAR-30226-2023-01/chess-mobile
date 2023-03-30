import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

SizedBox playButton(BuildContext context, Function() action) {
  return SizedBox(
    width: defaultWidth * 0.3,
    child: Material(
      color: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: action,
        child: Padding(
          padding: EdgeInsets.all(defaultWidth * 0.04),
          child: Text(
            "JUGAR",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    ),
  );
}
