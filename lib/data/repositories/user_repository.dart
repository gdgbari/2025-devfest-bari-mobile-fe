import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/logic/input_validators.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final UserService _userService;

  const UserRepository(this._userService);

  Future<void> signUp({
    required String nickname,
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> userData = {
        'nickname': nickname,
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
      };
      await _userService.signUp(userData);
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 422:
            throw InvalidDataError();
          case 409:
            throw UserAlreadyRegisteredError();
          default:
            throw UnknownAuthenticationError();
        }
      } else {
        throw UnknownAuthenticationError();
      }
    }
  }

  Future<UserProfile> getCurrentUserData() async {
    try {
      final response = await _userService.getCurrentUserData();
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 404:
            throw UserNotFoundError();
          default:
            throw UnknownAuthenticationError();
        }
      } else {
        throw UnknownAuthenticationError();
      }
    }
  }

  Future<Group> checkIn() async {
    try {
      final response = await _userService.checkIn();
      return Group.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          default:
            throw UnknownAuthenticationError();
        }
      } else {
        throw UnknownAuthenticationError();
      }
    }
  }
}
