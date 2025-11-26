part of 'activities_cubit.dart';

enum ActivitiesStatus { initial, fetchInProgress, fetchSuccess, fetchFailure }

class ActivitiesState extends Equatable {
  final ActivitiesStatus status;
  final List<Activity> activities;

  const ActivitiesState({
    this.status = ActivitiesStatus.initial,
    this.activities = const [],
  });

  ActivitiesState copyWith({
    ActivitiesStatus? status,
    List<Activity>? activities,
  }) {
    return ActivitiesState(
      status: status ?? this.status,
      activities: activities ?? this.activities,
    );
  }

  @override
  List<Object> get props => [status, activities];
}
