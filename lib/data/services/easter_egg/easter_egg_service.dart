import 'package:firebase_database/firebase_database.dart';

abstract class EasterEggService {
  Stream<DatabaseEvent> get easterEggStream;
}
