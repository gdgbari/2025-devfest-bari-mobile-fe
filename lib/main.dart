import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2024/app.dart';
import 'package:devfest_bari_2024/firebase_options.dart';
import 'package:devfest_bari_2024/logic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() async {
  runZonedGuarded(
    () async {
      await _initialization();
      Bloc.observer = DebugBloc();
      runApp(const App());
    },
    (error, stack) {
      // TODO: implement error handling
    },
  );
}

Future<void> _initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
