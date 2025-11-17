import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepository _leaderboardRepo;
  StreamSubscription? _userStreamSub;
  StreamSubscription? _groupStreamSub;

  LeaderboardCubit(this._leaderboardRepo) : super(const LeaderboardState());

  void changeLeaderboard(int index) => emit(state.copyWith(pageIndex: index));

  void fetchLeaderboard(String currentUserNickname) {
    emit(state.copyWith(status: LeaderboardStatus.fetchInProgress));
    stopLeaderboardFetch();

    try {
      final userStream = _leaderboardRepo
          .userLeaderboardStream()
          .asBroadcastStream();

      final groupStream = _leaderboardRepo
          .groupLeaderboardStream()
          .asBroadcastStream();

      _userStreamSub = userStream.listen(
        (users) {
          final currentUser = users.firstWhere(
            (user) => user.nickname == currentUserNickname,
            orElse: () => LeaderboardUser(nickname: currentUserNickname),
          );

          emit(
            state.copyWith(
              status: LeaderboardStatus.fetchSuccess,
              leaderboardUsers: users,
              currentUser: currentUser,
            ),
          );
        },
        onError: (_) {
          emit(state.copyWith(status: LeaderboardStatus.fetchFailure));
        },
      );

      _groupStreamSub = groupStream.listen(
        (groups) {
          final groupMaxScore = groups
              .map((group) => group.score)
              .reduce((a, b) => a > b ? a : b);

          emit(
            state.copyWith(
              status: LeaderboardStatus.fetchSuccess,
              leaderboardGroups: groups,
              groupMaxScore: groupMaxScore,
            ),
          );
        },
        onError: (_) {
          emit(state.copyWith(status: LeaderboardStatus.fetchFailure));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: LeaderboardStatus.fetchFailure));
    }
  }

  void stopLeaderboardFetch() {
    _userStreamSub?.cancel();
    _groupStreamSub?.cancel();
  }
}
