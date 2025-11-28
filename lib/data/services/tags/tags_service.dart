import 'package:dio/dio.dart';

abstract class TagsService {
  Future<Response> assignTagBySecret(String secret);
}
