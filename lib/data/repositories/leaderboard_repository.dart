import 'package:devfest_bari_2025/data.dart';

class LeaderboardRepository {
  final LeaderboardService _leaderboardService;

  const LeaderboardRepository(this._leaderboardService);

  Stream<Leaderboard> leaderboardStream(String userId) async* {
    await for (final leaderboard in _leaderboardService.leaderboardStream) {
      final currentUser = LeaderboardUser.fromJson(
        (leaderboard['users']['uid1'] as Map<String, dynamic>),
      );

      final users = (leaderboard['users'] as Map).values.toList();
      final groups = (leaderboard['groups'] as Map).values.toList();

      users.sort(
        (a, b) => b['score'] != a['score']
            ? b['score'].compareTo(a['score'])
            : b['timestamp'] != a['timestamp']
            ? a['timestamp'].compareTo(b['timestamp'])
            : a['nickname'].toLowerCase().compareTo(
                b['nickname'].toLowerCase(),
              ),
      );

      final upperLimit = users.length < 20 ? users.length : 20;

      yield Leaderboard(
        currentUser: currentUser,
        users: users
            .sublist(0, upperLimit)
            .map<LeaderboardUser>((user) => LeaderboardUser.fromJson(user))
            .toList(),
        groups: groups
            .map<LeaderboardGroup>((group) => LeaderboardGroup.fromJson(group))
            .toList(),
      );
    }
  }
}
