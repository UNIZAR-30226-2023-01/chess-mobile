import 'package:flutter/material.dart';
import '../../components/visual/screen_size.dart';

PopupMenuButton optionsButton(BuildContext context) {
  return PopupMenuButton(
    color: Theme.of(context).colorScheme.tertiary,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.25,
      ),
    ),
    child: Icon(
      Icons.settings,
      size: defaultHeight * 0.035,
    ),
    onSelected: (value) {},
    itemBuilder: (context) {
      return const [
        PopupMenuItem(
          value: '_edit',
          child: Text("Editar perfil"),
        ),
        PopupMenuItem(
          value: '_password',
          child: Text("Cambiar contraseña"),
        ),
        PopupMenuItem(
          value: '_delete',
          child: Text("Eliminar cuenta"),
        ),
      ];
    },
  );
}
