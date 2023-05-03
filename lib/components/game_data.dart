class GameData {
  var id = "",
      lightPlayer = "",
      darkPlayer = "",
      board = "",
      gameType = "",
      createdAt = "",
      updatedAt = "";
  int tInitial, tIncrement, tLightTimer, tDarkTimer;
  List<String> moves = List.empty(growable: true);

  GameData(
      this.id,
      this.lightPlayer,
      this.darkPlayer,
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
  }
}
