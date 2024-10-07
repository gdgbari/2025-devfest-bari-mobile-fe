import 'package:firebase_database/firebase_database.dart';

class LeaderboardApi {
  Stream<DatabaseEvent> get leaderboardStream {
    return FirebaseDatabase.instance
        .ref('leaderboard')
        .onValue
        .asBroadcastStream();
  }
}
