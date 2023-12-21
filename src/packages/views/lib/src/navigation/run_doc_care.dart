// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/screens.dart';
import 'package:views/src/screens/authentication/change_password/dc_change_password_screen.dart';

void runDocCare() => runApp(
      MultiRepositoryProvider(
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
        ],
        child: MaterialApp(
          title: 'DocCare',
          theme: ThemeData(
            colorScheme: const DocCareLightColorScheme(),
          ),
          initialRoute: '/splash',
          routes: {
            // Authentication

            '/splash': (context) => const RestorationScope(
                  restorationId: 'splash',
                  child: DCSplashScreen(
                    key: Key('splash'),
                  ),
                ),

            '/sign-up': (context) => const DCSignUpScreen(),

            '/forgot-password': (context) => const DCChangePasswordScreen(),

            // User

            '/home': (context) => const SizedBox.shrink(),

            '/profile': (context) => const SizedBox.shrink(),

            '/prescription': (context) => const SizedBox.shrink(),

            '/schedule/doctor': (context) => const SizedBox.shrink(),

            '/schedule': (context) => const SizedBox.shrink(),

            '/message': (context) => const SizedBox.shrink(),

            '/notification': (context) => const SizedBox.shrink(),

            '/sign-out': (context) => const SizedBox.shrink(),

            // Admin

            '/admin/home': (context) => const SizedBox.shrink(),

            '/admin/reports': (context) => const SizedBox.shrink(),

            '/admin/staff/create': (context) => const SizedBox.shrink(),

            '/admin/staff/delete': (context) => const SizedBox.shrink(),

            // Doctor

            '/doctor/home': (context) => const SizedBox.shrink(),

            '/doctor/message': (context) => const SizedBox.shrink(),

            '/doctor/notification': (context) => const SizedBox.shrink(),

            // Receptionist

            '/receptionist/home': (context) => const SizedBox.shrink(),

            '/receptionist/booking': (context) => const SizedBox.shrink(),
          },
          restorationScopeId: 'doccare',
        ),
      ),
    );
