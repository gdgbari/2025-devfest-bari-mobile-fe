import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  static InternetCubit? _instance;

  factory InternetCubit() {
    return _instance ??= InternetCubit._internal();
  }

  InternetCubit._internal() : super(InternetLoading());

  StreamSubscription? connectivityStreamSubscription;

  StreamSubscription<List<ConnectivityResult>> monitorInternetConnection() {
    final connectivityStream = Connectivity().onConnectivityChanged;
    connectivityStreamSubscription?.cancel();
    return connectivityStreamSubscription = connectivityStream.listen(
      (connectivityResults) {
        connectivityResults.first == ConnectivityResult.none
            ? sendInternetFailure()
            : sendInternetResume();
      },
    );
  }

  void sendInternetFailure() => emit(InternetDisconnected());

  void sendInternetResume() => emit(InternetConnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
