abstract class LeaderboardService {
  Stream<Map<String, dynamic>> get userLeaderboardStream;
  Stream<Map<String, dynamic>> get groupLeaderboardStream;
}
