import 'package:cloud_firestore/cloud_firestore.dart';

extension DocumentSnapshotExtensions on DocumentSnapshot {
  String? getIdFromRef(String field) {
    final ref = get(field);
    if (ref is! DocumentReference) return null;
    return ref.id;
  }

  Future<T?> getDataFromRef<T>(String field) async {
    final ref = get(field);
    if (ref is! DocumentReference) return null;
    final doc = await ref.get();
    if (!doc.exists) return null;
    return doc.data() as T?;
  }
}
