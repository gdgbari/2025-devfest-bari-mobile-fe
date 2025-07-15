import 'package:firebase_database/firebase_database.dart';

import 'leaderboard_service.dart';

class LeaderboardServiceImpl implements LeaderboardService {
  @override
  Stream<DatabaseEvent> get leaderboardStream {
    return FirebaseDatabase.instance
        .ref('leaderboard')
        .onValue
        .asBroadcastStream();
  }
} 