import '../communications/api.dart';
import '../visual/convert_date.dart';

class ManageTournamentData {
  String id = "", creatorName = "", creatorImage = "", startTime = "";
  int rounds = 0, duration = 0, increment = 0;
  bool finished = false, hasStarted = false;

  Future<void> update(String id, String owner, String startTime, int rounds,
      int duration, int increment, bool finished, bool hasStarted) async {
    List<String> fields = owner.split("/");
    await apiGetTournamentUser(fields[fields.length - 1]);
    this.id = id;
    creatorName = TournamentUserData.username;
    creatorImage = TournamentUserData.avatar;
    this.startTime = convertirFecha(startTime);
    this.rounds = rounds;
    this.duration = duration ~/ 60;
    this.increment = increment;
    this.finished = finished;
    this.hasStarted = hasStarted;
  }
}

class TournamentUserData {
  static String id = "", username = "", avatar = "";

  static void update(String id, String username, String avatar) {
    TournamentUserData.id = id;
    TournamentUserData.username = username;
    TournamentUserData.avatar = avatar;
  }
}
