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

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.pageIndex = 0,
    this.leaderboard = const Leaderboard(),
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    int? pageIndex,
    Leaderboard? leaderboard,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      pageIndex: pageIndex ?? this.pageIndex,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  @override
  List<Object?> get props => [status, pageIndex, leaderboard];
}
