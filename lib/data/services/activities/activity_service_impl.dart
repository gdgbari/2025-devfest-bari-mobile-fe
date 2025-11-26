import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class ActivityServiceImpl implements ActivityService {
  ActivityServiceImpl();

  final Dio _dio = HttpClient().dio;
  final String _endpoint = '/activities';

  @override
  Future<Response> getActivities(String userId) async {
    return Response(
      requestOptions: RequestOptions(),
      data: {
        [
          {'id': '1', 'name': 'Activity 1', 'isCompleted': true},
          {'id': '2', 'name': 'Activity 2', 'isCompleted': false},
          {'id': '3', 'name': 'Activity 3', 'isCompleted': false},
          {'id': '4', 'name': 'Activity 4', 'isCompleted': false},
          {'id': '5', 'name': 'Activity 5', 'isCompleted': false},
        ],
      },
    );
    // return _dio.get('$_endpoint/$userId');
  }
}
