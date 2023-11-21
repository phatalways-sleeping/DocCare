import 'package:components/src/widgets/text_form_field/base_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test cases for [BaseTextFormField]
  group('BaseTextFormField', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseTextFormField(
              hintText: 'Hint Text',
              labelText: 'Label Text',
              helperText: 'Helper Text',
              constraints: const BoxConstraints.expand(),
              obscureMode: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
              textCapitalization: TextCapitalization.characters,
              initialText: 'Initial Text',
              onChanged: (context, controller) {},
              color: Colors.red,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
            ),
          ),
        ),
      );

      /// Verify that our [BaseTextFormField] has the correct text.
      expect(find.text('Hint Text'), findsOneWidget);

      /// Verify that our [BaseTextFormField] has the correct text.
      expect(find.text('Label Text'), findsOneWidget);

      /// Verify that our [BaseTextFormField] has the correct color.
      expect(
          tester
              .widget<TextField>(find.byType(TextField))
              .decoration!
              .hintStyle!
              .color,
          Colors.red.withOpacity(0.8));

      /// Verify that our [BaseTextFormField] has the correct content padding.
      expect(
        tester
            .widget<TextField>(find.byType(TextField))
            .decoration!
            .contentPadding,
        const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      );

      /// Verify that our [BaseTextFormField] has the correct border.
      expect(
        tester
            .widget<TextField>(find.byType(TextField))
            .decoration!
            .enabledBorder,
        const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      );

      /// Verify that our [BaseTextFormField] has the correct text input type.
      expect(
        tester.widget<TextField>(find.byType(TextField)).keyboardType,
        TextInputType.text,
      );

      /// Verify that our [BaseTextFormField] has the correct obscure mode.
      expect(
        tester.widget<TextField>(find.byType(TextField)).obscureText,
        true,
      );

      /// Verify that our [BaseTextFormField] has the correct helper text.
      expect(
        tester.widget<TextField>(find.byType(TextField)).decoration!.helperText,
        'Helper Text',
      );

      /// Verify that our [BaseTextFormField] has the correct text align.
      expect(
        tester.widget<TextField>(find.byType(TextField)).textAlign,
        TextAlign.center,
      );

      /// Verify that our [BaseTextFormField] has the correct text align vertical.
      expect(
        tester.widget<TextField>(find.byType(TextField)).textAlignVertical,
        TextAlignVertical.bottom,
      );

      /// Verify that our [BaseTextFormField] has the correct text capitalization.
      expect(
        tester.widget<TextField>(find.byType(TextField)).textCapitalization,
        TextCapitalization.characters,
      );

      /// Verify that our [BaseTextFormField] has the correct initial text.
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'Initial Text',
      );
    });

    /// Test cases for [BaseTextFormField] for focus node.
    testWidgets('should render correctly with focus node',
        (WidgetTester tester) async {
      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseTextFormField(
              hintText: 'Hint Text',
              labelText: 'Label Text',
              helperText: 'Helper Text',
              obscureMode: true,
              keyboardType: TextInputType.text,
              onChanged: (context, controller) {},
              color: Colors.red,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              constraints: const BoxConstraints.expand(),
            ),
          ),
        ),
      );

      // Tap the text field to trigger the focus.
      await tester.tap(find.byType(TextField));
      // Wait for the animation to finish before continuing.
      await tester.pumpAndSettle();
      // Verify that our [BaseTextFormField] has the correct focus node.
      expect(
        tester.widget<TextField>(find.byType(TextField)).focusNode!.hasFocus,
        true,
      );
    });

    /// Test cases for [BaseTextFormField] for on changed.
    testWidgets('should render correctly with on changed',
        (WidgetTester tester) async {
      final onChangedList = List<String>.empty(growable: true);

      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BaseTextFormField(
              constraints: const BoxConstraints.expand(),
              hintText: 'Hint Text',
              labelText: 'Label Text',
              helperText: 'Helper Text',
              obscureMode: true,
              initialText: 'Initial Text',
              keyboardType: TextInputType.text,
              onChanged: (context, controller) {
                onChangedList.add(controller.text);
              },
              color: Colors.red,
              inputBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      );

      // Tap the text field to trigger the focus.
      await tester.tap(find.byType(TextField));
      // Wait for the animation to finish before continuing.
      await tester.pumpAndSettle();
      // Input text in the text field to trigger the on changed.
      await tester.enterText(find.byType(TextField), 'Test');
      // Wait for the animation to finish before continuing.
      await tester.pumpAndSettle();
      // Verify that our [BaseTextFormField] has the correct on changed.
      expect(onChangedList, ['Test']);
    });
  });
}
