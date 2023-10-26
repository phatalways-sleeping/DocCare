import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('WorkingShift', () {
    test('constructor', () {
      // Create a `WorkingShift` instance
      final WorkingShift1 = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      expect(WorkingShift1.doctorID, '456');
      expect(WorkingShift1.startPeriodID, 1);
      expect(WorkingShift1.dayOfWeek, 'Monday');
      expect(WorkingShift1.endPeriodID, 10);
    });

    test('toJson', () {
      final WorkingShift = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      final json = WorkingShift.toJson();

      final expectedJson = {
        'doctorID': '456',
        'startPeriodID': 1,
        'dayOfWeek': 'Monday',
        'endPeriodID': 10,
      };

      expect(json, expectedJson);
    });

    test('fromJson', () {
      final WorkingShiftJson = {
        'doctorID': '456',
        'startPeriodID': 1,
        'dayOfWeek': 'Monday',
        'endPeriodID': 10,
      };

      final WorkingShift = WorkingShift.fromJson(WorkingShiftJson);

      final expectedWorkingShift = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      expect(WorkingShift, expectedWorkingShift);
    });

    test('copyWith', () {
      final WorkingShift1 = WorkingShift(
        doctorID: '456',
        startPeriodID: 1,
        dayOfWeek: 'Monday',
        endPeriodID: 10,
      );

      final WorkingShift2 = WorkingShift1.copyWith();

      expect(WorkingShift1, WorkingShift2);

      final WorkingShift3 = WorkingShift1.copyWith(
        doctorID: '456',
        startPeriodID: 1,
      );

      expect(WorkingShift3.doctorID, '456');
      expect(WorkingShift3.startPeriodID, 1);
    });
  });
}
