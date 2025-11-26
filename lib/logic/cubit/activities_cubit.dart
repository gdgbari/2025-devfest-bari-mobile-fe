import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devfest_bari_2025/data.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final ActivityRepository _activityRepository;

  ActivitiesCubit(this._activityRepository) : super(ActivitiesState());

  Future<void> fetchActivities(String userId) async {
    emit(state.copyWith(status: ActivitiesStatus.fetchInProgress));
    try {
      final activities = await _activityRepository.getActivities(userId);
      emit(
        state.copyWith(
          status: ActivitiesStatus.fetchSuccess,
          activities: activities,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ActivitiesStatus.fetchFailure));
    }
  }
}
