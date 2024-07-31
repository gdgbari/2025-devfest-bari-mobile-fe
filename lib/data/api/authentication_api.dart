import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationApi {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> getInitialAuthState() async {
    await for (final user in _firebaseAuth.authStateChanges()) {
      return user;
    }
    return null;
  }

  Future<Map<String, dynamic>> getUserData(User user) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getUserData')
          .call<Map<String, dynamic>>();

      return result.data;
    } on FirebaseFunctionsException {
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async => await _firebaseAuth.signOut();
}
