import 'dart:io';

import 'package:buku_penghubung/firebase_options.dart';
import 'package:buku_penghubung/src/app.dart';
import 'package:buku_penghubung/src/config/config.dart';
import 'package:buku_penghubung/src/di/injection_container.dart';
import 'package:buku_penghubung/src/di/utilities/utilities.dart';
import 'package:buku_penghubung/src/utilities/logs/logs.dart';
import 'package:buku_penghubung/src/utilities/platforms/platforms.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  // Make sure all is initialized before we configure everything.
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Theme.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Dependencies.
  // HttpOverrides.global = IsrgOverrides();
  await configureDependencies(
    environmentFilter: NoEnvOrContainsAny(
      {
        Config.buildVariant,
        Platform.operatingSystem,
      },
    ),
  );

  // Timezone and TimeFormat
  await initializeDateFormatting('id_ID', null);
  Intl.defaultLocale = 'id_ID';

  // Logging
  if (Config.debug) {
    Fimber.plantTree(
      DevTree(useColors: inject<DevicePlatformInfo>().isAndroid),
    );
  } else {
    Fimber.plantTree(CrashlyticsTree());
  }

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = inject<DefaultBlocObserver>();
  runApp(const MainApp());
}
