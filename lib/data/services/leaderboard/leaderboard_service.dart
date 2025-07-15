import 'package:firebase_database/firebase_database.dart';

abstract class LeaderboardService {
  Stream<DatabaseEvent> get leaderboardStream;
}
