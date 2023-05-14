import '../communications/api.dart';
import '../visual/convert_date.dart';

class ManageTournamentData {
  String id = "",
      creatorId = "",
      creatorName = "",
      creatorImage = "",
      startTime = "";
  int creatorElo = 0, rounds = 0, duration = 0, increment = 0;
  bool finished = false, hasStarted = false;

  Future<void> update(
      String id,
      String creatorId,
      String creatorName,
      String creatorImage,
      String startTime,
      int rounds,
      int duration,
      int increment,
      bool finished,
      bool hasStarted) async {
    this.id = id;
    this.creatorId = creatorId;
    this.creatorName = creatorName;
    this.creatorImage = creatorImage;
    creatorElo = TournamentUserData.elo;
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
  static int elo = 0;

  static void update(String id, String username, String avatar, int elo) {
    TournamentUserData.id = id;
    TournamentUserData.username = username;
    TournamentUserData.avatar = avatar;
    TournamentUserData.elo = elo;
  }
}
