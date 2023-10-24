import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Category', () {
    test('copyWith', () {
      // Create a `Category` instance
      final category1 = Category(
        name: 'Glucose',
        description: 'Sugar Amount in Blood',
      );

      // Copy category without changing any properties
      final category2 = category1.copyWith();

      // Verify the copy
      expect(category1.name, category2.name);
      expect(category2.description, 'Sugar Amount in Blood');

      // Copy category with null description
      final category3 = category1.copyWith(
        name: 'Glucose',
      );

      expect(category3.description, category1.description);

      // JSON object
      final categoryJson = {
        "name": "Glucose",
        "description": "Sugar Amount in Blood",
      };

      // To instance
      final categoryFromJson = Category.fromJson(categoryJson);
      expect(categoryFromJson, category1);

      // To JSON
      final jsonFromCategory = category1.toJson();
      expect(jsonFromCategory, categoryJson);
    });
  });
}
