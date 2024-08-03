import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final _authRepo = AuthenticationRepository();

  AuthenticationCubit() : super(const AuthenticationState()) {
    _getInitialAuthState();
  }

  Future<void> _getInitialAuthState() async {
    final user = await _authRepo.getInitialAuthState();
    if (user.userId.isNotEmpty) {
      emit(
        state.copyWith(
          userProfile: user,
          status: AuthenticationStatus.authenticationSuccess,
          isAuthenticated: true,
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        userProfile: const UserProfile(),
        status: AuthenticationStatus.authenticationInProgress,
        isAuthenticated: false,
      ),
    );

    try {
      final user = await _authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(
        state.copyWith(
          userProfile: user,
          status: AuthenticationStatus.authenticationSuccess,
          isAuthenticated: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthenticationStatus.authenticationFailure));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthenticationStatus.signOutInProgress));
    await _authRepo.signOut();
    emit(
      state.copyWith(
        userProfile: const UserProfile(),
        status: AuthenticationStatus.signOutSuccess,
        isAuthenticated: false,
      ),
    );
  }
}
