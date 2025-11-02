import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final AuthenticationService _authService;

  const AuthenticationRepository(this._authService);

  Future<User?> getInitialAuthState() async {
    final user = await _authService.getInitialAuthState();
    if (user == null) return null;
    await _authService.updateToken();
    return user;
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      await _authService.updateToken();
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundError();
        case 'invalid-credential':
        case 'invalid-email':
        case 'invalid-password':
        case 'wrong-password':
          throw InvalidCredentialsError();
        default:
          throw UnknownAuthenticationError();
      }
    } on Exception {
      throw UnknownAuthenticationError();
    }
  }

  Future<void> refreshToken() async {
    await _authService.updateToken(forceRefresh: true);
  }

  Future<void> signOut() async {
    await _authService.signOut();
    HttpClient().removeAccessToken();
  }
}
