import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_bari_2025/data.dart';

class RemoteConfigServiceImpl implements RemoteConfigService {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<Map<String, dynamic>> get config {
    return _firestore
        .collection('remoteConfig')
        .doc('config')
        .snapshots()
        .map((event) => event.data() ?? {});
  }
}
