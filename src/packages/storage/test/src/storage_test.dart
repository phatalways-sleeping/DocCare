// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:storage/storage.dart';

void main() {
  group('Storage', () {
    test('can be instantiated', () {
      expect(Storage(), isNotNull);
    });
  });
}
