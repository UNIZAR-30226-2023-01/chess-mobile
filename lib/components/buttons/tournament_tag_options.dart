import 'package:ajedrez/components/data/profile_data.dart';
import 'package:flutter/material.dart';
import '../../pages/menus_pages/manage_tournaments.dart';
import '../communications/api.dart';
import '../../pages/menus_pages/tournaments.dart';

PopupMenuButton suscribed(
    BuildContext context,
    Widget widget,
    bool finished,
    ValueNotifier<int> counter,
    String id,
    bool hasStarted,
    String owner,
    int rounds,
    String ownerName,
    int ownerElo) {
  UserData userData = UserData();

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
    onSelected: (value) async {
      ActualSelection.isSelected = false;
      switch (value) {
        case '_jugar':
          TournamentData.matches = List.empty(growable: true);
          await apiGetTournament(id);
          TournamentData.totalRounds = rounds;
          TournamentData.visualCurrentRound = 1;
          TournamentData.ownerName = ownerName;
          TournamentData.ownerElo = ownerElo;
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TournamentPage(),
              ),
            );
          }
          break;
        case '_visualizar':
          TournamentData.matches = List.empty(growable: true);
          await apiGetTournament(id);
          TournamentData.totalRounds = rounds;
          TournamentData.visualCurrentRound = 1;
          TournamentData.ownerName = ownerName;
          TournamentData.ownerElo = ownerElo;
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TournamentPage(),
              ),
            );
          }
          break;
        case '_salir':
          ActualSelection.manageTournamentDatas = List.empty(growable: true);
          await apiJoinOrLeaveTournament("leave", id);
          break;
        case '_delete':
          ActualSelection.manageTournamentDatas = List.empty(growable: true);
          await apiDeleteTournament(true, id);
          break;
      }
      counter.value++;
    },
    itemBuilder: (context) {
      return [
        if (!finished) ...[
          const PopupMenuItem(
            value: '_jugar',
            child: Text("Jugar"),
          ),
        ] else ...[
          const PopupMenuItem(
            value: '_visualizar',
            child: Text("Visualizar"),
          ),
        ],
        if (!hasStarted)
          const PopupMenuItem(
            value: '_salir',
            child: Text("Salirse"),
          ),
        if (!hasStarted && userData.id == owner)
          const PopupMenuItem(
            value: '_delete',
            child: Text("Eliminar"),
          ),
      ];
    },
  );
}

PopupMenuButton unsuscribed(
    BuildContext context,
    Widget widget,
    ValueNotifier<int> counter,
    String id,
    bool hasStarted,
    String owner,
    int rounds,
    String ownerName,
    int ownerElo) {
  UserData userData = UserData();

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
    onSelected: (value) async {
      ActualSelection.isSelected = false;
      switch (value) {
        case '_visualizar':
          TournamentData.matches = List.empty(growable: true);
          await apiGetTournament(id);
          TournamentData.totalRounds = rounds;
          TournamentData.visualCurrentRound = 1;
          TournamentData.ownerName = ownerName;
          TournamentData.ownerElo = ownerElo;
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TournamentPage(),
              ),
            );
          }
          break;
        case '_unir':
          ActualSelection.manageTournamentDatas = List.empty(growable: true);
          await apiJoinOrLeaveTournament("join", id);
          break;
        case '_delete':
          ActualSelection.manageTournamentDatas = List.empty(growable: true);
          await apiDeleteTournament(false, id);
          break;
      }
      counter.value++;
    },
    itemBuilder: (context) {
      return [
        const PopupMenuItem(
          value: '_visualizar',
          child: Text("Visualizar"),
        ),
        if (!hasStarted)
          const PopupMenuItem(
            value: '_unir',
            child: Text("Unirse"),
          ),
        if (!hasStarted && userData.id == owner)
          const PopupMenuItem(
            value: '_delete',
            child: Text("Eliminar"),
          ),
      ];
    },
  );
}
