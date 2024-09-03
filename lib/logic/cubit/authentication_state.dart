part of 'authentication_cubit.dart';

enum AuthenticationStatus {
  initial,
  initialAuthFailure,
  authenticationInProgress,
  authenticationSuccess,
  authenticationFailure,
  signOutInProgress,
  signOutSuccess,
}

enum AuthenticationError {
  none,
  userNotFound,
  invalidCredentials,
  missingUserData,
  unknown,
}

class AuthenticationState extends Equatable {
  final UserProfile userProfile;
  final AuthenticationStatus status;
  final bool isAuthenticated;
  final AuthenticationError error;

  const AuthenticationState({
    this.userProfile = const UserProfile(),
    this.status = AuthenticationStatus.initial,
    this.isAuthenticated = false,
    this.error = AuthenticationError.none,
  });

  AuthenticationState copyWith({
    UserProfile? userProfile,
    AuthenticationStatus? status,
    bool? isAuthenticated,
    AuthenticationError? error,
  }) {
    return AuthenticationState(
      userProfile: userProfile ?? this.userProfile,
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [userProfile, status, isAuthenticated, error];
}
