import 'package:components/src/widgets/pop_up/dc_pop_up_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DCPopUpSuccess', () {
    testWidgets('Render DCPopUpSuccess', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DCPopupSuccess(
            title: 'title',
            message: 'message',
            buttonText: 'buttonText',
          ),
        ),
      );
      expect(find.byType(DCPopupSuccess), findsOneWidget);

      expect(find.text('title'), findsOneWidget);

      expect(find.text('message'), findsOneWidget);
    });

    testWidgets('Close pop-up', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DCPopupSuccess(
            title: 'title',
            message: 'message',
            buttonText: 'buttonText',
          ),
        ),
      );
      expect(find.byType(DCPopupSuccess), findsOneWidget);

      await tester.tap(find.text('buttonText'));
      await tester.pumpAndSettle();
      expect(find.byType(DCPopupSuccess), findsNothing);
    });
  });
}
