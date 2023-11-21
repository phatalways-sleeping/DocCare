import 'package:components/components.dart';
import 'package:components/src/widgets/header_bar/base_header_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BaseHeaderBar', () {
    testWidgets('Render BaseHeaderBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BaseHeaderBar(
            headerBarTitle: 'Test Title',
            leadingItems: DCHeaderBarItem(
              prefixIcon: Icon(Icons.arrow_back),
              onTap: (BuildContext context) {},
            ),
            actionItems: [
              DCHeaderBarItem(
                prefixIcon: Icon(Icons.notification_important),
                onTap: (BuildContext context) {},
              ),
            ],
          ),
        ),
      );

      expect(find.byType(BaseHeaderBar), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(DCHeaderBarItem), findsNWidgets(2));
    });

    testWidgets('Trigger Leading Icon Callback', (WidgetTester tester) async {
      bool leadingCallbackTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: BaseHeaderBar(
            headerBarTitle: 'Test Title',
            leadingItems: DCHeaderBarItem(
              prefixIcon: Icon(Icons.arrow_back),
              onTap: (BuildContext context) {
                leadingCallbackTriggered = true;
              },
            ),
            actionItems: [
              DCHeaderBarItem(
                prefixIcon: Icon(Icons.notification_important),
                onTap: (BuildContext context) {},
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();

      expect(leadingCallbackTriggered, true);
    });

    testWidgets('Trigger Action Icon Callback', (WidgetTester tester) async {
      bool actionCallbackTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: BaseHeaderBar(
            headerBarTitle: 'Test Title',
            leadingItems: DCHeaderBarItem(
              prefixIcon: Icon(Icons.arrow_back),
              onTap: (BuildContext context) {},
            ),
            actionItems: [
              DCHeaderBarItem(
                prefixIcon: Icon(Icons.notification_important),
                onTap: (BuildContext context) {
                  actionCallbackTriggered = true;
                },
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(IconButton).last);
      await tester.pumpAndSettle();

      expect(actionCallbackTriggered, true);
    });
  });
}
