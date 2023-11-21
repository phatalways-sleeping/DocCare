import 'package:components/components.dart';
import 'package:components/src/widgets/navigation_bar/base_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DCDoctorNavigationBar displays correct items',
      (WidgetTester tester) async {
    // Build the DCDoctorNavigationBar widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: DCDoctorNavigationBar(
            onItemSelected: (context, index) {},
            unselectedItemColor: Colors.red,
            selectedItemColor: Colors.blue,
          ),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);

    // Verify if the custom navigation bar is present
    expect(find.byType(DCDoctorNavigationBar), findsOneWidget);

    // Verify the base navigation bar within the custom nav bar
    expect(
      find.descendant(
        of: find.byType(DCDoctorNavigationBar),
        matching: find.byType(BaseNavigationBar),
      ),
      findsOneWidget,
    );
    // Verify the presence of SVG Pictures
    expect(find.byType(SvgPicture), findsNWidgets(2));

    final bottomNavBar = find.byType(BottomNavigationBar);
    expect(bottomNavBar, findsOneWidget);

    // Assuming 'Home' is the first item, find the first SvgPicture within the BottomNavigationBar.
    final firstSvgIcon = find
        .descendant(
          of: bottomNavBar,
          matching: find.byWidgetPredicate(
            (Widget widget) => widget is SvgPicture,
          ),
        )
        .first;

    final secondSvgIcon = find
        .descendant(
          of: bottomNavBar,
          matching: find.byWidgetPredicate(
            (Widget widget) => widget is SvgPicture,
          ),
        )
        .last;

    // Verify if the SvgPicture is found
    expect(firstSvgIcon, findsOneWidget);
    expect(secondSvgIcon, findsOneWidget);

    // If you have specific height and width, you can also verify that
    final iconWidget = tester.widget(firstSvgIcon) as SvgPicture;
    expect(iconWidget.width, 24);
    expect(iconWidget.height, 24);
    final iconWidget2 = tester.widget(secondSvgIcon) as SvgPicture;
    expect(iconWidget2.width, 24);
    expect(iconWidget2.height, 24);
  });
}
