part of 'authentication_cubit.dart';

enum AuthenticationStatus {
  initial,
  authenticationInProgress,
  authenticationSuccess,
  authenticationFailure,
  signOutInProgress,
  signOutSuccess,
}

class AuthenticationState extends Equatable {
  final UserProfile user;
  final AuthenticationStatus status;
  final bool isAuthenticated;

  const AuthenticationState({
    this.user = const UserProfile(),
    this.status = AuthenticationStatus.initial,
    this.isAuthenticated = false,
  });

  AuthenticationState copyWith({
    UserProfile? user,
    AuthenticationStatus? status,
    bool? isAuthenticated,
  }) {
    return AuthenticationState(
      user: user ?? this.user,
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [user, status, isAuthenticated];
}
