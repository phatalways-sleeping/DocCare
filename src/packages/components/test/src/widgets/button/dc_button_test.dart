import 'package:components/src/widgets/button/dc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DCButton Widget Tests', () {
    testWidgets('DCButton renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCButton(
              key: const Key('myButton'),
              onPressed: (context) {}, // Provide a simple empty callback for testing
              text: 'Press Me',
            ),
          ),
        ),
      );

      // Verify that DCButton widget is rendered.
      expect(find.byKey(const Key('myButton')), findsOneWidget);

      // Verify that the text is rendered.
      expect(find.text('Press Me'), findsOneWidget);
       
    });

  });
}