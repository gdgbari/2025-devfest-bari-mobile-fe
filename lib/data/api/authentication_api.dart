import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfest_bari_2024/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationApi {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> getInitialAuthState() async {
    await for (final user in _firebaseAuth.authStateChanges()) {
      return user;
    }
    return null;
  }

  Future<ServerResponse> getUserProfile(User user) async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('getUserProfile')
        .call<String>();

    return ServerResponse.fromJson(result.data);
  }

  Future<ServerResponse> signUp({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    final result = await FirebaseFunctions.instance
        .httpsCallable('signUp')
        .call<String>({
      'name': name,
      'surname': surname,
      'email': email,
      'password': password
    });

    return ServerResponse.fromJson(result.data);
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
