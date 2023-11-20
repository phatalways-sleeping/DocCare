import 'package:auth_domain/auth_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/login/controller/login_bloc.dart';
import 'package:screens/src/splash/dc_page_view/dc_page_view.dart';
import 'package:utility/utility.dart';

/// {@template dc_splash_screen}
class DCSplashScreen extends StatefulWidget {
  /// {@macro screens}
  const DCSplashScreen({super.key});

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
            SupabaseAuthenticationRepository.instance,
            NotificationManager.instance,
          ),
          child: PageView.builder(
            controller: pageController,
            itemCount: 2,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              if (value == 1) {
                transitionAnimationController.forward();
              }
            },
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
              return const DCPageViewTwo();
            },
          ),
        ),
      ),
    );
  }
}
