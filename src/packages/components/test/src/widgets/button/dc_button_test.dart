import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:components/src/widgets/button/dc_button.dart';

void main() {
  group('DCButton Widget Tests', () {
    testWidgets('DCButton renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCButton(
              key: Key('myButton'),
              onPressed:
                  (context) {}, // Provide a simple empty callback for testing
              text: 'Press Me',
            ),
          ),
        ),
      );

      // Verify that DCButton widget is rendered.
      expect(find.byKey(Key('myButton')), findsOneWidget);

      // Verify that the text is rendered.
      expect(find.text('Press Me'), findsOneWidget);
    });
  });
}
