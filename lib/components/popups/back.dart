import 'package:flutter/material.dart';
import '../buttons/back_button.dart';
import '../communications/api.dart';

AlertDialog popupBack(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    title: const Text("¿Seguro que deseas salir de la sesión?"),
    actions: [
      backButton(context, "No", false, () => null),
      backButton(context, "Sí", true, () => apiSignOut()), // api sign outS
    ],
  );
}
