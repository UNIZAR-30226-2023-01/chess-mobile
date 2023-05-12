//enchufar aquí datos del perfil

//de momento se queda como singleton :D

// import 'dart:ffi';

import 'package:ajedrez/components/visual/customization_constants.dart';
import 'game_data.dart';

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  bool isRegistered = false;
  String id = "", username = "a", email = "a", avatar = "/humans/1.webp";
  int elo = 0, rank = 0;
  double achievementRate = 0, winRate = 0;
  List<bool> achievements = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int boardTypeN = woodN;
  int boardTypeB = woodB;
  String boardType = "wood";
  String lightPieces = "arab";
  String darkPieces = "arab";
  List<GameData> savedGames = List.empty(growable: true);
  List<GameData> playedGames = List.empty(growable: true);
  String games = "";
  String token = "";
  factory UserData() {
    return _singleton;
  }

  UserData._internal();
}

void resetProfileData(bool shiny) {
  UserData userData = UserData();
  userData.shiny = shiny;
}

void changeColorBoard(String board, int tableroN, int tableroB) {
  UserData userData = UserData();
  userData.boardType = board;
  userData.boardTypeN = tableroN;
  userData.boardTypeB = tableroB;
}

// void changeTypePieces(String tipo) {
//   UserData userData = UserData();
//   userData.pieceType = tipo;
// }

void changeLightPieces(String tipo) {
  UserData userData = UserData();
  userData.lightPieces = tipo;
}

void changeDarkPieces(String tipo) {
  UserData userData = UserData();
  userData.darkPieces = tipo;
}

void assignToken(String token) {
  UserData userData = UserData();
  userData.token = token;
}

void assignId(String id) {
  UserData userData = UserData();
  userData.id = id;
}

void assignUsername(String username) {
  UserData userData = UserData();
  userData.username = username;
}

void assignEmail(String email) {
  UserData userData = UserData();
  userData.email = email;
}

void assignAvatar(String avatar) {
  UserData userData = UserData();
  userData.avatar = avatar;
}

void assignIsRegistred(bool isRegistered) {
  UserData userData = UserData();
  userData.isRegistered = isRegistered;
}

void restartInfoGames() {
  UserData userData = UserData();
  userData.savedGames = List.empty(growable: true);
  userData.playedGames = List.empty(growable: true);
}

void addSavedGame(GameData gameData) {
  UserData userData = UserData();
  userData.savedGames.insert(0, gameData);
}

void addPlayedGame(GameData gameData) {
  UserData userData = UserData();
  userData.playedGames.insert(0, gameData);
}

// Falta theme
void updateProfile(
    String username,
    String email,
    String avatar,
    String board,
    String lightPieces,
    String darkPieces,
    int elo,
    int rank,
    int bulletWins,
    int bulletDraws,
    int bulletDefeats,
    int blitzWins,
    int blitzDraws,
    int blitzDefeats,
    int fastWins,
    int fastDraws,
    int fastDefeats,
    var achievements,
    String games) {
  UserData userData = UserData();
  userData.username = username;
  userData.email = email;
  userData.avatar = avatar;
  userData.elo = elo;
  userData.rank = rank;
  int total = bulletWins +
      bulletDraws +
      bulletDefeats +
      blitzWins +
      blitzDraws +
      blitzDefeats +
      fastWins +
      fastDraws +
      fastDefeats;
  userData.winRate =
      total == 0 ? 0 : ((bulletWins + blitzWins + fastWins) / total) * 100;
  userData.achievements = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int count = 0;
  for (var i in achievements) {
    switch (i) {
      case "FIRST LOGIN":
        userData.achievements[0] = true;
        count++;
        break;
      case "PLAY 10 COMPETITIVE":
        userData.achievements[1] = true;
        count++;
        break;
      case "PLAY 10 CUSTOM":
        userData.achievements[2] = true;
        count++;
        break;
      case "PLAY 10 TOURNAMENT":
        userData.achievements[3] = true;
        count++;
        break;
      case "PLAY 10 AI":
        userData.achievements[4] = true;
        count++;
        break;
      case "DRAW 10 GAMES":
        userData.achievements[5] = true;
        count++;
        break;
      case "TOP 100":
        userData.achievements[6] = true;
        count++;
        break;
      case "TOP 1":
        userData.achievements[7] = true;
        count++;
        break;
    }
  }
  userData.achievementRate = (count / 8.0) * 100;
  userData.games = games;
  userData.boardType = board;
  for (int i = 0; i < boardTypes.length; i++) {
    if (boardTypes[i][0] == board) {
      userData.boardTypeN = boardTypes[i][1];
      userData.boardTypeB = boardTypes[i][2];
    }
  }
  userData.darkPieces = darkPieces;
  userData.lightPieces = lightPieces;
}
