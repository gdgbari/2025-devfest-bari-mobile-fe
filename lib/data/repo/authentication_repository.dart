import 'package:devfest_bari_2024/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  AuthenticationRepository._internal();

  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();

  factory AuthenticationRepository() => _instance;

  final AuthenticationApi _authApi = AuthenticationApi();

  Future<UserProfile> getInitialAuthState() async {
    final firebaseUser = await _authApi.getInitialAuthState();
    if (firebaseUser != null) {
      return await getUserProfile(firebaseUser);
    } else {
      return const UserProfile();
    }
  }

  Future<UserProfile> getUserProfile(User user) async {
    try {
      final rawUserProfile = await _authApi.getUserProfile(user);
      return UserProfile.fromJson(rawUserProfile);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authApi.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null
          ? await getUserProfile(userCredential.user!)
          : const UserProfile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async => await _authApi.signOut();
}
