// ignore_for_file: public_member_api_docs

part of 'dc_page_view.dart';

class DCPageViewTwo extends StatefulWidget {
  /// {@macro dc_page_view_two}
  const DCPageViewTwo({
    required this.pageController,
    super.key,
  });

  /// [pageController] is the [PageController] used to animate the page
  final PageController pageController;

  @override
  State<DCPageViewTwo> createState() => _DCPageViewTwoState();
}

class _DCPageViewTwoState extends State<DCPageViewTwo>
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) async {
        if (details.primaryVelocity! < 0) {
          await showDCLoginModalBottomSheet<bool>(
            context,
            transitionAnimationController,
          );
        } else if (details.primaryVelocity! > 0) {
          await widget.pageController.previousPage(
            duration: const Duration(milliseconds: 650),
            curve: Curves.decelerate,
          );
        }
      },
      child: DCPageView(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/images/pic_3.png',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/pic_4.png',
                fit: BoxFit.cover,
              ),
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
                    'Convenient',
                    style: TextStyle(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  body: Text(
                    'We provide you with the best services at your convenience',
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
                    'Ease of access',
                    style: TextStyle(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  body: Text(
                    'Booking appointments is just a click away',
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
                    'Online Medical Records',
                    style: TextStyle(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  body: Text(
                    'Access your medical records from anywhere',
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
                    'Online Consultation',
                    style: TextStyle(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                  body: Text(
                    'Consult with your doctor online',
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
