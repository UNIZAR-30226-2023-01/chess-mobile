//enchufar aquí datos del perfil

//de momento se queda como singleton :D

import 'package:ajedrez/components/visual/colores_tablero.dart';

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  int tableroN = maderaN;
  int tableroB = maderaB;
  String tipo = "merida";
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
  userData.tableroN = tableroN;
  userData.tableroB = tableroB;
}

void changeTypePieces(String tipo) {
  UserData userData = UserData();
  userData.tipo = tipo;
}
