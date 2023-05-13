import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../popups/edit_profile.dart';
import '../../pages/menus_pages/manage_tournaments.dart';

PopupMenuButton suscribed(BuildContext context, Widget widget, bool finished,
    ValueNotifier<int> counter, int id) {
  return PopupMenuButton(
    onCanceled: () {
      actualSelection.isSelected = false;
      counter.value++;
    },
    onOpened: () {
      actualSelection.id = id;
      actualSelection.isSelected = true;
      counter.value++;
    },
    color: Theme.of(context).colorScheme.tertiary,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.25,
      ),
    ),
    child: widget,
    onSelected: (value) {
      actualSelection.isSelected = false;
      counter.value++;
      switch (value) {
        case '_jugar':
          break;
        case '_visualizar':
          break;
        case '_salir':
          break;
      }
    },
    itemBuilder: (context) {
      return [
        finished
            ? const PopupMenuItem(
                value: '_visualizar',
                child: Text("Visualizar"),
              )
            : const PopupMenuItem(
                value: '_jugar',
                child: Text("Jugar"),
              ),
        const PopupMenuItem(
          value: '_salir',
          child: Text("Salirse"),
        ),
      ];
    },
  );
}

PopupMenuButton unsuscribed(
    BuildContext context, Widget widget, ValueNotifier<int> counter, int id) {
  return PopupMenuButton(
    onCanceled: () {
      actualSelection.isSelected = false;
      counter.value++;
    },
    onOpened: () {
      actualSelection.id = id;
      actualSelection.isSelected = true;
      counter.value++;
    },
    color: Theme.of(context).colorScheme.tertiary,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.25,
      ),
    ),
    child: widget,
    onSelected: (value) {
      actualSelection.isSelected = false;
      counter.value++;
      switch (value) {
        case '_visualizar':
          break;
        case '_unir':
          break;
      }
    },
    itemBuilder: (context) {
      return [
        const PopupMenuItem(
          value: '_visualizar',
          child: Text("Visualizar"),
        ),
        const PopupMenuItem(
          value: '_unir',
          child: Text("Unirse"),
        ),
      ];
    },
  );
}
