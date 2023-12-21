// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/screens.dart';
import 'package:views/src/screens/admin/management/v2/create/flows/dc_admin_create_staff_flow.dart';
import 'package:views/src/screens/admin/management/v2/remove/screens/dc_staff_removal_screen.dart';
import 'package:views/src/screens/admin/report/dc_admin_generate_report.dart';
import 'package:views/src/screens/authentication/change_password/dc_change_password_screen.dart';
import 'package:views/src/screens/doctors/absent/dc_doctor_absent_screen.dart';
import 'package:views/src/screens/doctors/prescription/dc_doctor_prescribe_medicine_flow.dart';
import 'package:views/src/screens/receptionist/absent/dc_receptionist_absent.dart';
import 'package:views/src/screens/users/booking/flows/dc_doctor_view_main_screen.dart';
import 'package:views/src/screens/users/booking/flows/dc_schedule_view_screen.dart';
import 'package:views/src/screens/users/prescription/dc_customer_view_prescription_flow.dart';

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
          initialRoute: '/prescription',
          routes: {
            // Authentication

            '/splash': (context) => RestorationScope(
                  restorationId: 'splash',
                  child: DCSplashScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'splash',
                    ),
                  ),
                ),

            '/sign-up': (context) => DCSignUpScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'sign-up',
                  ),
                ),

            '/forgot-password': (context) => DCChangePasswordScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'forgot-password',
                  ),
                ),

            // User
            '/home': (context) => const SizedBox.shrink(),

            '/profile': (context) => DCProfileScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'profile',
                  ),
                ),

            '/prescription': (context) => DCCustomerViewPrescriptionFlow(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'prescription',
                  ),
                ),

            '/schedule/doctor': (context) => DCDoctorViewMainScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'schedule/doctor',
                  ),
                ),

            '/schedule': (context) => DCScheduleViewScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'schedule',
                  ),
                ),

            '/message': (context) => const SizedBox.shrink(),

            '/notification': (context) => const SizedBox.shrink(),

            '/sign-out': (context) => const SizedBox.shrink(),

            // Admin

            '/admin/home': (context) => const SizedBox.shrink(),

            '/admin/reports': (context) => DCAdminGenerateReportScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'admin/reports',
                  ),
                ),

            '/admin/staff/create': (context) => const DCAdminCreateStaffFlow(),

            '/admin/staff/delete': (context) => const DCStaffRemovalScreen(),

            // Doctor

            '/doctor/home': (context) => const SizedBox.shrink(),

            '/doctor/message': (context) => const SizedBox.shrink(),

            '/doctor/notification': (context) => const SizedBox.shrink(),

            '/doctor/prescribe': (context) => DCDoctorPrescibeMedicineFlow(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'prescribe-doctor',
                  ),
                  customerName: 'John Doe', // Later we replace
                ),

            '/doctor/absent-request': (context) => const DCDoctorAbsentScreen(),

            // Receptionist

            '/receptionist/home': (context) =>
                const DCReceptionistAbsentScreen(),

            '/receptionist/booking': (context) => DCScheduleViewScreen(
                  navigatorKey: GlobalKey<NavigatorState>(
                    debugLabel: 'schedule',
                  ),
                ),
          },
          restorationScopeId: 'doccare',
        ),
      ),
    );
