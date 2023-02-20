//enchufar aquí datos del perfil

//de momento se queda como singleton :D

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  int tableroN = 0xff769656;
  int tableroB = 0xffeeeed2;
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
