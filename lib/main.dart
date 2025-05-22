import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_observer.dart';
import 'app/presentation/widgets/app.dart';
import 'core/utils/logger.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "S_C");

  await di.init(
    firebaseApp: app,
  );
  await runZonedGuarded(
    () async {
      Bloc.observer = AppBlocObserver();
      runApp(const MyApp());
    },
    (error, stackTrace) => AppLogger.instance.e(error.toString()),
  );
}
