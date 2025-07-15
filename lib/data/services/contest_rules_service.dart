import 'package:firebase_database/firebase_database.dart';

class ContestRulesService {
  Stream<DatabaseEvent> get contestRulesStream {
    return FirebaseDatabase.instance
        .ref('contestRules')
        .onValue
        .asBroadcastStream();
  }
}
