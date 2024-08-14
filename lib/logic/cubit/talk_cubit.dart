import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

part 'talk_state.dart';

class TalkCubit extends Cubit<TalkState> {
  final _talkRepo = TalkRepository();
  TalkCubit() : super(const TalkState());

  Future<void> getTalkList() async {
    emit(state.copyWith(status: TalkStatus.fetchInProgress));

    try {
      final talkList = await _talkRepo.getTalkList();
      emit(
        state.copyWith(
          talkList: talkList,
          status: TalkStatus.fetchSuccess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: TalkStatus.fetchFailure));
    }
  }

  void selectAnswer(Talk selectedTalk) {
    emit(state.copyWith(status: TalkStatus.selectionInProgress));
    emit(
      state.copyWith(
        selectedTalk: selectedTalk,
        status: TalkStatus.selectionSuccess,
      ),
    );
  }
}
