import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';
void main() {
  // Unit tests for the `Customer` class
  group('Customer', () {
    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `Customer` instance
      final customer = Customer(
        id: 'id',
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Copy the `Customer` instance
      final copy = customer.copyWith(
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
      // Create a `Customer` instance
      final customer = Customer(
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

      // Convert the JSON object to a `Customer` instance
      final fromJson = Customer.fromJson(json);

      // Verify the conversion
      expect(fromJson, customer);
    });

    // Test the `toJson` method
    test('toJson', () {
      // Create a `Customer` instance
      final customer = Customer(
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

      // Convert the `Customer` instance to a JSON object
      final toJson = customer.toJson();

      // Verify the conversion
      expect(toJson, json);
    });
  });
}
