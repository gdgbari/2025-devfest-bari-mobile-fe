part of 'tags_cubit.dart';

enum TagsStatus { initial, loading, success, failure }

enum TagsError { tagNotFound, tagAlreadyAssigned, unknown }

class TagsState extends Equatable {
  final TagsStatus status;
  final TagsError? error;
  final int? points;

  const TagsState({this.status = TagsStatus.initial, this.error, this.points});

  TagsState copyWith({TagsStatus? status, TagsError? error, int? points}) {
    return TagsState(
      status: status ?? this.status,
      error: error,
      points: points ?? this.points,
    );
  }

  @override
  List<Object?> get props => [status, error, points];
}
