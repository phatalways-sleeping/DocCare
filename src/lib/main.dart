import 'package:utility/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:src/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:views/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileNames: ['.env']);
  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
  String serviceRoleKey = dotenv.get('SERVICE_ROLE_KEY');
  String host = dotenv.get('HOST');
  String database = dotenv.get('DATABASE');
  String password = dotenv.get('PASSWORD');

  await Future.wait([
    /// Initialize Firebase
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => debugPrint('Firebase initialized')),

    /// Initialize Supabase
    Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authFlowType: AuthFlowType.pkce,
    ).then((value) => debugPrint('Supabase initialized')),
  ]);

  await Supabase.instance.client.auth.signOut(scope: SignOutScope.others);

  NotificationManager.init();

  runDocCare(
    supabaseUrl,
    serviceRoleKey,
    host: host,
    database: database,
    password: password,
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception is FlutterError && details.stack != null) {
      if (details.exception
          .toString()
          .contains('Multiple widgets used the same GlobalKey')) {
        return;
      }
      debugPrint('FlutterError: ${details.exception.toString()}');
      debugPrint('Stack trace: ${details.stack}');
    } else {
      FlutterError.dumpErrorToConsole(details);
    }
  };

  //runApp(const MyApp());
}