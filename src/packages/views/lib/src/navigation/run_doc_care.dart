// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/notification/dc_notification_screen.dart';
import 'package:views/src/profile/dc_profile.dart';
import 'package:views/src/screens/admin/management/v2/create/flows/dc_admin_create_staff_flow.dart';
import 'package:views/src/screens/admin/management/v2/remove/screens/dc_staff_removal_screen.dart';
import 'package:views/src/screens/admin/report/dc_admin_generate_report.dart';
import 'package:views/src/screens/authentication/change_password/dc_change_password_screen.dart';
import 'package:views/src/screens/authentication/sign_up/dc_sign_up_screen.dart';
import 'package:views/src/screens/authentication/splash/dc_splash_screen.dart';
import 'package:views/src/screens/doctors/absent/dc_doctor_absent_screen.dart';
import 'package:views/src/screens/doctors/home/dc_doctor_home_flow.dart';
import 'package:views/src/screens/doctors/prescription/dc_doctor_prescribe_medicine_flow.dart';
import 'package:views/src/screens/receptionist/absent/dc_receptionist_absent.dart';
import 'package:views/src/screens/users/booking/flows/dc_doctor_view_main_screen.dart';
import 'package:views/src/screens/users/booking/flows/dc_schedule_view_screen.dart';
import 'package:views/src/screens/users/home/dc_customer_home_screen.dart';
import 'package:views/src/screens/users/prescription/dc_customer_view_prescription_flow.dart';

class _CustomerMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _CustomerMaterialPageRoute({
    required Widget child,
    bool wrapped = true,
  }) : super(
          builder: (context) => !wrapped
              ? child
              : GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx < -10) {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: child,
                ),
        );
}

void runDocCare(String supabaseUrl, String serviceRoleKey) => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepositoryService>(
            create: (context) => SupabaseAuthenticationRepository(
              supabaseUrl,
              serviceRoleKey,
            ),
          ),
          RepositoryProvider<StorageRepositoryService>(
            create: (context) => SupabaseStorageRepository(),
          ),
          RepositoryProvider<AdministratorRepositoryService>(
            create: (context) => SupabaseAdminRepository(
              supabaseUrl,
              serviceRoleKey,
            ),
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const DocCareLightColorScheme(),
          ),
          initialRoute: '/splash',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/splash':
                return _CustomerMaterialPageRoute(
                  wrapped: false,
                  child: RestorationScope(
                    restorationId: 'splash',
                    child: DCSplashScreen(
                      navigatorKey: GlobalKey<NavigatorState>(
                        debugLabel: 'splash',
                      ),
                    ),
                  ),
                );
              case '/sign-up':
                return _CustomerMaterialPageRoute(
                  child: DCSignUpScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'sign-up',
                    ),
                  ),
                );
              case '/forgot-password':
                return _CustomerMaterialPageRoute(
                  child: DCChangePasswordScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'forgot-password',
                    ),
                  ),
                );
              case '/home':
                return _CustomerMaterialPageRoute(
                  child: const DCCustomerHomeScreen(),
                );
              case '/profile':
                return _CustomerMaterialPageRoute(
                  child: DCProfileScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'profile',
                    ),
                  ),
                );
              case '/prescription':
                return _CustomerMaterialPageRoute(
                  child: DCCustomerViewPrescriptionFlow(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'prescription',
                    ),
                  ),
                );
              case '/schedule/doctor':
                return _CustomerMaterialPageRoute(
                  child: DCDoctorViewMainScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'schedule/doctor',
                    ),
                  ),
                );
              case '/booking':
                return _CustomerMaterialPageRoute(
                  child: DCScheduleViewScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'schedule',
                    ),
                  ),
                );
              case '/notification':
                return _CustomerMaterialPageRoute(
                  child: const DCNotificationScreen(),
                );
              case '/admin/home':
                return _CustomerMaterialPageRoute(
                  child: const SizedBox.shrink(),
                );
              case '/admin/reports':
                return _CustomerMaterialPageRoute(
                  child: DCAdminGenerateReportScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'admin/reports',
                    ),
                  ),
                );
              case '/admin/staff/create':
                return _CustomerMaterialPageRoute(
                  child: const DCAdminCreateStaffFlow(),
                );
              case '/admin/staff/delete':
                return _CustomerMaterialPageRoute(
                  child: const DCStaffRemovalScreen(),
                );
              case '/doctor/home':
                return _CustomerMaterialPageRoute(
                  child: DCDoctorHomeFlow(
                    navigatorKey: GlobalKey<NavigatorState>(),
                  ),
                );
              case '/doctor/message':
                return _CustomerMaterialPageRoute(
                  child: const SizedBox.shrink(),
                );
              case '/doctor/notification':
                return _CustomerMaterialPageRoute(
                  child: const SizedBox.shrink(),
                );
              case '/doctor/prescribe':
                return _CustomerMaterialPageRoute(
                  child: DCDoctorPrescibeMedicineFlow(
                    arguments: settings.arguments! as Map<String, dynamic>,
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'prescribe-doctor',
                    ),
                  ),
                );
              case '/doctor/absent-request':
                return _CustomerMaterialPageRoute(
                  child: const DCDoctorAbsentScreen(),
                );
              case '/receptionist/absent-request':
                return _CustomerMaterialPageRoute(
                  child: const DCReceptionistAbsentScreen(),
                );
              case '/receptionist/booking':
                return _CustomerMaterialPageRoute(
                  child: DCDoctorViewMainScreen(
                    navigatorKey: GlobalKey<NavigatorState>(
                      debugLabel: 'schedule/receptionist',
                    ),
                    inCustomerView: false,
                  ),
                );

              default:
                return _CustomerMaterialPageRoute(
                  child: RestorationScope(
                    restorationId: 'splash',
                    child: DCSplashScreen(
                      navigatorKey: GlobalKey<NavigatorState>(
                        debugLabel: 'splash',
                      ),
                    ),
                  ),
                );
            }
          },
          restorationScopeId: 'doccare',
        ),
      ),
    );
