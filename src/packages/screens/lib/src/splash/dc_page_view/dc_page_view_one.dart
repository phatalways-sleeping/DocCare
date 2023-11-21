part of 'dc_page_view.dart';

/// {@template dc_page_view_one}
class DCPageViewOne extends StatelessWidget {
  /// {@macro dc_page_view_one}
  const DCPageViewOne({
    required this.pageController,
    super.key,
  });

  /// [pageController] is the [PageController] used to animate the page
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return DCPageView(
      action: DCButton(
        onPressed: () async {
          await showModalBottomSheet<bool>(
            elevation: 0,
            context: context,
            backgroundColor: context.colorScheme.background,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              side: BorderSide(
                color: context.colorScheme.secondary,
                width: 2,
              ),
            ),
            constraints: BoxConstraints(
              maxHeight: context.height * 0.6,
            ),
            // Pass the [LoginBloc] to the [DCLoginModalBottomSheet]
            // to use it's [LoginState] and [LoginEvent]
            builder: (context) => BlocProvider(
              create: (context) => LoginBloc(
                SupabaseAuthenticationRepository.instance,
                NotificationManager.instance,
              ),
              child: const DCLoginModalBottomSheet(),
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
      background: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
        onPressed: () => pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}

/// {@endtemplate}