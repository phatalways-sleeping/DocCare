import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:components/src/widgets/pop_up/dc_pop_up_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DCPopUpSuccess', () {
    testWidgets('Render DCPopUpSuccess', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SizedBox.shrink()),
        ),
      );
      expect(find.byType(DCPopupSuccess), findsOneWidget);

      //Base popup has to be here
      expect(find.byType(BasePopup), findsOneWidget);

      expect(find.text('Title'), findsOneWidget);

      expect(find.text('Message'), findsOneWidget);

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      expect(button, isNotNull);
    });

    testWidgets('Render with optional size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SizedBox.shrink()),
        ),
      );
      expect(find.byType(DCPopupSuccess), findsOneWidget);

      //Icon has to have the optional size
      final icon = tester.widget<SvgPicture>(
        find.byType(SvgPicture),
      );

      expect(icon.width, 50);
      expect(icon.height, 50);
    });

    testWidgets('Close pop-up', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SizedBox.shrink()),
        ),
      );
      expect(find.byType(DCPopupSuccess), findsOneWidget);

      await tester.tap(find.text('Button Text'));
      await tester.pumpAndSettle();
      expect(find.byType(DCPopupSuccess), findsNothing);
    });
  });
}
