// ignore_for_file: public_member_api_docs

part of 'dc_page_view.dart';

class DCPageViewOne extends StatefulWidget {
  /// {@macro dc_page_view_one}
  const DCPageViewOne({
    super.key,
  });

  @override
  State<DCPageViewOne> createState() => _DCPageViewOneState();
}

class _DCPageViewOneState extends State<DCPageViewOne>
    with SingleTickerProviderStateMixin {
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
    transitionAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // Dispose the animation controller when the widget is removed from the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      transitionAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          transitionAnimationController.dispose();
          debugPrint('Disposed');
        }
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DCPageView(
      action: DCFilledButton(
        onPressed: (context) async {
          await showDCLoginModalBottomSheet<bool>(
            context,
            transitionAnimationController,
          );
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        backgroundColor: context.colorScheme.secondary,
        child: Text(
          'Get Started',
          style: context.textTheme.bodyRegularPoppins.copyWith(
            color: context.colorScheme.onSecondary,
            fontSize: 14,
          ),
        ),
      ),
      background: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              'assets/images/pic_1.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/pic_2.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      foreground: [
        SlideAnimatedBox(
          duration: const Duration(milliseconds: 2000),
          begin: const Offset(0, -1.25),
          end: Offset.zero,
          child: Text.rich(
            TextSpan(
              text: 'Doc',
              children: [
                TextSpan(
                  text: 'Care',
                  style: context.textTheme.h1BoldPoppins.copyWith(
                    color: context.colorScheme.onSecondary,
                    fontSize: 60,
                  ),
                ),
              ],
              style: context.textTheme.h1BoldPoppins.copyWith(
                color: context.colorScheme.onSecondary,
                fontSize: 60,
              ),
            ),
          ),
        ),
        SlideAnimatedBox(
          duration: const Duration(milliseconds: 2000),
          begin: const Offset(0, -1.15),
          end: Offset.zero,
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
            FadeAnimatedBox(
              duration: const Duration(
                milliseconds: 2000,
              ),
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
              ),
            ),
            FadeAnimatedBox(
              duration: const Duration(
                milliseconds: 2500,
              ),
              child: DCInformationBox(
                header: Text(
                  'Notifications',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                body: Text(
                  'Reminders for your appointments and prescriptions',
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                backgroundColor: context.colorScheme.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// {@endtemplate}
