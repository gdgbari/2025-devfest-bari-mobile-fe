import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

part 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  final TagsRepository _tagsRepository;

  TagsCubit(this._tagsRepository) : super(const TagsState());

  Future<void> assignTag(String secret) async {
    emit(state.copyWith(status: TagsStatus.loading));

    try {
      final points = await _tagsRepository.assignTagBySecret(secret);
      emit(state.copyWith(status: TagsStatus.success, points: points));
    } on TagNotFoundError {
      emit(
        state.copyWith(
          status: TagsStatus.failure,
          error: TagsError.tagNotFound,
        ),
      );
    } on TagAlreadyAssignedError {
      emit(
        state.copyWith(
          status: TagsStatus.failure,
          error: TagsError.tagAlreadyAssigned,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: TagsStatus.failure, error: TagsError.unknown),
      );
    }
  }

  void reset() {
    emit(const TagsState());
  }
}
