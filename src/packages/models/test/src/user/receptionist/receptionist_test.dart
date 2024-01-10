import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';
void main() {
  // Unit tests for the `Receptionist` class
  group('Receptionist', () {
    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `Receptionist` instance
      final receptionist = Receptionist(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Copy the `Receptionist` instance
      final copy = receptionist.copyWith(
        id: 'id2',
        fullname: 'fullname2',
        email: 'email2',
        phone: 'phone2',
        birthday: DateTime(2001),
      );

      // Verify the copy
      expect(copy.id, 'id2');
      expect(copy.fullname, 'fullname2');
      expect(copy.email, 'email2');
      expect(copy.phone, 'phone2');
      expect(copy.birthday, DateTime(2001));
    });

    // Test the `fromJson` method
    test('fromJson', () {
      // Create a `Receptionist` instance
      final receptionist = Receptionist(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Create a JSON object
      final json = {
        'id': 'id',
        'fullname': 'fullname',
        'email': 'email',
        'phone': 'phone',
        'birthday': DateTime(2000).toIso8601String(),
      };

      // Convert the JSON object to a `Receptionist` instance
      final fromJson = Receptionist.fromJson(json);

      // Verify the conversion
      expect(fromJson, receptionist);
    });

    // Test the `toJson` method
    test('toJson', () {
      // Create a `Receptionist` instance
      final receptionist = Receptionist(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Create a JSON object
      final json = {
        'id': 'id',
        'fullname': 'fullname',
        'email': 'email',
        'phone': 'phone',
        'birthday': DateTime(2000).toIso8601String(),
      };

      // Convert the `Receptionist` instance to a JSON object
      final toJson = receptionist.toJson();

      // Verify the conversion
      expect(toJson, json);
    });
  });
}
