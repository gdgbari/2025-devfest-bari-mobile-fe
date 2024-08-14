part of 'talk_cubit.dart';

enum TalkStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
  selectionInProgress,
  selectionSuccess,
}

class TalkState extends Equatable {
  final TalkStatus status;
  final List<Talk> talkList;
  final Talk selectedTalk;

  const TalkState({
    this.status = TalkStatus.initial,
    this.talkList = const [],
    this.selectedTalk = const Talk(),
  });

  TalkState copyWith({
    TalkStatus? status,
    List<Talk>? talkList,
    Talk? selectedTalk,
  }) {
    return TalkState(
      status: status ?? this.status,
      talkList: talkList ?? this.talkList,
      selectedTalk: selectedTalk ?? this.selectedTalk,
    );
  }

  @override
  List<Object> get props => [status, talkList, selectedTalk];
}
