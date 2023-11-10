import 'package:models/models.dart';

abstract interface class WorkingShiftApiService<T extends WorkingShift> {
  Future<List<T>> getWorkingShiftListByDoctorID(String doctorID);

  Future<List<T>> getWorkingShiftListByDoctorID_dayOfWeek(
      String doctorID, String dateOfWeek);

  Future<T> getWorkingShiftByDoctorID_startPeriodID_dayOfWeek(
      String doctorID, int startPeriodID, String dateOfWeek);

  Future<List<T>> getAllWorkingShiftList();

  Future<void> createWorkingShift(WorkingShift workingShift);

  Future<void> updateWorkingShiftPeriodID(String doctorID, int startPeriodID,
      String dateOfWeek, int newStartPeriodID, int newEndPeriodID);

  Future<void> deleteWorkingShift(
      String doctorID, int startPeriodID, String dateOfWeek);

  Stream<T> streamWorkingShift(
      String doctorID, int startPeriodID, String dateOfWeek);
}
