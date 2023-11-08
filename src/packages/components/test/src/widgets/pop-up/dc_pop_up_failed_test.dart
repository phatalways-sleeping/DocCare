import 'package:components/src/widgets/pop_up/dc_pop_up_failed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DCPopUpFailed', () {
    testWidgets('Render DCPopUpFailed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DCPopupFailed(
            title: 'title',
            message: 'message',
            buttonText: 'buttonText',
          ),
        ),
      );
      expect(find.byType(DCPopupFailed), findsOneWidget);

      expect(find.text('title'), findsOneWidget);

      expect(find.text('message'), findsOneWidget);
    });

    testWidgets('Close pop-up', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DCPopupFailed(
            title: 'title',
            message: 'message',
            buttonText: 'buttonText',
          ),
        ),
      );
      expect(find.byType(DCPopupFailed), findsOneWidget);

      await tester.tap(find.text('buttonText'));
      await tester.pumpAndSettle();
      expect(find.byType(DCPopupFailed), findsNothing);
    });
  });
}
