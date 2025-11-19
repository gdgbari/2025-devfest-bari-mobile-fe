import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_bari_2025/data.dart';

class LeaderboardServiceImpl implements LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<Map<String, dynamic>> get userLeaderboardStream async* {
    yield* _firestore
        .collection('leaderboard_users')
        .snapshots()
        .map(
          (snapshot) => {for (final doc in snapshot.docs) doc.id: doc.data()},
        );
  }

  @override
  Stream<Map<String, dynamic>> get groupLeaderboardStream async* {
    yield* _firestore
        .collection('leaderboard_groups')
        .snapshots()
        .map(
          (snapshot) => {for (final doc in snapshot.docs) doc.id: doc.data()},
        );
  }
}
