import 'package:components/src/widgets/drawer/dc_admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test for [DCAdminDrawer]
  group('DCAdminDrawer', () {
    test('DCAdminDrawer should have correct properties', () {
      const widthFactor = 0.5;
      const borderRadius = BorderRadius.all(Radius.circular(16));
      const elevation = 16.0;
      const backgroundColor = Colors.white;

      const drawer = DCAdminDrawer(
        widthFactor: widthFactor,
        borderRadius: borderRadius,
        elevation: elevation,
        backgroundColor: backgroundColor,
      );

      expect(drawer.widthFactor, widthFactor);
      expect(drawer.borderRadius, borderRadius);
      expect(drawer.elevation, elevation);
      expect(drawer.backgroundColor, backgroundColor);
    });

    testWidgets('DCAdminDrawer should have correct properties', (tester) async {
      const widthFactor = 0.5;
      const borderRadius = BorderRadius.all(Radius.circular(16));
      const elevation = 16.0;
      const backgroundColor = Colors.white;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DCAdminDrawer(
              widthFactor: widthFactor,
              borderRadius: borderRadius,
              elevation: elevation,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
      );

      final drawer = tester.widget<DCAdminDrawer>(find.byType(DCAdminDrawer));

      expect(drawer.widthFactor, widthFactor);
      expect(drawer.borderRadius, borderRadius);
      expect(drawer.elevation, elevation);
      expect(drawer.backgroundColor, backgroundColor);
    });
  });
}
