import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  // Unit tests for the `SignUpUser` class
  group('SignUpUser', () {
    // Test create a `SignUpUser` instance
    test('create', () {
      // Create a `SignUpUser` instance
      final signUpUser = SignupUser(
        fullname: 'fullname',
        email: 'email',
        password: 'password',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Verify the instance
      expect(signUpUser.fullname, 'fullname');
      expect(signUpUser.email, 'email');
      expect(signUpUser.password, 'password');
      expect(signUpUser.phone, 'phone');
      expect(signUpUser.birthday, DateTime(2000));
    });

    // Test the factory `from` method
    test('from', () {
      // Create a `SignUpUser` instance
      final signUpUser = SignupUser(
        fullname: 'fullname',
        email: 'email',
        password: 'password',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Create a `SignUpUser` instance from the `from` method
      final from = SignupUser.from(
        fullname: 'fullname',
        email: 'email',
        password: 'password',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Verify the instance
      expect(from, signUpUser);
    });

    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `SignUpUser` instance
      final signUpUser = SignupUser(
        fullname: 'fullname',
        email: 'email',
        password: 'password',
        phone: 'phone',
        birthday: DateTime(2000),
      );

      // Copy the `SignUpUser` instance
      final copy = signUpUser.copyWith(
        fullname: 'fullname2',
        email: 'email2',
        password: 'password2',
        phone: 'phone2',
        birthday: DateTime(2001),
      );

      // Verify the copy
      expect(copy.fullname, 'fullname2');
      expect(copy.email, 'email2');
      expect(copy.password, 'password2');
      expect(copy.phone, 'phone2');
      expect(copy.birthday, DateTime(2001));
    });
  });
}
