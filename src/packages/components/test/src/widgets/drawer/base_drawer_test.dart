import 'package:components/src/widgets/drawer/base_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Test for [DCDrawerItem]
  group('DCDrawerItem', () {
    test('DCDrawerItem should have correct properties', ()  {
      const icon = Icon(Icons.ac_unit);
      const title = Text('Title');
      void onTap(context) {}
      const selected = false;

      final item = DCDrawerItem(
        title: title,
        prefixIcon: icon,
        onTap: onTap,
      );

      expect(item.prefixIcon, icon);
      expect(item.title, title);
      expect(item.onTap, onTap);
      expect(item.selected, selected);
    });

    testWidgets('DCDrawerItem should have correct properties',
        (tester) async {
      const icon = Icon(Icons.ac_unit);
      const title = Text('Title');
      final void Function(BuildContext context) onTap = (context) {};
      const selected = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DCDrawerItem(
              title: title,
              prefixIcon: icon,
              onTap: onTap,
            ),
          ),
        ),
      );

      final item = tester.widget<DCDrawerItem>(find.byType(DCDrawerItem));

      expect(item.prefixIcon, icon);
      expect(item.title, title);
      expect(item.onTap, onTap);
      expect(item.selected, selected);
    });
  });

  /// Test for [BaseDrawer]
  group('BaseDrawer', () {
    test('BaseDrawer should have correct properties', ()  {
      const widthFactor = 0.5;
      const borderRadius = BorderRadius.all(Radius.circular(16));
      const elevation = 16.0;
      const backgroundColor = Colors.white;
      const surfaceTintColor = Colors.white;
      const semanticLabel = 'label';
      const clipBehavior = Clip.antiAlias;
      const headerImage = SizedBox.shrink();
      const items = <DCDrawerItem>[];

      const drawer = BaseDrawer(
        widthFactor: widthFactor,
        borderRadius: borderRadius,
        elevation: elevation,
        backgroundColor: backgroundColor,
        surfaceTintColor: surfaceTintColor,
        semanticLabel: semanticLabel,
        clipBehavior: clipBehavior,
        headerImage: headerImage,
      );

      expect(drawer.widthFactor, widthFactor);
      expect(drawer.borderRadius, borderRadius);
      expect(drawer.elevation, elevation);
      expect(drawer.backgroundColor, backgroundColor);
      expect(drawer.surfaceTintColor, surfaceTintColor);
      expect(drawer.semanticLabel, semanticLabel);
      expect(drawer.clipBehavior, clipBehavior);
      expect(drawer.headerImage, headerImage);
      expect(drawer.items, items);
    });

    testWidgets('BaseDrawer should have correct properties',
        (tester) async {
      const widthFactor = 0.5;
      const borderRadius = BorderRadius.all(Radius.circular(16));
      const elevation = 16.0;
      const backgroundColor = Colors.white;
      const surfaceTintColor = Colors.white;
      const semanticLabel = 'label';
      const clipBehavior = Clip.antiAlias;
      const headerImage = SizedBox.shrink();
      const items = <DCDrawerItem>[];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BaseDrawer(
              widthFactor: widthFactor,
              borderRadius: borderRadius,
              elevation: elevation,
              backgroundColor: backgroundColor,
              surfaceTintColor: surfaceTintColor,
              semanticLabel: semanticLabel,
              clipBehavior: clipBehavior,
              headerImage: headerImage,
            ),
          ),
        ),
      );

      final drawer = tester.widget<BaseDrawer>(find.byType(BaseDrawer));

      expect(drawer.widthFactor, widthFactor);
      expect(drawer.borderRadius, borderRadius);
      expect(drawer.elevation, elevation);
      expect(drawer.backgroundColor, backgroundColor);
      expect(drawer.surfaceTintColor, surfaceTintColor);
      expect(drawer.semanticLabel, semanticLabel);
      expect(drawer.clipBehavior, clipBehavior);
      expect(drawer.headerImage, headerImage);
      expect(drawer.items, items);
    });
  });
}
