import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextalk_community/core/constants/app_constants.dart';
import 'package:nextalk_community/core/providers/theme_provider.dart';
import 'package:nextalk_community/core/utils/theme_utils.dart';
import 'package:nextalk_community/features/home/home.dart';

Future<void> _initializeCrashlytics() async {
  try {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      kReleaseMode,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      if (kDebugMode) {
        FlutterError.presentError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    debugPrint("=>Firebase Crashlytics initialized (enabled: $kReleaseMode)");
  } catch (e, stackTrace) {
    debugPrint("=>Firebase Crashlytics initialization failed: $e");
    debugPrint("=>Stack trace: $stackTrace");
  }
}

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    FirebaseOptions? firebaseOptions;

    if (Platform.isAndroid) {
      firebaseOptions = const FirebaseOptions(
        apiKey: "AIzaSyBibbWowXfs9tJ7kpusdMwnRCY6WCAMOls",
        appId: '1:937467737904:android:2718c949bbcf147c4a3af5',
        messagingSenderId: '937467737904',
        projectId: 'nextalk77',
        storageBucket: 'nextalk77.firebasestorage.app',
      );
    } else if (Platform.isIOS) {
      firebaseOptions = const FirebaseOptions(
        apiKey: "AIzaSyDCwJKucCwLZajFjnEEnA9CX0Kew_4VklA",
        appId: '1:937467737904:ios:1ff0acaa92541e754a3af5',
        messagingSenderId: '937467737904',
        projectId: 'nextalk77',
        storageBucket: 'nextalk77.firebasestorage.app',
        iosBundleId: 'com.ako.nextalk',
      );
    }

    if (firebaseOptions != null) {
      await Firebase.initializeApp(options: firebaseOptions);
      debugPrint(
          "=>Firebase initialized successfully on ${Platform.operatingSystem}");
    } else {
      await Firebase.initializeApp();
      debugPrint(
          "=>Firebase initialized with default config on ${Platform.operatingSystem}");
    }

    await _initializeCrashlytics();
  } catch (e, stackTrace) {
    debugPrint("=>Firebase initialization failed: $e");
    debugPrint("=>Stack trace: $stackTrace");
    try {
      await Firebase.initializeApp();
      await _initializeCrashlytics();
      FirebaseCrashlytics.instance.recordError(e, stackTrace, fatal: false);
    } catch (_) {
      debugPrint("=>Could not initialize Firebase or Crashlytics");
    }
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}
