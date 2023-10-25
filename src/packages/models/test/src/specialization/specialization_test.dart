import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Specialization', () {
    test('copyWith', () {
      final specialization = Specialization(
        name: 'name',
        description: 'description',
        numMembers: 1,
      );

      final copy = specialization.copyWith(
        name: 'name2',
        description: 'description2',
        numMembers: 2,
      );

      expect(copy.name, 'name2');
      expect(copy.description, 'description2');
      expect(copy.numMembers, 2);
    });

    test('fromJson', () {
      const specialization = Specialization(
        name: 'name',
        description: 'description',
        numMembers: 1,
      );

      final json = {
        'name': 'name',
        'description': 'description',
        'numMembers': 1,
      };

      expect(Specialization.fromJson(json), specialization);
    });

    test('toJson', () {
      const specialization = Specialization(
        name: 'name',
        description: 'description',
        numMembers: 1,
      );

      final json = {
        'name': 'name',
        'description': 'description',
        'numMembers': 1,
      };

      expect(specialization.toJson(), json);
    });
  });
}
