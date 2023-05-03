import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

SizedBox shortButton(
    BuildContext context, bool type, String text, Function() action) {
  return SizedBox(
    width: defaultWidth * 0.3875,
    child: Material(
      color: type
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        onTap: action,
        child: SizedBox(
          height: defaultWidth * 0.2,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: type
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
