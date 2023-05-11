import 'package:flutter/material.dart';
import '../buttons/delete_button.dart';
import '../communications/api.dart';

AlertDialog popupDelete(BuildContext context) {
  return AlertDialog(
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    title: const Text(
        "¿Seguro que deseas eliminar tu cuenta? No podrás recuperarla."),
    actions: [
      deleteButton(context, "No", () => Navigator.pop(context)),
      deleteButton(context, "Sí", () => apiDeleteUser()), // api sign outS
    ],
  );
}
