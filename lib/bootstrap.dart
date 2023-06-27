import 'dart:async';
import 'dart:developer';

import 'package:dependencies/firebase_core/firebase_core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/material.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await di.init();

      runApp(await builder());

      // //* Firebase Performance
      // FirebasePerformance.instance;

      // //* Firebase Analytics
      // FirebaseAnalytics.instance;

      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    },
    (error, stackTrace) async {
      log(error.toString(), stackTrace: stackTrace);
      // await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
