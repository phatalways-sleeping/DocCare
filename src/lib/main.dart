import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:src/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:views/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');

  await Future.wait([
    /// Initialize Firebase
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),

    /// Initialize Supabase
    Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authFlowType: AuthFlowType.pkce,
    )
  ]);

  NotificationManager.init();

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

  runDocCare();

  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepositoryService>(
          create: (context) => SupabaseAuthenticationRepository(),
        ),
        RepositoryProvider<StorageRepositoryService>(
          create: (context) => SupabaseStorageRepository(),
        ),
        RepositoryProvider<AdministratorRepositoryService>(
          create: (context) => SupabaseAdminRepository(),
        ),
        RepositoryProvider<CustomerRepositoryService>(
          create: (context) => SupabaseCustomerRepository(),
        ),
        RepositoryProvider<DoctorRepositoryService>(
          create: (context) => SupabaseDoctorRepository(),
        ),
        RepositoryProvider<ReceptionistRepositoryService>(
          create: (context) => SupabaseReceptionistRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'DocCare',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: const DocCareLightColorScheme(),
        ),
        home: const MyHomePage(
          title: 'DocCare',
        ),
      ),
    );
  }

  @override
  void dispose() {
    NotificationManager.instance.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const SizedBox.shrink();
  }
}
