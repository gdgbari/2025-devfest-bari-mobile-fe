import 'package:firebase_database/firebase_database.dart';

import 'easter_egg_service.dart';

class EasterEggServiceImpl implements EasterEggService {
  @override
  Stream<DatabaseEvent> get easterEggStream {
    return FirebaseDatabase.instance
        .ref('easterEggMessage')
        .onValue
        .asBroadcastStream();
  }
} 