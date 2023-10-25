import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Category', () {
    test('constructor', () {
      // Create a `Category` instance
      final category1 = Category(
        name: 'Glucose',
        description: 'Sugar Amount in Blood',
      );

      expect(category1.name, 'Glucose');
      expect(category1.description, 'Sugar Amount in Blood');
    });

    test('toJson', () {
      final category = Category(
        name: 'Glucose',
        description: 'Sugar Amount in Blood',
      );

      final json = category.toJson();

      final expectedJson = {
        "name": "Glucose",
        "description": "Sugar Amount in Blood",
      };

      expect(json, expectedJson);
    });

    test('fromJson', () {
      final categoryJson = {
        "name": "Glucose",
        "description": "Sugar Amount in Blood",
      };

      final category = Category.fromJson(categoryJson);

      final expectedCategory = Category(
        name: 'Glucose',
        description: 'Sugar Amount in Blood',
      );

      expect(category, expectedCategory);
    });

    test('copyWith', () {
      final category1 = Category(
        name: 'Glucose',
        description: 'Sugar Amount in Blood',
      );

      final category2 = category1.copyWith();

      expect(category1, category2);

      final category3 = category1.copyWith(
        name: 'Vitamins',
      );

      expect(category3.name, 'Vitamins');
      expect(category3.description, category1.description);
    });
  });
}
