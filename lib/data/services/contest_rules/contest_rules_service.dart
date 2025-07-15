import 'package:firebase_database/firebase_database.dart';

abstract class ContestRulesService {
  Stream<DatabaseEvent> get contestRulesStream;
}
