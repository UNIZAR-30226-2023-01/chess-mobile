import 'package:flutter/material.dart';
import '../../pages/menus_pages/manage_tournaments.dart';
import '../communications/api.dart';

PopupMenuButton suscribed(BuildContext context, Widget widget, bool finished,
    ValueNotifier<int> counter, String id) {
  return PopupMenuButton(
    onCanceled: () {
      ActualSelection.isSelected = false;
      counter.value++;
    },
    onOpened: () {
      ActualSelection.id = id;
      ActualSelection.isSelected = true;
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
      ActualSelection.isSelected = false;
      counter.value++;
      switch (value) {
        case '_jugar':
          break;
        case '_visualizar':
          break;
        case '_salir':
          ActualSelection.manageTournamentDatas = List.empty(growable: true);
          apiJoinOrLeaveTournament("leave", id).then(
            (val) => counter.value++,
          );
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

PopupMenuButton unsuscribed(BuildContext context, Widget widget,
    ValueNotifier<int> counter, String id) {
  return PopupMenuButton(
    onCanceled: () {
      ActualSelection.isSelected = false;
      counter.value++;
    },
    onOpened: () {
      ActualSelection.id = id;
      ActualSelection.isSelected = true;
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
      ActualSelection.isSelected = false;
      counter.value++;
      switch (value) {
        case '_visualizar':
          break;
        case '_unir':
          ActualSelection.manageTournamentDatas = List.empty(growable: true);
          apiJoinOrLeaveTournament("join", id).then(
            (val) => counter.value++,
          );
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
