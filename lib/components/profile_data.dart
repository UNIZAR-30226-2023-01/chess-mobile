//enchufar aquí datos del perfil

//de momento se queda como singleton :D

class UserData {
  static final UserData _singleton = UserData._internal();
  bool shiny = true;
  factory UserData() {
    return _singleton;
  }

  UserData._internal();
}

void resetProfileData(bool shiny) {
  UserData userData = UserData();
  userData.shiny = shiny;
}
