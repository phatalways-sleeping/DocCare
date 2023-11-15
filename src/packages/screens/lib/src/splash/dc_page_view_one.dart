part of 'dc_page_view.dart';

/// {@template dc_page_view_one}
class DCPageViewOne extends StatefulWidget {
  /// {@macro dc_page_view_one}
  const DCPageViewOne({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  State<DCPageViewOne> createState() => _DCPageViewOneState();
}

class _DCPageViewOneState extends State<DCPageViewOne>
    with TickerProviderStateMixin {
  late final animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.decelerate,
  );

  late final informationBoxAnimation = CurvedAnimation(
    parent: animationInformationBoxController,
    curve: Curves.decelerate,
  );

  late final position = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(animation);

  late final informationBoxPosition = Tween<Offset>(
    begin: const Offset(0, 0.8),
    end: Offset.zero,
  ).animate(informationBoxAnimation);

  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  late final animationInformationBoxController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  @override
  void initState() {
    animationController.forward();
    animationInformationBoxController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationInformationBoxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DCPageView(
      bottom: 0.15,
      action: DCButton(
        onPressed: () {
          /// TODO(phatalways-sleeping): Develop the modal bottom sheet for login
          showModalBottomSheet<bool>(
            elevation: 0,
            barrierColor: Colors.transparent,
            context: context,
            backgroundColor: context.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            builder: (context) => SizedBox(
              height: context.height * 0.5,
              child: const Center(
                child: Text('Hello'),
              ),
            ),
          );
        },
        text: 'Get Started',
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        backgroundColor: context.colorScheme.secondary,
        textColor: context.colorScheme.onSecondary,
        borderColor: Colors.transparent,
      ),
      background: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pic_1.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/pic_2.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
      foreground: [
        SlideTransition(
          position: position,
          child: Text.rich(
            TextSpan(
              text: 'Doc',
              children: [
                TextSpan(
                  text: 'C',
                  style: context.textTheme.h1BoldPoppins.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontSize: 60,
                  ),
                ),
                TextSpan(
                  text: 'are',
                  style: context.textTheme.h1BoldPoppins.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontSize: 60,
                  ),
                ),
              ],
              style: context.textTheme.h1BoldPoppins.copyWith(
                color: context.colorScheme.secondary,
                fontSize: 60,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: animation,
          child: Text(
            'Powered by DCTeam',
            style: context.textTheme.h1RegularPoppins.copyWith(
              color: context.colorScheme.onSurface,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: context.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SlideTransition(
              position: informationBoxPosition,
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
            SizedBox(
              width: context.width * 0.05,
            ),
            SlideTransition(
              position: informationBoxPosition,
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
      ],
      footer: IconButton(
        icon: Icon(
          Icons.arrow_downward_rounded,
          color: context.colorScheme.onBackground,
          size: 30,
        ),
        onPressed: () => widget.pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}
/// {@endtemplate}