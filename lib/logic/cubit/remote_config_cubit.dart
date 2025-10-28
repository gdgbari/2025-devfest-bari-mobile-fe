import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final RemoteConfigRepository _configRepo;
  StreamSubscription? _subscription;

  RemoteConfigCubit(this._configRepo) : super(const RemoteConfigState()) {
    listenToRemoteConfig();
  }

  void listenToRemoteConfig() {
    _subscription?.cancel();
    emit(RemoteConfigState(status: RemoteConfigStatus.listenInProgress));

    _subscription = _configRepo.config.listen(
      (config) {
        emit(
          state.copyWith(
            status: RemoteConfigStatus.listenSuccess,
            config: config,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(status: RemoteConfigStatus.listenFailure));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
