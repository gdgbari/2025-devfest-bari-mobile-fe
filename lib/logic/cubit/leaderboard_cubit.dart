import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final _leaderboardRepo = LeaderboardRepository();

  LeaderboardCubit() : super(const LeaderboardState());

  void changeLeaderboard(int index) => emit(state.copyWith(pageIndex: index));

  Future<void> getLeaderboard() async {
    emit(const LeaderboardState()
        .copyWith(status: LeaderboardStatus.fetchInProgress));

    try {
      final leaderboard = await _leaderboardRepo.getLeaderboard();
      final groupMaxScore = leaderboard.groups
          .map((group) => group.score)
          .reduce((a, b) => a > b ? a : b);
      emit(
        state.copyWith(
          status: LeaderboardStatus.fetchSuccess,
          leaderboard: leaderboard,
          groupMaxScore: groupMaxScore,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: LeaderboardStatus.fetchFailure));
    }
  }
}
