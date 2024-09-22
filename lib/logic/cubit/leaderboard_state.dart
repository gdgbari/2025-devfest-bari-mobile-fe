// part of 'leaderboard_cubit.dart';
//
// enum LeaderboardStatus {
//   initial,
//   fetchInProgress,
//   fetchSuccess,
//   fetchFailure,
// }
//
// class LeaderboardState extends Equatable {
//   final LeaderboardStatus status;
//   final List<LeaderboardEntry> entries;
//
//   const LeaderboardState({
//     this.status = LeaderboardStatus.initial,
//     this.entries = const [],
//   });
//
//   LeaderboardState copyWith({
//     LeaderboardStatus? status,
//     List<LeaderboardEntry>? entries,
//   }) {
//     return LeaderboardState(
//       status: status ?? this.status,
//       entries: entries ?? this.entries,
//     );
//   }
//
//   @override
//   List<Object?> get props => [status, entries];
// }
