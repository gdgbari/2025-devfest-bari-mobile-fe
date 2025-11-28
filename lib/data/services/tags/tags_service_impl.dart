import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class TagsServiceImpl implements TagsService {
  TagsServiceImpl();

  final Dio _dio = HttpClient().dio;
  final String _endpoint = '/tags';

  @override
  Future<Response> assignTagBySecret(String secret) async {
    try {
      return await _dio.post(
        '$_endpoint/assign-secret',
        data: {'secret': secret},
      );
    } on DioException catch (e) {
      if (e.response != null) {
        // Pass the response error through so the repository/cubit can handle specific status codes
        rethrow;
      }
      throw UnknownTagError();
    }
  }
}

class UnknownTagError implements Exception {}
