import 'package:firebase_database/firebase_database.dart';

class EasterEggApi {
  Stream<DatabaseEvent> get easterEggStream {
    return FirebaseDatabase.instance
        .ref('easterEggMessage')
        .onValue
        .asBroadcastStream();
  }
}
