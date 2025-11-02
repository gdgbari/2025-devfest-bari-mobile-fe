import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<User?> getInitialAuthState();

  Future<void> updateToken({bool forceRefresh});

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
