import 'package:flutter/material.dart';

Container textField(BuildContext context, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 1.25,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    child: TextField(
      textAlign: TextAlign.center,
      obscureText: false,
      controller: controller,
      style: TextStyle(
        fontSize: 19,
        color: Theme.of(context).colorScheme.primary,
      ),
      decoration: const InputDecoration(
        hintText: "Escribe aquí ...",
        hintStyle: TextStyle(
          fontSize: 19,
          color: Color.fromARGB(132, 88, 103, 130),
        ),
      ),
    ),
  );
}
