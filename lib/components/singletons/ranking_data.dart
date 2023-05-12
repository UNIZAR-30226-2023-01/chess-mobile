class RankingData {
  static List<String> avatar = List.empty(growable: true);
  static List<String> username = List.empty(growable: true);
  static List<int> elo = List.empty(growable: true);
  static List<int> rank = List.empty(growable: true);
  static int numPaginas = 1;
  static const int itemsPorPagina = 10;

  static void restart() {
    RankingData.avatar = List.empty(growable: true);
    RankingData.username = List.empty(growable: true);
    RankingData.elo = List.empty(growable: true);
    RankingData.rank = List.empty(growable: true);
  }

  static void add(String avatar, String username, int elo, int rank) {
    RankingData.avatar.add(avatar);
    RankingData.username.add(username);
    RankingData.elo.add(elo);
    RankingData.rank.add(rank);
  }
}
