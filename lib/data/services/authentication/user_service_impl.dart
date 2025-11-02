import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class UserServiceImpl extends UserService {
  final Dio _dio = HttpClient().dio;
  final String _endpoint = '/users';

  @override
  Future<Response> signUp(Map<String, dynamic> userData) async {
    return await _dio.post(_endpoint, data: userData);
  }

  @override
  Future<Response> getCurrentUserData() async {
    return await _dio.get('$_endpoint/me');
  }

  @override
  Future<Response> checkIn() async {
    return await _dio.post('$_endpoint/check-in');
  }
}
