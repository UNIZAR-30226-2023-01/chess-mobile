//enchufar aquí datos del perfil

//de momento se queda como singleton :D

import 'package:ajedrez/components/visual/customization_constants.dart';
import 'game_data.dart';

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  bool isRegistered = false;
  String id = "", username = "", email = "", avatar = "";
  int elo = 0, rank = 0, achievmentRate = 0, winRate = 0;
  int bulletWins = 0, blitzWins = 0, fastWins = 0;
  List<bool> achievments = [true, true, true, true, true, false, false, false];
  int boardTypeN = maderaN;
  int boardTypeB = maderaB;
  String pieceType = "merida";
  String lightPieces = "merida";
  String darkPieces = "merida";
  List<GameData> savedGames = List.empty(growable: true);
  List<GameData> playedGames = List.empty(growable: true);
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

void changeColorBoard(int tableroN, int tableroB) {
  UserData userData = UserData();
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
    String username,
    String email,
    String avatar,
    String board,
    String lightPieces,
    String darkPieces,
    int elo,
    int rank,
    int bulletWins,
    int blitzWins,
    int fastWins,
    List<bool> achievments) {
  UserData userData = UserData();
  userData.username = username;
  // ...
}
