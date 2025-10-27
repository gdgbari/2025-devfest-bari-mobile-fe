import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class HttpClient {
  final Dio dio;

  HttpClient._internal(this.dio);

  static final HttpClient _instance = HttpClient._internal(
    Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
      ),
    ),
  );

  factory HttpClient() => _instance;

  void updateAccessToken(String accessToken) {
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  void removeAccessToken() {
    dio.options.headers.remove('Authorization');
  }
}