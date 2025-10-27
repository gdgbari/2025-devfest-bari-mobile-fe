import 'package:devfest_bari_2025/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationServiceImpl();

  @override
  Future<User?> getInitialAuthState() async {
    await for (final user in _firebaseAuth.authStateChanges()) {
      return user;
    }
    return null;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
