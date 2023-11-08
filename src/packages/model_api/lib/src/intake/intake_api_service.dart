import 'dart:ffi';

import 'package:models/models.dart';
import 'package:tuple/tuple.dart';

abstract interface class IntakeApiService<T extends Intake> {
  const IntakeApiService();

  Future<void> createIntake(T intake);

  Future<void> deleteIntake(T intake);

  Future<T> getIntake(String prescriptionID, String medicineName);

  Future<List<T>> getAllIntakeList();

  Future<List<Intake>> getIntakeList(List<Tuple2<String, String>> intakeInfo);

  Future<T> updateIntakeDuration(
      String prescriptionID, String medicineName, Int duration);

  Future<void> updateIntakeTimeOfTheDay(
      String prescriptionID, String medicineName, String timeOfTheDay);

  Future<void> updateIntakeToBeTaken(
      String prescriptionID, String medicineName, Int toBeTaken);

  Future<void> updateIntakeQuantity(
      String prescriptionID, String medicineName, Int quantity);

  Stream<T> streamIntake(String prescriptionID, String medicineName);
}
