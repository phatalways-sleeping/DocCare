import 'package:components/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test cases for [DCOutlinedObscuredTextFormField]
  /// Test cases include:
  /// 1. [DCOutlinedObscuredTextFormField] renders correctly with default, customised obscure widget and obscure text
  /// 2. [DCOutlinedObscuredTextFormField] does not render obscure widget when obscure text is false
  /// 3. [DCOutlinedObscuredTextFormField] renders obscure widget when obscure text is true
  group('DCOutlinedObscuredTextFormField', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      /// Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCOutlinedObscuredTextFormField(
              hintText: 'Hint Text',
              labelText: 'Label Text',
              helperText: 'Helper Text',
              keyboardType: TextInputType.text,
              onChanged: (context, controller) {},
              color: Colors.red,
              borderColor: Colors.red,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      );

      /// Verify that our [DCOutlinedObscuredTextFormField] has the correct obscure widget.
      expect(find.byType(IconButton), findsOneWidget);

      /// Verify that our [DCOutlinedObscuredTextFormField] has the correct obscure widget icon.
      /// The obscure widget icon should be [SvgPicture.string(DCSVGIcons.hide)]
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
