import 'package:components/src/widgets/header_bar/dc_header_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DCHeaderBar', () {
    testWidgets('Render DCHeaderBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DCHeaderBar(
            title: 'Test Title',
            onDrawerPressed: () {}, // Mock callback
            onNotificationPressed: () {}, // Mock callback
          ),
        ),
      );
      expect(find.byType(DCHeaderBar), findsOneWidget);

      expect(find.text('Test Title'), findsOneWidget);

      expect(find.byType(IconButton),
          findsNWidgets(2)); // Two icons (drawer and notification)
    });

    testWidgets('Trigger Drawer Icon Callback', (WidgetTester tester) async {
      bool drawerCallbackTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: DCHeaderBar(
            title: 'Test Title',
            onDrawerPressed: () {
              drawerCallbackTriggered = true;
            },
            onNotificationPressed: () {}, // Mock callback
          ),
        ),
      );

      await tester
          .tap(find.byType(IconButton).first); // Tap the first icon (drawer)
      await tester.pumpAndSettle();

      expect(drawerCallbackTriggered, true);
    });

    testWidgets('Trigger Notification Icon Callback',
        (WidgetTester tester) async {
      bool notificationCallbackTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: DCHeaderBar(
            title: 'Test Title',
            onDrawerPressed: () {}, // Mock callback
            onNotificationPressed: () {
              notificationCallbackTriggered = true;
            },
          ),
        ),
      );

      await tester.tap(
          find.byType(IconButton).last); // Tap the last icon (notification)
      await tester.pumpAndSettle();

      expect(notificationCallbackTriggered, true);
    });
  });
}
