import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Prescription', () {
    test('constructor', () {
      // Create a `Prescription` instance
      final prescription1 = Prescription(
        id: '123',
        doctorID: '456',
        customerID: '789',
        dateDone: DateTime.parse('2023-10-24'),
        datePrescribed: DateTime.parse('2023-10-20'),
        done: true,
        note: 'Take as directed',
      );

      expect(prescription1.id, '123');
      expect(prescription1.doctorID, '456');
      expect(prescription1.customerID, '789');
      expect(prescription1.dateDone, DateTime.parse('2023-10-24'));
      expect(prescription1.datePrescribed, DateTime.parse('2023-10-20'));
      expect(prescription1.done, true);
      expect(prescription1.note, 'Take as directed');
    });

    test('toJson', () {
      final prescription = Prescription(
        id: '123',
        doctorID: '456',
        customerID: '789',
        dateDone: DateTime.parse('2023-10-24'),
        datePrescribed: DateTime.parse('2023-10-20'),
        done: true,
        note: 'Take as directed',
      );

      final json =  {
        "id": "123",
        "doctorID": "456",
        "customerID": "789",
        "dateDone": DateTime.parse('2023-10-24').toIso8601String(),
        "datePrescribed": DateTime.parse('2023-10-20').toIso8601String(),
        "done": true,
        "note": "Take as directed",
      };

      final toJson = prescription.toJson();

      expect(toJson, json);
    });

    test('fromJson', () {
      final prescriptionJson = {
        "id": "123",
        "doctorID": "456",
        "customerID": "789",
        "dateDone": "2023-10-24",
        "datePrescribed": "2023-10-20",
        "done": true,
        "note": "Take as directed",
      };

      final prescription = Prescription.fromJson(prescriptionJson);

      final expectedPrescription = Prescription(
        id: '123',
        doctorID: '456',
        customerID: '789',
        dateDone: DateTime.parse('2023-10-24'),
        datePrescribed: DateTime.parse('2023-10-20'),
        done: true,
        note: 'Take as directed',
      );

      expect(prescription, expectedPrescription);
    });

    test('copyWith', () {
      final prescription1 = Prescription(
        id: '123',
        doctorID: '456',
        customerID: '789',
        dateDone: DateTime.parse('2023-10-24'),
        datePrescribed: DateTime.parse('2023-10-20'),
        done: true,
        note: 'Take as directed',
      );

      final prescription2 = prescription1.copyWith();

      expect(prescription1, prescription2);

      final prescription3 = prescription1.copyWith(
        id: '456',
        note: 'New note',
      );

      expect(prescription3.id, '456');
      expect(prescription3.note, 'New note');
    });
  });
}
