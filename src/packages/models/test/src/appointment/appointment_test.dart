import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Appointment', () {
    test('copyWith', () {
      final appointment = Appointment(
        customer_id: 'customer_id',
        doctor_id: 'doctor_id',
        period: 1,
        date: DateTime(2023, 10, 24),
        customer_comment: 'customer_comment',
      );

      final copy = appointment.copyWith(
        customer_id: 'customer_id2',
        doctor_id: 'doctor_id2',
        period: 2,
        date: DateTime(2024, 10, 24),
        customer_comment: 'customer_comment2',
      );

      expect(copy.customer_id, 'customer_id2');
      expect(copy.doctor_id, 'doctor_id2');
      expect(copy.period, 2);
      expect(copy.date, DateTime(2024, 10, 24));
      expect(copy.customer_comment, 'customer_comment2');
    });

    test('fromJson', () {
      final appointment = Appointment(
        customer_id: 'customer_id',
        doctor_id: 'doctor_id',
        period: 1,
        date: DateTime(2023, 10, 24),
        rating: 3,
        customer_comment: 'customer_comment',
      );

      final json = {
        'customer_id': 'customer_id',
        'doctor_id': 'doctor_id',
        'period': 1,
        'date': '2023-10-24T00:00:00.000',
        'rating': 3,
        'customer_comment': 'customer_comment',
      };

      expect(Appointment.fromJson(json), appointment);
    });

    test('toJson', () {
      final appointment = Appointment(
        customer_id: 'customer_id',
        doctor_id: 'doctor_id',
        period: 1,
        date: DateTime(2023, 10, 24),
        rating: 3,
        customer_comment: 'customer_comment',
      );

      final json = {
        'customer_id': 'customer_id',
        'doctor_id': 'doctor_id',
        'period': 1,
        'date': '2023-10-24T00:00:00.000',
        'rating': 3,
        'customer_comment': 'customer_comment',
      };

      expect(appointment.toJson(), json);
    });
  });
}
