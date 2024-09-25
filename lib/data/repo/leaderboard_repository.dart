import 'package:devfest_bari_2024/data.dart';

class LeaderboardRepository {
  LeaderboardRepository._internal();

  static final LeaderboardRepository _instance =
      LeaderboardRepository._internal();

  factory LeaderboardRepository() => _instance;

  final LeaderboardApi _leaderboardApi = LeaderboardApi();

  Future<Leaderboard> getLeaderboard() async {
    try {
      final response = await _leaderboardApi.getLeaderboard();

      if (response.error.code.isNotEmpty) {
        // TODO: handle errors
        throw UnknownLeaderboardError();
      }

      return Leaderboard.fromJson(response.data);
    } on Exception {
      throw UnknownLeaderboardError();
    }
  }
}
