import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationServiceImpl() {
    HttpClient().dio.interceptors.add(AuthenticationInterceptor(this));
  }

  @override
  Future<User?> getInitialAuthState() async {
    await for (final user in _firebaseAuth.authStateChanges()) {
      return user;
    }
    return null;
  }

  @override
  Future<void> updateToken({bool forceRefresh = false}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken(forceRefresh);
    if (token != null) {
      HttpClient().updateAccessToken(token);
    }
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
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    HttpClient().removeAccessToken();
  }
}
