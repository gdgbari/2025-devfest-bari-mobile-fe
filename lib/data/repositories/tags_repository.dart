import 'package:devfest_bari_2025/data.dart';
import 'package:dio/dio.dart';

class TagsRepository {
  final TagsService _tagsService;

  const TagsRepository(this._tagsService);

  Future<int> assignTagBySecret(String secret) async {
    try {
      final response = await _tagsService.assignTagBySecret(secret);
      return response.data['points'] as int;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw TagNotFoundError();
        case 409:
          throw TagAlreadyAssignedError();
        default:
          throw UnknownTagError();
      }
    }
  }
}

class TagNotFoundError implements Exception {}

class TagAlreadyAssignedError implements Exception {}
