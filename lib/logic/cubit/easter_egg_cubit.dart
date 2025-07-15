import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

part 'easter_egg_state.dart';

class EasterEggCubit extends Cubit<EasterEggState> {
  final EasterEggRepository _easterEggRepo;
  StreamSubscription? _streamSub;

  EasterEggCubit(this._easterEggRepo) : super(EasterEggState()) {
    fetchEasterEgg();
  }

  void fetchEasterEgg() {
    emit(state.copyWith(status: EasterEggStatus.fetchInProgress));
    stopEasterEggFetch();

    try {
      final stream = _easterEggRepo.easterEggStream().asBroadcastStream();
      _streamSub = stream.listen(
        (easterEgg) {
          emit(
            state.copyWith(
              status: EasterEggStatus.fetchSuccess,
              easterEggMessage: easterEgg,
            ),
          );
        },
        onError: (_) {
          emit(state.copyWith(status: EasterEggStatus.fetchFailure));
        },
      );
    } catch (e) {
      emit(state.copyWith(status: EasterEggStatus.fetchFailure));
    }
  }

  void stopEasterEggFetch() => _streamSub?.cancel();
}
