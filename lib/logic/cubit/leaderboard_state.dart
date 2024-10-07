part of 'leaderboard_cubit.dart';

enum LeaderboardStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
}

class LeaderboardState extends Equatable {
  final LeaderboardStatus status;
  final int pageIndex;
  final Leaderboard leaderboard;
  final int groupMaxScore;

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.pageIndex = 0,
    this.leaderboard = const Leaderboard(),
    this.groupMaxScore = 0,
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    int? pageIndex,
    Leaderboard? leaderboard,
    int? groupMaxScore,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      pageIndex: pageIndex ?? this.pageIndex,
      leaderboard: leaderboard ?? this.leaderboard,
      groupMaxScore: groupMaxScore ?? this.groupMaxScore,
    );
  }

  @override
  List<Object?> get props => [status, pageIndex, leaderboard, groupMaxScore];
}
