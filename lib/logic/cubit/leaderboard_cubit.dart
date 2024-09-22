import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(const LeaderboardState());

  void changeLeaderboard(int index) => emit(state.copyWith(pageIndex: index));
}
