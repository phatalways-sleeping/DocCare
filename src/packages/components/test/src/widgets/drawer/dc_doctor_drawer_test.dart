import 'package:components/src/widgets/drawer/dc_doctor_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test for [DCDoctorDrawer]
  group('DCDoctorDrawer', () {
    test('DCDoctorDrawer should have correct properties', () {
      const widthFactor = 0.5;
      const borderRadius = BorderRadius.all(Radius.circular(16));
      const elevation = 16.0;
      const backgroundColor = Colors.white;

      void onProfileTap(BuildContext context) {}
      void onIntakeTap(BuildContext context) {}
      void onLogoutTap(BuildContext context) {}

      final drawer = DCDoctorDrawer(
        widthFactor: widthFactor,
        borderRadius: borderRadius,
        elevation: elevation,
        backgroundColor: backgroundColor,
        onProfileSelected: onProfileTap,
        onAbsentRequestSelected: onIntakeTap,
        onSignOutSelected: onLogoutTap,
      );

      expect(drawer.widthFactor, widthFactor);
      expect(drawer.borderRadius, borderRadius);
      expect(drawer.elevation, elevation);
      expect(drawer.backgroundColor, backgroundColor);
      expect(drawer.onProfileSelected, onProfileTap);
      expect(drawer.onAbsentRequestSelected, onIntakeTap);
      expect(drawer.onSignOutSelected, onLogoutTap);
    });

    testWidgets('DCDoctorDrawer should have correct properties',
        (tester) async {
      const widthFactor = 0.5;
      const borderRadius = BorderRadius.all(Radius.circular(16));
      const elevation = 16.0;
      const backgroundColor = Colors.white;

      void onProfileTap(BuildContext context) {}
      void onIntakeTap(BuildContext context) {}
      void onLogoutTap(BuildContext context) {}

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCDoctorDrawer(
              widthFactor: widthFactor,
              borderRadius: borderRadius,
              elevation: elevation,
              backgroundColor: backgroundColor,
              onProfileSelected: onProfileTap,
              onAbsentRequestSelected: onIntakeTap,
              onSignOutSelected: onLogoutTap,
            ),
          ),
        ),
      );

      final drawer =
          tester.widget<DCDoctorDrawer>(find.byType(DCDoctorDrawer));

      expect(drawer.widthFactor, widthFactor);
      expect(drawer.borderRadius, borderRadius);
      expect(drawer.elevation, elevation);
      expect(drawer.backgroundColor, backgroundColor);
      expect(drawer.onProfileSelected, onProfileTap);
      expect(drawer.onAbsentRequestSelected, onIntakeTap);
      expect(drawer.onSignOutSelected, onLogoutTap);
    });
  });
}
