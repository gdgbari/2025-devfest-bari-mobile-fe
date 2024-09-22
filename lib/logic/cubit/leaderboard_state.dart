part of 'leaderboard_cubit.dart';

enum LeaderboardStatus {
  initial,
}

class LeaderboardState extends Equatable {
  final LeaderboardStatus status;
  final int pageIndex;

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.pageIndex = 0,
  });

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    int? pageIndex,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object> get props => [status, pageIndex];
}
