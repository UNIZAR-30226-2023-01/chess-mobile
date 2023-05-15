import 'package:flutter/material.dart';
import '../buttons/back.dart';

AlertDialog popupBack(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    title: const Text("¿Seguro que deseas salir de la sesión?"),
    actions: [
      backButton(context, "No", false),
      backButton(context, "Sí", true), // api sign outS
    ],
  );
}
