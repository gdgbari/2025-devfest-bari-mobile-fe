import 'package:devfest_bari_2025/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<User?> getInitialAuthState();
  Future<ServerResponse> getUserProfile(User user);
  Future<ServerResponse> signUp({
    required String nickname,
    required String name,
    required String surname,
    required String email,
    required String password,
  });
  Future<ServerResponse> checkIn(String authorizationCode);
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
