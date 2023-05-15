import 'package:ajedrez/components/popups/delete.dart';
import 'package:flutter/material.dart';
import '../../visual/screen_size.dart';
import '../../popups/edit_profile.dart';

PopupMenuButton optionsButton(
    BuildContext context, ValueNotifier<int> counter) {
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
    onSelected: (value) {
      switch (value) {
        case '_edit':
          popupEditProfile(context, counter);
          break;
        case '_delete':
          popupDelete(context);
          break;
      }
    },
    itemBuilder: (context) {
      return const [
        PopupMenuItem(
          value: '_edit',
          child: Text("Editar perfil"),
        ),
        PopupMenuItem(
          value: '_delete',
          child: Text("Eliminar cuenta"),
        ),
      ];
    },
  );
}
