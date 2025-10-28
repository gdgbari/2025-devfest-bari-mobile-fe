part of 'remote_config_cubit.dart';

enum RemoteConfigStatus {
  initial,
  listenInProgress,
  listenSuccess,
  listenFailure,
}

class RemoteConfigState extends Equatable {
  final RemoteConfigStatus status;
  final RemoteConfig config;

  const RemoteConfigState({
    this.status = RemoteConfigStatus.initial,
    this.config = const RemoteConfig(),
  });

  RemoteConfigState copyWith({
    RemoteConfigStatus? status,
    RemoteConfig? config,
  }) {
    return RemoteConfigState(
      status: status ?? this.status,
      config: config ?? this.config,
    );
  }

  @override
  List<Object> get props => [status, config];
}
