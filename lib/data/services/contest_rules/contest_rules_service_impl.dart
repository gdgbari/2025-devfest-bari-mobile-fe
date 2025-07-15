import 'package:firebase_database/firebase_database.dart';

import 'contest_rules_service.dart';

class ContestRulesServiceImpl implements ContestRulesService {
  @override
  Stream<DatabaseEvent> get contestRulesStream {
    return FirebaseDatabase.instance
        .ref('contestRules')
        .onValue
        .asBroadcastStream();
  }
} 