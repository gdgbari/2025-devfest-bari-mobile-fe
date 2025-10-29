import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_bari_2025/data.dart';

class LeaderboardServiceImpl implements LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<Map<String, dynamic>> get leaderboardStream async* {
    yield* _firestore
        .collection('leaderboard')
        .snapshots()
        .map(
          (snapshot) => {for (final doc in snapshot.docs) doc.id: doc.data()},
        );
  }
}
