//enchufar aquí datos del perfil

//de momento se queda como singleton :D

// import 'dart:ffi';

import 'package:ajedrez/components/visual/customization_constants.dart';
import 'game_data.dart';

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  bool isRegistered = false;
  String id = "",
      username = "Anónimo",
      email = "Anónimo",
      avatar = "/avatars/humans/1.webp";
  int elo = 0, rank = 0;
  double achievementRate = 0, winRate = 0;
  // [String imgSrc, String imgAlt, bool achieved]
  List<List> achievements = List.empty(growable: true);
  int boardTypeN = woodN;
  int boardTypeB = woodB;
  String boardType = "wood";
  String lightPieces = "/pieces/arab";
  String darkPieces = "/pieces/arab";
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

void updateProfile(
    String avatar,
    String username,
    String email,
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
    List<List> achievements,
    String board,
    String boardN,
    String boardB,
    String darkPieces,
    String lightPieces,
    String games) {
  UserData userData = UserData();
  userData.avatar = avatar;
  userData.username = username;
  userData.email = email;
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
  userData.achievements = achievements;
  int count = 0;
  for (var i in achievements) {
    if (i[2]) {
      count++;
    }
  }
  userData.achievementRate = (count / achievements.length) * 100;
  userData.games = games;
  userData.boardType = board;
  userData.boardTypeN = int.parse("0xFF${boardN.substring(1)}");
  userData.boardTypeB = int.parse("0xFF${boardB.substring(1)}");
  userData.darkPieces = darkPieces;
  userData.lightPieces = lightPieces;
}

void resetProfile() {
  UserData userData = UserData();
  userData.shiny = true;
  userData.isRegistered = false;
  userData.id = "";
  userData.username = "Anónimo";
  userData.email = "Anónimo";
  userData.avatar = "/avatars/humans/1.webp";
  userData.elo = 0;
  userData.rank = 0;
  userData.achievementRate = 0;
  userData.winRate = 0;
  userData.achievements = List.empty(growable: true);
  userData.boardTypeN = woodN;
  userData.boardTypeB = woodB;
  userData.boardType = "wood";
  userData.lightPieces = "/pieces/arab";
  userData.darkPieces = "/pieces/arab";
  userData.savedGames = List.empty(growable: true);
  userData.playedGames = List.empty(growable: true);
  userData.games = "";
  userData.token = "";
}
