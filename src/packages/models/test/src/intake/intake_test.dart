import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Intake', () {
    test('copyWith', () {
      // Create a `Intake` instance
      final intake1 = Intake(
        medicineName: 'penicillin',
        prescriptionID: '123',
        duration: 1,
        timeOfTheDay: 'morning',
        toBeTaken: 1,
        quantity: 1,
      );

      // Copy intake without changing any properties
      final intake2 = intake1.copyWith();

      // Verify the copy
      expect(intake1.medicineName, intake2.medicineName);
      expect(intake2.prescriptionID, '123');
      expect(intake2.duration, 1);
      expect(intake2.timeOfTheDay, 'morning');
      expect(intake2.toBeTaken, 1);
      expect(intake2.quantity, 1);

      //Copy intake with null
      final intake3 = intake1.copyWith(
        medicineName: 'penicillin',
        prescriptionID: '123',
      );

      expect(intake3.timeOfTheDay, intake1.timeOfTheDay);
      expect(intake3.toBeTaken, intake1.toBeTaken);
      expect(intake3.duration, intake1.duration);
    });

    test('fromJson', () {
      //JSON object
      final intakeJson = {
        "medicineName": "penicillin",
        "prescriptionID": "123",
        "duration": 1,
        "timeOfTheDay": "morning",
        "toBeTaken": 1,
        "quantity": 1,
      };

      final intake = Intake(
        medicineName: 'penicillin',
        prescriptionID: '123',
        duration: 1,
        timeOfTheDay: 'morning',
        toBeTaken: 1,
        quantity: 1,
      );

      //To instance
      final intakeFromJson = Intake.fromJson(intakeJson);
      expect(intakeFromJson, intake);
    });

    test('toJson', () {
      final intakeJson = {
        "medicineName": "penicillin",
        "prescriptionID": "123",
        "duration": 1,
        "timeOfTheDay": "morning",
        "toBeTaken": 1,
        "quantity": 1,
      };

      final intake = Intake(
        medicineName: 'penicillin',
        prescriptionID: '123',
        duration: 1,
        timeOfTheDay: 'morning',
        toBeTaken: 1,
        quantity: 1,
      );

      //To Json
      final jsonFromIntake = intake.toJson();
      expect(jsonFromIntake, intakeJson);
    });
  });
}
