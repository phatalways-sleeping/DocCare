import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  // Unit tests for the `Medicine` class
  group('Medicine', () {
    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `Medicine` instance
      final penicillin = Medicine(
        name: 'penicillin',
        unit: 'mg',
      );

      // Copy penicillin without changing any properties
      final amlodipine = penicillin.copyWith();

      // Verify the copy
      expect(amlodipine.name, 'penicillin');
      expect(amlodipine.unit, 'mg');

      //Copy peniciilin and change its properties
      final amoxicillin = penicillin.copyWith(name: 'amoxicillin', unit: 'ml');

      expect(amoxicillin.name, 'amoxicillin');
      expect(amoxicillin.unit, 'ml');
    });

    test('fromJson', () {
      //JSON object
      final json = {
        'name': 'penicillin',
        'unit': 'mg',
      };

      final penicillin = Medicine(
        name: 'penicillin',
        unit: 'mg',
      );

      //To instance
      final penicillinFromJson = Medicine.fromJson(json);
      expect(penicillinFromJson, penicillin);
    });

    //To JSON
    test('toJson', () {
      final json = {
        'name': 'penicillin',
        'unit': 'mg',
      };

      final penicillin = Medicine(
        name: 'penicillin',
        unit: 'mg',
      );

      final jsonFromPenicillin = penicillin.toJson();
      expect(jsonFromPenicillin, json);
    });
  });
}
