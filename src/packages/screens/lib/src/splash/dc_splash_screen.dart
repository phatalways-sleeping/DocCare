import 'package:flutter/material.dart';
import 'package:screens/src/splash/dc_page_view.dart';

/// {@template dc_splash_screen}
class DCSplashScreen extends StatefulWidget {
  /// {@macro screens}
  const DCSplashScreen({super.key});

  @override
  State<DCSplashScreen> createState() => _DCSplashScreenState();
}

class _DCSplashScreenState extends State<DCSplashScreen>
    with SingleTickerProviderStateMixin {
  late final scrollController = ScrollController();
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeIn,
  );
  late final pageController = PageController();

  @override
  void initState() {
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
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
