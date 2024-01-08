// ignore_for_file: public_member_api_docs

import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/authentication/login/controller/login_bloc.dart';
import 'package:views/src/screens/authentication/splash/dc_page_view/dc_page_view.dart';

/// DC Splash Screen is an entrance screen of the application
/// It requires a GlobalKey<NavigatorState> to be injected at the root of the
/// application.
/// Therefore, to use this screen:
/// 1. Add the following code to the root of the application:
/// ```dart
/// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
/// NotificationManager.init(navigatorKey);
/// ```
/// 2. Initialize Supabase
/// 3. Add the following code to the root of the application:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///      colorScheme: const DocCareLightColorScheme(),
///   ),
///   home: DCSplashScreen(key: navigatorKey),
/// );
/// ```
class DCSplashScreen extends StatelessWidget {
  /// {@macro screens}
  const DCSplashScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: navigatorKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
            navigatorKey,
            context.read<AuthenticationRepositoryService>(),
            context.read<CustomerRepositoryService>(),
            context.read<DoctorRepositoryService>(),
            context.read<ReceptionistRepositoryService>(),
            NotificationManager.instance,
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                switch (state.role) {
                  case 'doctor':
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/doctor/home');
                  case 'customer':
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/home');
                  case 'admin':
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/admin/staff/create');
                  case 'receptionist':
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed('/receptionist/absent-request');
                }
              }
            },
            child: const DCPageViewOne(),
          ),
        ),
      ),
    );
  }
}
