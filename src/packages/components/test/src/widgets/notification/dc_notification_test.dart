import 'package:components/src/widgets/notification/dc_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test cases for [NotificationWidget]
  group('NotificationWidget', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DCNotification(
            title: Text('Hello World'),
            message: Text('This is a notification'),
            backgroundColor: Colors.deepPurple,
            notificationTime: DateTime(2023, 1, 1, 8, 30),
            haveNotificationTime: true,
            textColor: Colors.white,
            heightFactor: 0.16,
            onPressed: (context) {},
          ),
        ),
      ));

      /// Verify that our [NotificationWidget] has the correct title.
      expect(find.text('Hello World'), findsOneWidget);

      /// Verify that our [NotificationWidget] has the correct message.
      expect(find.text('This is a notification'), findsOneWidget);

      /// Verify that our [NotificationWidget] has the correct time.
      expect(find.text('08:30 AM, 1 Jan 2023'), findsOneWidget);
    });
  });
}
