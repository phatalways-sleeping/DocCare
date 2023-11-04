// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:auth_api/auth_api.dart';

void main() {
  group('AuthApi', () {
    test('can be instantiated', () {
      expect(AuthApi(), isNotNull);
    });
  });
}
