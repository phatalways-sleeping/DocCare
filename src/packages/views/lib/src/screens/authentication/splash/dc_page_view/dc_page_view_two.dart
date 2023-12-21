// ignore_for_file: public_member_api_docs

part of 'dc_page_view.dart';


class DCPageViewTwo extends StatelessWidget {
  /// {@macro dc_page_view_two}
  const DCPageViewTwo({
    required this.transitionAnimationController,
    required this.pageController,
    super.key,
  });

  /// [pageController] is the [PageController] used to animate the page
  final PageController pageController;

  /// [transitionAnimationController] is the [AnimationController]
  /// used to animate the transition
  final AnimationController transitionAnimationController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) async {
        if (details.primaryVelocity! < 0) {
          await showDCLoginModalBottomSheet<bool>(
            context,
            transitionAnimationController,
          );
        } else if (details.primaryVelocity! > 0) {
          await pageController.previousPage(
            duration: const Duration(milliseconds: 650),
            curve: Curves.decelerate,
          );
        }
      },
      child: DCPageView(
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
              SlideAnimatedBox(
                duration: const Duration(milliseconds: 2000),
                begin: const Offset(0, -1.5),
                end: Offset.zero,
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
              SlideAnimatedBox(
                duration: const Duration(milliseconds: 2000),
                begin: const Offset(0, -1.5),
                end: Offset.zero,
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
          SizedBox(
            height: context.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SlideAnimatedBox(
                begin: const Offset(-1.5, 0),
                end: Offset.zero,
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
              SlideAnimatedBox(
                begin: const Offset(1.5, 0),
                end: Offset.zero,
                duration: const Duration(
                  milliseconds: 2000,
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
          SizedBox(
            height: context.height * 0.05,
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
    );
  }
}

/// {@endtemplate}
