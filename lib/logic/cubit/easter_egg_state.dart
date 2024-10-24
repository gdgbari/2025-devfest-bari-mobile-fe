part of 'easter_egg_cubit.dart';

enum EasterEggStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
}

class EasterEggState extends Equatable {
  final EasterEggStatus status;
  final String easterEggMessage;

  const EasterEggState({
    this.status = EasterEggStatus.initial,
    this.easterEggMessage = '',
  });

  EasterEggState copyWith({
    EasterEggStatus? status,
    String? easterEggMessage,
  }) {
    return EasterEggState(
      status: status ?? this.status,
      easterEggMessage: easterEggMessage ?? this.easterEggMessage,
    );
  }

  @override
  List<Object> get props => [status, easterEggMessage];
}
