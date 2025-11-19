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
  final LeaderboardUser currentUser;
  final List<LeaderboardUser> leaderboardUsers;
  final List<LeaderboardGroup> leaderboardGroups;
  final int groupMaxScore;

  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.pageIndex = 0,
    this.currentUser = const LeaderboardUser(),
    this.leaderboardUsers = const [],
    this.leaderboardGroups = const [],
    this.groupMaxScore = 0,
  });

  LeaderboardGroup get currentGroup => leaderboardGroups.firstWhere(
    (group) => group.color == currentUser.groupColor,
  );

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    int? pageIndex,
    LeaderboardUser? currentUser,
    List<LeaderboardUser>? leaderboardUsers,
    List<LeaderboardGroup>? leaderboardGroups,
    int? groupMaxScore,
  }) {
    return LeaderboardState(
      status: status ?? this.status,
      pageIndex: pageIndex ?? this.pageIndex,
      currentUser: currentUser ?? this.currentUser,
      leaderboardUsers: leaderboardUsers ?? this.leaderboardUsers,
      leaderboardGroups: leaderboardGroups ?? this.leaderboardGroups,
      groupMaxScore: groupMaxScore ?? this.groupMaxScore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        pageIndex,
        currentUser,
        leaderboardUsers,
        leaderboardGroups,
        groupMaxScore,
      ];
}
