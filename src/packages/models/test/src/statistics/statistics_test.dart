import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  // Unit tests for the `Statistics` class
  group('Statistics', () {
    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `Statistics` instance
      const statistics = Statistics(
        id: '',
        value: '',
        categoryName: 'categoryName',
        prescriptionID: '1',
        // note: 'note',
      );

      // Copy the `Statistics` instance
      final copy = statistics.copyWith(
        id: '',
        value: '',
        categoryName: 'categoryName2',
        prescriptionID: '2',
      );

      // Verify the copy
      expect(copy.id, 2);
      expect(copy.value, 101);
      expect(copy.categoryName, 'categoryName2');
      expect(copy.prescriptionID, '2');
      // expect(copy.note, 'note2');
    });

    // Test the `fromJson` method
    test('fromJson', () {
      // Create a `Statistics` instance
      const statistics = Statistics(
        id: '',
        value: '',
        categoryName: 'categoryName',
        prescriptionID: '1',
        // note: 'note',
      );

      // Create a JSON object
      final json = {
        'id': 1,
        'value': 100,
        'categoryName': 'categoryName',
        'prescriptionID': '1',
        'note': 'note',
      };

      // Convert the JSON object to a `Statistics` instance
      final fromJson = Statistics.fromJson(json);

      // Verify the conversion
      expect(fromJson, statistics);
    });

    // Test the `toJson` method
    test('toJson', () {
      // Create a `Statistics` instance
      const statistics = Statistics(
        id: '',
        value: '',
        categoryName: 'categoryName',
        prescriptionID: '1',
        // note: 'note',
      );

      // Create a JSON object
      final json = {
        'id': 1,
        'value': 100,
        'categoryName': 'categoryName',
        'prescriptionID': '1',
        'note': 'note',
      };

      // Convert the `Statistics` instance to a JSON object
      final toJson = statistics.toJson();

      // Verify the conversion
      expect(toJson, json);
    });
  });
}
