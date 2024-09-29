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
    } else {
      emit(state.copyWith(status: AuthenticationStatus.initialAuthFailure));
    }
  }

  Future<void> signUp({
    required String nickname,
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        userProfile: const UserProfile(),
        status: AuthenticationStatus.signUpInProgress,
        isAuthenticated: false,
        error: AuthenticationError.none,
      ),
    );

    try {
      _checkEmptyData(name, surname, email, password);

      _checkEmail(email);

      await _authRepo.signUp(
        nickname: nickname,
        name: name,
        surname: surname,
        email: email,
        password: password,
      );

      emit(state.copyWith(status: AuthenticationStatus.signUpSuccess));
      signInWithEmailAndPassword(email: email, password: password);
    } on Exception {
      emit(state.copyWith(status: AuthenticationStatus.signUpFailure));
    }
  }

  void _checkEmptyData(
    String name,
    String surname,
    String email,
    String password,
  ) {
    final check = name.isNotEmpty &&
        surname.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty;

    if (!check) throw Exception();
  }

  void _checkEmail(String email) {
    var check = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$",
    ).hasMatch(email);

    if (!check) throw Exception();
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
        error: AuthenticationError.none,
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
    } on UserNotFoundError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.userNotFound,
        ),
      );
    } on InvalidCredentialsError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.invalidCredentials,
        ),
      );
    } on MissingUserDataError {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.missingUserData,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: AuthenticationError.unknown,
        ),
      );
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
