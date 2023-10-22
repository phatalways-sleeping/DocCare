import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  // Unit tests for the `Doctor` class
  group('Doctor', () {
    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `Doctor` instance
      final doctor = Doctor(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
        specializationId: 'specializationId',
        startWorkingFrom: 2000,
        rating: 4.5,
        numberOfRates: 100,
      );

      // Copy the `Doctor` instance
      final copy = doctor.copyWith(
        id: 'id2',
        fullname: 'fullname2',
        email: 'email2',
        phone: 'phone2',
        birthday: DateTime(2001),
        specializationId: 'specializationId2',
        startWorkingFrom: 2001,
        rating: 4.6,
        numberOfRates: 101,
      );

      // Verify the copy
      expect(copy.id, 'id2');
      expect(copy.fullname, 'fullname2');
      expect(copy.email, 'email2');
      expect(copy.phone, 'phone2');
      expect(copy.birthday, DateTime(2001));
      expect(copy.specializationId, 'specializationId2');
      expect(copy.startWorkingFrom, 2001);
      expect(copy.rating, 4.6);
      expect(copy.numberOfRates, 101);
    });

    // Test the `fromJson` method
    test('fromJson', () {
      // Create a `Doctor` instance
      final doctor = Doctor(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
        specializationId: 'specializationId',
        startWorkingFrom: 2000,
        rating: 4.5,
        numberOfRates: 100,
      );

      // Create a JSON object
      final json = {
        'id': 'id',
        'fullname': 'fullname',
        'email': 'email',
        'phone': 'phone',
        'birthday': DateTime(2000).toIso8601String(),
        'specializationId': 'specializationId',
        'startWorkingFrom': 2000,
        'rating': 4.5,
        'numberOfRates': 100,
      };

      // Convert the JSON object to a `Doctor` instance
      final fromJson = Doctor.fromJson(json);

      // Verify the conversion
      expect(fromJson, doctor);
    });

    // Test the `toJson` method
    test('toJson', () {
      // Create a `Doctor` instance
      final doctor = Doctor(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
        specializationId: 'specializationId',
        startWorkingFrom: 2000,
        rating: 4.5,
        numberOfRates: 100,
      );

      // Create a JSON object
      final json = {
        'id': 'id',
        'fullname': 'fullname',
        'email': 'email',
        'phone': 'phone',
        'birthday': DateTime(2000).toIso8601String(),
        'specializationId': 'specializationId',
        'startWorkingFrom': 2000,
        'rating': 4.5,
        'numberOfRates': 100,
      };

      // Convert the `Doctor` instance to a JSON object
      final toJson = doctor.toJson();

      // Verify the conversion
      expect(toJson, json);
    });
  });
}

