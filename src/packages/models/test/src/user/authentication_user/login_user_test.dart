import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  // Unit tests for the `LoginUser` class
  group('LoginUser', () {
    // Test create a `LoginUser` instance
    test('create', () {
      // Create a `LoginUser` instance
      const loginUser = LoginUser(
        'email',
        'password',
      );

      // Verify the instance
      expect(loginUser.email, 'email');
      expect(loginUser.password, 'password');
    });

    // Test the factory `from` method
    test('from', () {
      // Create a `LoginUser` instance
      const loginUser = LoginUser(
        'email',
        'password',
      );

      // Create a `LoginUser` instance from the `from` method
      final from = LoginUser.from(
        loginUser,
      );

      // Verify the instance
      expect(from, loginUser);
    });


    // Test the `copyWith` method
    test('copyWith', () {
      // Create a `LoginUser` instance
      const loginUser = LoginUser(
        'email',
        'password',
      );

      // Copy the `LoginUser` instance
      final copy = loginUser.copyWith(
        email: 'email2',
        password: 'password2',
      );

      // Verify the copy
      expect(copy.email, 'email2');
      expect(copy.password, 'password2');
    });
  });
}
