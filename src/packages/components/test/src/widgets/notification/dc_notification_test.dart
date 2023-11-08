import 'package:components/src/widgets/notification/dc_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test cases for [NotificationWidget]
  group('NotificationWidget', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCNotification(
              title: 'Title',
              message: 'Message',
              notificationTime: DateTime(2023, 1, 1, 8, 30),
            ),
          ),
        ),
      );

      /// Verify that our [NotificationWidget] has the correct title.
      expect(find.text('Title'), findsOneWidget);

      /// Verify that our [NotificationWidget] has the correct message.
      expect(find.text('Message'), findsOneWidget);

      /// Verify that our [NotificationWidget] has the correct time.
      expect(find.text('08:30 AM, 1 Jan 2023'), findsOneWidget);
    });
  });
}
