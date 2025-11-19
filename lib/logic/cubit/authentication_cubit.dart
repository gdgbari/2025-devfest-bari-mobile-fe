import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/logic.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;

  AuthenticationCubit(this._authRepo, this._userRepo)
    : super(const AuthenticationState()) {
    _getInitialAuthState();
  }

  Future<void> _getInitialAuthState() async {
    final user = await _authRepo.getInitialAuthState();
    if (user == null) {
      return emit(
        state.copyWith(status: AuthenticationStatus.initialAuthFailure),
      );
    }

    await _getUserProfile();
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
      final trimmedEmail = email.trim().toLowerCase();
      _validateSignUpData(nickname, name, surname, trimmedEmail, password);

      await _userRepo.signUp(
        nickname: nickname,
        name: name,
        surname: surname,
        email: trimmedEmail,
        password: password,
      );

      emit(state.copyWith(status: AuthenticationStatus.signUpSuccess));
      signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      final error = switch (e) {
        UserAlreadyRegisteredError _ =>
          AuthenticationError.userAlreadyRegistered,
        InvalidDataError _ => AuthenticationError.invalidCredentials,
        _ => AuthenticationError.unknown,
      };

      emit(
        state.copyWith(
          status: AuthenticationStatus.signUpFailure,
          error: error,
        ),
      );
    }
  }

  Future<void> checkIn() async {
    emit(state.copyWith(status: AuthenticationStatus.checkInInProgress));

    try {
      final group = await _userRepo.checkIn();

      emit(
        state.copyWith(
          userProfile: state.userProfile.copyWith(group: group),
          status: AuthenticationStatus.checkInSuccess,
        ),
      );
    } on Exception catch (e) {
      final error = switch (e) {
        _ => AuthenticationError.unknown,
      };

      emit(
        state.copyWith(
          status: AuthenticationStatus.checkInFailure,
          error: error,
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
        error: AuthenticationError.none,
      ),
    );

    try {
      final trimmedEmail = email.trim().toLowerCase();
      _validateSignInData(trimmedEmail, password);

      await _authRepo.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      await _getUserProfile();
    } on Exception catch (e) {
      await signOut();

      final error = switch (e) {
        UserNotFoundError _ => AuthenticationError.userNotFound,
        InvalidDataError _ => AuthenticationError.invalidCredentials,
        InvalidCredentialsError _ => AuthenticationError.invalidCredentials,
        _ => AuthenticationError.unknown,
      };

      emit(
        state.copyWith(
          status: AuthenticationStatus.authenticationFailure,
          error: error,
        ),
      );
    }
  }

  Future<void> _getUserProfile() async {
    final userProfile = await _userRepo.getCurrentUserData();

    emit(
      state.copyWith(
        userProfile: userProfile,
        status: userProfile.group.groupId.isEmpty
            ? AuthenticationStatus.checkInRequired
            : AuthenticationStatus.authenticationSuccess,
        isAuthenticated: true,
      ),
    );
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

  void _validateSignUpData(
    String nickname,
    String name,
    String surname,
    String email,
    String password,
  ) {
    final check =
        nickname.isNotEmpty &&
        name.isNotEmpty &&
        surname.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty;

    if (!check) throw InvalidDataError();

    InputValidators.checkEmail(email);
    InputValidators.checkPassword(password);
  }

  void _validateSignInData(String email, String password) {
    final check = email.isNotEmpty && password.isNotEmpty;

    if (!check) throw InvalidDataError();

    InputValidators.checkEmail(email);
    InputValidators.checkPassword(password);
  }

  void updatePosition(int userPosition, int groupPosition) {
    emit(
      state.copyWith(
        userProfile: state.userProfile.copyWith(
          group: state.userProfile.group.copyWith(position: groupPosition),
          position: userPosition,
        ),
      ),
    );
  }
}
