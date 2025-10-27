import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<User?> getInitialAuthState();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
