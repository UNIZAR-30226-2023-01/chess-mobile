import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

SizedBox textButton(
    BuildContext context, bool type, String text, Function() action) {
  return SizedBox(
    width: defaultWidth * 0.85,
    child: Material(
      color: type ? Theme.of(context).colorScheme.primary : Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: type ? 0 : 1.25,
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: action,
        child: Padding(
          padding: EdgeInsets.all(defaultWidth * 0.04),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: type
                  ? Colors.grey[50]
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    ),
  );
}
