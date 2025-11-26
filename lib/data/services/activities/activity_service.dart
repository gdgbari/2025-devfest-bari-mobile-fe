import 'package:dio/dio.dart';

abstract class ActivityService {
  Future<Response> getActivities(String userId);
}
