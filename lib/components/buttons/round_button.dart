import 'package:ajedrez/components/chessLogic/square.dart';
import 'package:flutter/material.dart';
import '../visual/screen_size.dart';

SizedBox roundButton(BuildContext context, bool direction, Function() action) {
  return SizedBox(
    height: defaultWidth * 0.10,
    width: defaultWidth * 0.10,
    child: Material(
      color: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: action,
        child: Icon(
          direction ? Icons.arrow_left_sharp : Icons.arrow_right_sharp,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ),
  );
}
