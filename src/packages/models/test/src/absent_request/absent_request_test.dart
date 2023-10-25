import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  // Unit tests for the `AbsentRequest` class
  group('AbsentRequest', () {
    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `AbsentRequest` instance
      final absentRequest = AbsentRequest(
        doctorID: 'doctorID',
        date: DateTime(2023,10,25),
        doctorName: 'doctorName',
        dateRequest: '2023-10-25',
        reason: 'reason',
        isApproved: true,
      );

      // Copy the `AbsentRequest` instance
      final copy = absentRequest.copyWith(
        doctorID: 'doctorID2',
        date: DateTime(2023,10,25),
        doctorName: 'doctorName2',
        dateRequest: '2023-10-25',
        reason: 'reason2',
        isApproved: true,
      );

      // Verify the copy
      expect(copy.doctorID, 'doctorID2');
      expect(copy.date, DateTime(2023,10,25));
      expect(copy.doctorName, 'doctorName2');
      expect(copy.dateRequest, '2023-10-25');
      expect(copy.reason, 'reason2');
      expect(copy.isApproved, true);
    });

    // Test the `fromJson` method
    test('fromJson', () {
      // Create a `AbsentRequest` instance
      final absentRequest = AbsentRequest(
        doctorID: 'doctorID',
        date: DateTime(2023,10,25),
        doctorName: 'doctorName',
        dateRequest: '2023-10-25',
        reason: 'reason',
        isApproved: true,
      );

      // Create a JSON object
      final json = {
        'doctorID': 'doctorID',
        'date': DateTime(2023,10,25).toIso8601String(),
        'doctorName': 'doctorName',
        'dateRequest': '2023-10-25',
        'reason': 'reason',
        'isApproved': true,
      };

      // Convert the JSON object to a `AbsentRequest` instance
      final fromJson = AbsentRequest.fromJson(json);

      // Verify the conversion
      expect(fromJson, absentRequest);
    });

    // Test the `toJson` method
    test('toJson', () {
      // Create a `AbsentRequest` instance
      final absentRequest = AbsentRequest(
        doctorID: 'doctorID',
        date: DateTime(2023,10,25),
        doctorName: 'doctorName',
        dateRequest: '2023-10-25',
        reason: 'reason',
        isApproved: true,
      );

      // Create a JSON object
      final json = {
        'doctorID': 'doctorID',
        'date': DateTime(2023,10,25).toIso8601String(),
        'doctorName': 'doctorName',
        'dateRequest': '2023-10-25',
        'reason': 'reason',
        'isApproved': true,
      };

      // Convert the `AbsentRequest` instance to a JSON object
      final toJson = absentRequest.toJson();

      // Verify the conversion
      expect(toJson, json);
    });
  });
}
