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
import 'package:views/src/screens/doctors/prescription/dc_doctor_prescribe_medicine_flow.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileNames: ['.env']);
  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
  String serviceRoleKey = dotenv.get('SERVICE_ROLE_KEY');

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

  runDocCare(supabaseUrl, serviceRoleKey);

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

  runApp(const MyApp());
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
          create: (context) => SupabaseAuthenticationRepository(
            dotenv.get('SUPABASE_URL'),
            dotenv.get('SERVICE_ROLE_KEY'),
          ),
        ),
        RepositoryProvider<StorageRepositoryService>(
          create: (context) => SupabaseStorageRepository(),
        ),
        RepositoryProvider<AdministratorRepositoryService>(
          create: (context) => SupabaseAdminRepository(
            dotenv.get('SUPABASE_URL'),
            dotenv.get('SERVICE_ROLE_KEY'),
          ),
        ),
        RepositoryProvider<CustomerRepositoryService>(
          create: (context) {
            final customerRepository = SupabaseCustomerRepository();
            customerRepository.initializeCustomerId('C001');
            return customerRepository;
          },
        ),
        RepositoryProvider<DoctorRepositoryService>(
          create: (context) {
            final doctorRepository = SupabaseDoctorRepository();
            doctorRepository.initializeDoctorId('D001');
            doctorRepository.initializeCustomerId('C001');
            doctorRepository.initializeCustomerName('Nguyen Van A');
            doctorRepository.initializePeriod('1');
            doctorRepository.initializeDate(DateTime(2023, 12, 25));
            return doctorRepository;
          },
        ),
        RepositoryProvider<ReceptionistRepositoryService>(
          create: (context) => SupabaseReceptionistRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'DocCare',
        theme: ThemeData(
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DCDoctorPrescibeMedicineFlow(
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}
