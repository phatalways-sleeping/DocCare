import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Appointment', () {
    test('copyWith', () {
      final appointment = Appointment(
        customerID: 'customerID',
        doctorID: 'doctorID',
        period: 1,
        date: DateTime(2023, 10, 24),
        customerComment: 'customer_comment',
      );

      final copy = appointment.copyWith(
        customerID: 'customerID2',
        doctorID: 'doctorID2',
        period: 2,
        date: DateTime(2024, 10, 24),
        customerComment: 'customer_comment2',
      );

      expect(copy.customerID, 'customerID2');
      expect(copy.doctorID, 'doctorID2');
      expect(copy.period, 2);
      expect(copy.date, DateTime(2024, 10, 24));
      expect(copy.customerComment, 'customer_comment2');
    });

    test('fromJson', () {
      final appointment = Appointment(
        customerID: 'customerID',
        doctorID: 'doctorID',
        period: 1,
        date: DateTime(2023, 10, 24),
        rating: 3,
        customerComment: 'customerComment',
      );

      final json = {
        'customerID': 'customerID',
        'doctorID': 'doctorID',
        'period': 1,
        'date': '2023-10-24T00:00:00.000',
        'rating': 3,
        'customerComment': 'customerComment',
      };

      expect(Appointment.fromJson(json), appointment);
    });

    test('toJson', () {
      final appointment = Appointment(
        customerID: 'customerID',
        doctorID: 'doctorID',
        period: 1,
        date: DateTime(2023, 10, 24),
        rating: 3,
        customerComment: 'customerComment',
      );

      final json = {
        'customerID': 'customerID',
        'doctorID': 'doctorID',
        'period': 1,
        'date': '2023-10-24T00:00:00.000',
        'rating': 3,
        'customerComment': 'customerComment',
      };

      expect(appointment.toJson(), json);
    });
  });
}
