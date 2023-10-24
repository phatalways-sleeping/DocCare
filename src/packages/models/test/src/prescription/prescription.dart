import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Prescription', () {
    test('copyWith', () {
      // Create a `Prescription` instance
      final prescription1 = Prescription(
        id: '123',
        doctor_id: '456',
        customer_id: '789',
        date_done: '2023-10-24',
        date_prescribed: '2023-10-20',
        done: 'true',
        note: 'Take as directed',
      );

      // Copy prescription without changing any properties
      final prescription2 = prescription1.copyWith();

      // Verify the copy
      expect(prescription1.id, prescription2.id);
      expect(prescription2.customer_id, '789');
      expect(prescription2.done, 'true');
      expect(prescription2.note, 'Take as directed');

      // Copy prescription with null values
      final prescription3 = prescription1.copyWith(
        id: '123',
        doctor_id: '456',
        date_done: '2023-10-24',
        date_prescribed: '2023-10-20',
      );

      expect(prescription3.customer_id, prescription1.customer_id);
      expect(prescription3.done, prescription1.done);
      expect(prescription3.note, prescription1.note);

      // JSON object
      final prescriptionJson = {
        "id": "123",
        "doctor_id": "456",
        "customer_id": "789",
        "date_done": "2023-10-24",
        "date_prescribed": "2023-10-20",
        "done": "true",
        "note": "Take as directed",
      };

      // To instance
      final prescriptionFromJson = Prescription.fromJson(prescriptionJson);
      expect(prescriptionFromJson, prescription1);

      // To JSON
      final jsonFromPrescription = prescription1.toJson();
      expect(jsonFromPrescription, prescriptionJson);
    });
  });
}
