import 'package:components/src/widgets/button/dc_dropdownButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('dropdownButton', () {
    testWidgets('dropdownButton should render correctly', (WidgetTester tester) async {
       
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DCDropdownButton<String>(
            key: Key('myDropdownButton'),
            items:  ['ItemX 1', 'ItemX 2', 'ItemX 3'],
            dropdownWidth: 300,
          ),
        ),
      ));

      // Verify that DCDropdownButton widget is rendered.
      expect(find.byKey(Key('myDropdownButton')), findsOneWidget);


      // Verify that the dropdown menu items are rendered.
      expect(find.text('ItemX 1').last, findsOneWidget);
      expect(find.text('ItemX 2'), findsOneWidget);
      expect(find.text('ItemX 3'), findsOneWidget);
    });
  });
}