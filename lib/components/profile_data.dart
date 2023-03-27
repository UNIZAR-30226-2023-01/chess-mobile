//enchufar aquí datos del perfil

//de momento se queda como singleton :D

import 'package:ajedrez/components/visual/customization_constants.dart';

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  bool isRegistered = false;
  String id = "", username = "Grace Hopper", email = "Ghopper@mail";
  int boardTypeN = maderaN;
  int boardTypeB = maderaB;
  String pieceType = "merida";
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

void changeTypePieces(String tipo) {
  UserData userData = UserData();
  userData.pieceType = tipo;
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
