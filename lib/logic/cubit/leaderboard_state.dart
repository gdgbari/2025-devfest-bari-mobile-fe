part of 'leaderboard_cubit.dart';

enum LeaderboardStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
}

class LeaderboardState extends Equatable {
  final LeaderboardStatus status;
  final Leaderboard leaderboard;

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.leaderboard = const Leaderboard(),
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    Leaderboard? leaderboard,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      leaderboard: leaderboard ?? this.leaderboard,
    );
  }

  @override
  List<Object?> get props => [status, leaderboard];
}
