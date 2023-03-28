import 'package:flutter/material.dart';
import '../communications/socket_io.dart';
import '../visual/screen_size.dart';

TextButton surrenderButton(BuildContext context) {
  return TextButton(
    onPressed: () => {surrender()},
    child: Container(
      width: defaultWidth * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          "RENDIRSE",
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
