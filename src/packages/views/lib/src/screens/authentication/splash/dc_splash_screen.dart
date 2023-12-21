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
/// {@template dc_splash_screen}
class DCSplashScreen extends StatefulWidget {
  /// {@macro screens}
  const DCSplashScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCSplashScreen> createState() => _DCSplashScreenState();
}

class _DCSplashScreenState extends State<DCSplashScreen>
    with SingleTickerProviderStateMixin {
  late final pageController = PageController();
  late final transitionAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );

  late final curvedAnimation = CurvedAnimation(
    parent: transitionAnimationController,
    curve: Curves.decelerate,
  );

  @override
  void dispose() {
    pageController.dispose();
    transitionAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.navigatorKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
            widget.navigatorKey,
            SupabaseAuthenticationRepository(),
            NotificationManager.instance,
          ),
          child: PageView.builder(
            controller: pageController,
            itemCount: 2,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: DCPageViewOne(
                    pageController: pageController,
                    transitionAnimationController:
                        transitionAnimationController,
                  ),
                );
              }
              return DCPageViewTwo(
                transitionAnimationController: transitionAnimationController,
                pageController: pageController,
              );
            },
          ),
        ),
      ),
    );
  }
}
