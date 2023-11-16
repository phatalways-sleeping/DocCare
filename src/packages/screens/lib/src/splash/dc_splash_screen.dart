import 'package:flutter/material.dart';
import 'package:screens/src/splash/dc_page_view/dc_page_view.dart';

/// {@template dc_splash_screen}
class DCSplashScreen extends StatefulWidget {
  /// {@macro screens}
  const DCSplashScreen({super.key});

  @override
  State<DCSplashScreen> createState() => _DCSplashScreenState();
}

class _DCSplashScreenState extends State<DCSplashScreen> {
  late final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: 2,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return DCPageViewOne(
                pageController: pageController,
              );
            }
            return const DCPageViewTwo();
          },
        ),
      ),
    );
  }
}
