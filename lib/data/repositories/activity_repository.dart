import 'package:devfest_bari_2025/data.dart';

class ActivityRepository {
  final ActivityService _activityService;

  ActivityRepository(this._activityService);

  Future<List<Activity>> getActivities(String userId) async {
    final response = await _activityService.getActivities(userId);
    final activities = response.data as List;
    return activities.map((activity) => Activity.fromJson(activity)).toList();
  }
}
