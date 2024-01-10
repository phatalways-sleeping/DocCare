import 'package:components/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test cases for [DCOutlinedWithHeadingTextFormField]
  /// Test cases include:
  /// 1. [DCOutlinedWithHeadingTextFormField] renders correctly with default, including checking heading, and its color

  group('DCOutlinedWithHeadingTextFormField', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DCOutlinedWithHeadingTextFormField(
                hintText: 'Hint Text',
                helperText: 'Helper Text',
                keyboardType: TextInputType.text,
                onChanged: (context, controller) {},
                color: Colors.red,
                borderColor: Colors.red,
                contentPadding: EdgeInsets.zero,
                heading: const Text(
                  'Heading Text',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      );

      /// Verify that our [DCOutlinedWithHeadingTextFormField] has the correct heading.
      expect(find.text('Heading Text'), findsOneWidget);
    });


    /// Test when useObscuredTextFormField is true
    testWidgets('should render correctly when useObscuredTextFormField is true', (WidgetTester tester) async {
      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DCOutlinedWithHeadingTextFormField(
                hintText: 'Hint Text',
                helperText: 'Helper Text',
                keyboardType: TextInputType.text,
                onChanged: (context, controller) {},
                color: Colors.red,
                borderColor: Colors.red,
                contentPadding: EdgeInsets.zero,
                heading: const Text(
                  'Heading Text',
                  style: TextStyle(color: Colors.red),
                ),
                useObscuredTextFormField: true,
              ),
            ),
          ),
        ),
      );

      /// Verify that our [DCOutlinedWithHeadingTextFormField] has [DCOutlinedObscuredTextFormField]
      expect(find.byType(DCOutlinedObscuredTextFormField), findsOneWidget);
    });
  });
}
