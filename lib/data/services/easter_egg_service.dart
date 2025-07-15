import 'package:firebase_database/firebase_database.dart';

class EasterEggService {
  Stream<DatabaseEvent> get easterEggStream {
    return FirebaseDatabase.instance
        .ref('easterEggMessage')
        .onValue
        .asBroadcastStream();
  }
}
