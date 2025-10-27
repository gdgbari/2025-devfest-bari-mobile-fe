import 'package:dio/dio.dart';

abstract class UserService {
  Future<Response> signUp(Map<String, dynamic> userData);

  Future<Response> getCurrentUserData();

  Future<Response> checkIn();
}