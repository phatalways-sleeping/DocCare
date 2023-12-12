import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  group('BasePopup', () {
    testWidgets('Rendering test', (WidgetTester tester) async {
      await tester.pumpWidget(
        //Create a popup
        MaterialApp(
          home: Scaffold(
            body: BasePopup(
              title: 'Title',
              message: 'Message',
              buttonText: 'Button Text',
              textColor: Colors.black,
              //Dummy color not relying on context
              buttonColor: Colors.red,
              popupIcon: SvgPicture.string(
                DCSVGIcons.error,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);

      expect(find.text('Message'), findsOneWidget);

      expect(find.text('Button Text'), findsOneWidget);

      expect(find.byType(ElevatedButton), findsOneWidget);

      //Find and check if the text from TextButton from BasePopup has the black color
      expect(
        tester.widget<Text>(find.text('Button Text')).style!.color,
        Colors.black,
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('Close pop-up', (WidgetTester tester) async {
      await tester.pumpWidget(
        //Create a popup
        MaterialApp(
          home: Scaffold(
            body: BasePopup(
              title: 'Title',
              message: 'Message',
              buttonText: 'Button Text',
              textColor: Colors.black,
              //Dummy color not relying on context
              buttonColor: Colors.red,
              popupIcon: SvgPicture.string(
                DCSVGIcons.error,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Button Text'));
      await tester.pumpAndSettle();
      expect(find.byType(BasePopup), findsNothing);
    });
  });
}
