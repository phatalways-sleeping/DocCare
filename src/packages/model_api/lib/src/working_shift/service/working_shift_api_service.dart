import 'package:models/models.dart';

abstract class WorkingShiftApiService {
  Future<List<WorkingShift>> getWorkingShiftListByDoctorID(String doctorID);

  Future<List<WorkingShift>> getWorkingShiftListByDoctorID_dayOfWeek(
      String doctorID, String dateOfWeek);

  Future<WorkingShift> getWorkingShiftByDoctorID_startPeriodID_dayOfWeek(
      String doctorID, int startPeriodID, String dateOfWeek);

  Future<List<WorkingShift>> getAllWorkingShiftList();

  Future<void> createWorkingShift(WorkingShift workingShift);

  Future<void> updateWorkingShiftPeriodID(String doctorID, int startPeriodID,
      String dateOfWeek, int newStartPeriodID, int newEndPeriodID);

  Future<void> deleteWorkingShift(
      String doctorID, int startPeriodID, String dateOfWeek);

  Stream<WorkingShift> streamWorkingShift(
      String doctorID, int startPeriodID, String dateOfWeek);
}
