import 'package:devfest_bari_2025/data.dart';

class LeaderboardRepository {
  final LeaderboardService _leaderboardService;

  const LeaderboardRepository(this._leaderboardService);

  Stream<List<LeaderboardUser>> userLeaderboardStream() async* {
    final source = _leaderboardService.userLeaderboardStream;
    await for (final userLeaderboard in source) {
      final users = userLeaderboard.values
          .map((user) => LeaderboardUser.fromJson(user))
          .toList();

      users.sort(
        (a, b) => b.score != a.score
            ? b.score.compareTo(a.score)
            : b.updatedAt != a.updatedAt
            ? a.updatedAt.compareTo(b.updatedAt)
            : a.nickname.toLowerCase().compareTo(b.nickname.toLowerCase()),
      );

      for (var i = 0; i < users.length; i++) {
        users[i] = users[i].copyWith(position: i + 1);
      }

      final upperLimit = users.length < 20 ? users.length : 20;

      yield users.sublist(0, upperLimit);
    }
  }

  Stream<List<LeaderboardGroup>> groupLeaderboardStream() async* {
    final source = _leaderboardService.groupLeaderboardStream;
    await for (final groupLeaderboard in source) {
      final groups = groupLeaderboard.values
          .map((group) => LeaderboardGroup.fromJson(group))
          .toList();

      groups.sort(
        (a, b) => b.score != a.score
            ? b.score.compareTo(a.score)
            : b.updatedAt != a.updatedAt
            ? a.updatedAt.compareTo(b.updatedAt)
            : a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );

      for (var i = 0; i < groups.length; i++) {
        groups[i] = groups[i].copyWith(position: i + 1);
      }

      yield groups;
    }
  }
}
