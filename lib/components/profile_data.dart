//enchufar aquí datos del perfil

//de momento se queda como singleton :D

import 'package:ajedrez/components/visual/customization_constants.dart';

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
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
