import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  group('Intake', () {
    test('copyWith', () {
      // Create a `Intake` instance
      final intake1 = Intake(
        medicine_name: 'penicillin',
        prescription_id: '123',
        duration: 1,
        time_of_the_day: 'morning',
        to_be_taken: 1,
        quantity: 1,
      );

      // Copy intake without changing any properties
      final intake2 = intake1.copyWith();

      // Verify the copy
      expect(intake1.medicine_name, intake2.medicine_name);
      expect(intake2.prescription_id, '123');
      expect(intake2.duration, 1);
      expect(intake2.time_of_the_day, 'morning');
      expect(intake2.to_be_taken, 1);
      expect(intake2.quantity, 1);

      //Copy intake with null
      final intake3 = intake1.copyWith(
        medicine_name: 'penicillin',
        prescription_id: '123',
      );

      expect(intake3.time_of_the_day, intake1.time_of_the_day);
      expect(intake3.to_be_taken, intake1.to_be_taken);
      expect(intake3.duration, intake1.duration);

      //JSON object
      final intakeJson = {
        "medicine_name": "penicillin",
        "prescription_id": "123",
        "duration": 1,
        "time_of_the_day": "morning",
        "to_be_taken": 1,
        "quantity": 1,
      };

      //To instance
      final intakeFromJson = Intake.fromJson(intakeJson);
      expect(intakeFromJson, intake1);

      //To JSON
      final jsonFromIntake = intake1.toJson();
      expect(jsonFromIntake, intakeJson);
    });
  });
}
