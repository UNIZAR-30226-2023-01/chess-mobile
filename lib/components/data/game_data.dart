/// Class that contains the data of a single game.
class GameData {
  var id = "",
      lightPlayer = "",
      darkPlayer = "",
      board = "",
      gameType = "",
      createdAt = "",
      updatedAt = "",
      winner = "",
      endState = "";
  int tInitial = 0, tIncrement = 0, tLightTimer = 0, tDarkTimer = 0;
  List<String> moves = List.empty(growable: true);

  GameData(
      this.id,
      var lightPlayer,
      var darkPlayer,
      this.board,
      var moves,
      this.tInitial,
      this.tIncrement,
      this.tLightTimer,
      this.tDarkTimer,
      this.gameType,
      this.createdAt,
      this.updatedAt) {
    for (var i in moves) {
      this.moves.add(i);
    }
    this.lightPlayer = lightPlayer ?? "Mr. AI";
    this.darkPlayer = darkPlayer ?? "Mr. AI";
    winner = "";
    endState = "";
  }

  void addResult(var winner, var endState) {
    this.winner = winner ?? "Empate";
    this.endState = endState ?? "Este mensaje no deberías poder leerlo";
  }
}
