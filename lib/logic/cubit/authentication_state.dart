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
  final UserProfile userProfile;
  final AuthenticationStatus status;
  final bool isAuthenticated;

  const AuthenticationState({
    this.userProfile = const UserProfile(),
    this.status = AuthenticationStatus.initial,
    this.isAuthenticated = false,
  });

  AuthenticationState copyWith({
    UserProfile? userProfile,
    AuthenticationStatus? status,
    bool? isAuthenticated,
  }) {
    return AuthenticationState(
      userProfile: userProfile ?? this.userProfile,
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [userProfile, status, isAuthenticated];
}
