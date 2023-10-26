import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('WorkingShift', () {
    test('constructor', () {
      // Create a `WorkingShift` instance
      final workingshift1 = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      expect(workingshift1.doctorID, '456');
      expect(workingshift1.startPeriodID, 1);
      expect(workingshift1.dayOfWeek, 'Monday');
      expect(workingshift1.endPeriodID, 10);
    });

    test('toJson', () {
      final workingshift = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      final json = workingshift.toJson();

      final expectedJson = {
        'doctorID': '456',
        'startPeriodID': 1,
        'dayOfWeek': 'Monday',
        'endPeriodID': 10,
      };

      expect(json, expectedJson);
    });

    test('fromJson', () {
      final workingshiftJson = {
        'doctorID': '456',
        'startPeriodID': 1,
        'dayOfWeek': 'Monday',
        'endPeriodID': 10,
      };

      final workingshift = WorkingShift.fromJson(workingshiftJson);

      final expectedWorkingShift = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      expect(workingshift, expectedWorkingShift);
    });

    test('copyWith', () {
      final workingshift = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      final workingshift2 = workingshift.copyWith();

      expect(workingshift, workingshift2);

      final workingshift3 = workingshift.copyWith(
        doctorID: '456',
        startPeriodID: 1,
      );

      expect(workingshift3.doctorID, '456');
      expect(workingshift3.startPeriodID, 1);
    });
  });
}
