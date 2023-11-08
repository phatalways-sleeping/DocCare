import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'working_shift_api_service.dart';

class WorkingShiftApi implements WorkingShiftApiService {
  const WorkingShiftApi({
    required this.supabase,
  });

  final SupabaseClient supabase;

  Future<List<WorkingShift>> getWorkingShiftListByDoctorID(String doctorID) =>
      supabase
          .from('workingShift')
          .select<PostgrestList>()
          .eq('doctorID', doctorID)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'No working shift with doctorID = $doctorID found')
                : value.map(WorkingShift.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  Future<List<WorkingShift>> getWorkingShiftListByDoctorID_dayOfWeek(
          String doctorID, String dateOfWeek) =>
      supabase
          .from('workingShift')
          .select<PostgrestList>()
          .eq('doctorID', doctorID)
          .eq('dateOfWeek', dateOfWeek)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'No working shift with doctorID = $doctorID and dateOfWeek = $dateOfWeek found')
                : value.map(WorkingShift.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  Future<WorkingShift> getWorkingShiftByDoctorID_startPeriodID_dayOfWeek(
          String doctorID, int startPeriodID, String dateOfWeek) =>
      supabase
          .from('workingShift')
          .select<PostgrestList>()
          .eq('doctorID', doctorID)
          .eq('dateOfWeek', dateOfWeek)
          .eq('startPeriodID', startPeriodID)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'No working shift with doctorID = $doctorID and and startPeriodID = $startPeriodID and dateOfWeek = $dateOfWeek found')
                : WorkingShift.fromJson(value.first),
          )
          .onError((error, stackTrace) => throw Exception(error));

  Future<List<WorkingShift>> getAllWorkingShiftList() => supabase
      .from('workingShift')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No working shift found')
            : value.map(WorkingShift.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> createWorkingShift(WorkingShift workingShift) => supabase
      .from('workingShift')
      .insert(
        workingShift.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> updateWorkingShiftPeriodID(String doctorID, int startPeriodID,
          String dateOfWeek, int newStartPeriodID, int newEndPeriodID) =>
      supabase
          .from('workingShift')
          .update({
            'startPeriodID': newStartPeriodID,
            'endPeriodID': newEndPeriodID,
          })
          .eq('doctorID', doctorID)
          .eq('dateOfWeek', dateOfWeek)
          .eq('startPeriodID', startPeriodID)
          .onError((error, stackTrace) => throw Exception(error));

  Future<void> deleteWorkingShift(
          String doctorID, int startPeriodID, String dateOfWeek) =>
      supabase
          .from('workingShift')
          .delete()
          .eq('doctorID', doctorID)
          .eq('startPeriodID', startPeriodID)
          .eq('dateOfWeek', dateOfWeek)
          .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single Working Shift
  Stream<WorkingShift> streamWorkingShift(
          String doctorID, int startPeriodID, String dateOfWeek) =>
      supabase
          .from('workingShift')
          .stream(primaryKey: ['doctorID', 'startPeriodID', 'dateOfWeek'])
          .eq('doctorID', doctorID)
          .eq('startPeriodID', startPeriodID)
          .eq('dateOfWeek', dateOfWeek)
          .map((event) => WorkingShift.fromJson(event.first));
}
