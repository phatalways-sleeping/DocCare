part of 'dc_page_view.dart';

/// {@template dc_page_view_two}
class DCPageViewTwo extends StatefulWidget {
  /// {@macro dc_page_view_two}
  const DCPageViewTwo({
    super.key,
  });


  @override
  State<DCPageViewTwo> createState() => _DCPageViewTwoState();
}

class _DCPageViewTwoState extends State<DCPageViewTwo>
    with TickerProviderStateMixin {
  late final firstRowAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final firstRowAnimation = CurvedAnimation(
    parent: firstRowAnimationController,
    curve: Curves.decelerate,
  );

  late final firstRowPosition = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(firstRowAnimation);

  late final secondRowAnimation = CurvedAnimation(
    parent: secondRowAnimationController,
    curve: Curves.decelerate,
  );

  late final secondRowPosition = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(secondRowAnimation);

  late final secondRowAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  @override
  void initState() {
    secondRowAnimationController.forward();
    firstRowAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    secondRowAnimationController.dispose();
    firstRowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DCPageView(
      background: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pic_3.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/pic_4.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
      foreground: [
        SizedBox(
          height: context.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SlideTransition(
              position: firstRowPosition,
              child: DCInformationBox(
                header: Text(
                  'Connect with doctors',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                body: Text(
                  'Connect with doctors and get your queries answered',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                backgroundColor: context.colorScheme.secondary,
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.secondary,
                    context.colorScheme.secondary.withOpacity(0.9),
                    context.colorScheme.secondary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: firstRowPosition,
              child: DCInformationBox(
                header: Text(
                  'Enthusiastic staff',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                body: Text(
                  'Our staff is always ready to help you',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                backgroundColor: context.colorScheme.error,
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.error,
                    context.colorScheme.error.withOpacity(0.9),
                    context.colorScheme.error.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SlideTransition(
              position: secondRowPosition,
              child: DCInformationBox(
                header: Text(
                  'Connect with doctors',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                body: Text(
                  'Connect with doctors and get your queries answered',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                backgroundColor: context.colorScheme.secondary,
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.secondary,
                    context.colorScheme.secondary.withOpacity(0.9),
                    context.colorScheme.secondary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            SlideTransition(
              position: secondRowPosition,
              child: DCInformationBox(
                header: Text(
                  'Enthusiastic staff',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                body: Text(
                  'Our staff is always ready to help you',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                backgroundColor: context.colorScheme.error,
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.error,
                    context.colorScheme.error.withOpacity(0.9),
                    context.colorScheme.error.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        SlideTransition(
          position: secondRowPosition,
          child: DCInformationBox(
            header: Text(
              'Enthusiastic staff',
              style: TextStyle(
                color: context.colorScheme.onBackground,
              ),
            ),
            body: Text(
              'Our staff is always ready to help you',
              style: TextStyle(
                color: context.colorScheme.onBackground,
              ),
            ),
            backgroundColor: context.colorScheme.error,
            gradient: LinearGradient(
              colors: [
                context.colorScheme.error,
                context.colorScheme.error.withOpacity(0.9),
                context.colorScheme.error.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
/// {@endtemplate}
