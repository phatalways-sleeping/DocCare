import 'package:flutter_test/flutter_test.dart';
import 'package:model_api/src/working_shift/service/supabase_working_shift_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('WorkingShiftApi', () {
    //Creat a supabase instance
    final supabase = Supabase.instance.client;
    final workingShiftApi = WorkingShiftApi(supabase: supabase);

    test('Initialize Supabase', () {
      //Can be created with a supabase instance
      expect(WorkingShiftApi(supabase: supabase), isNotNull);
    });
    // Initialize the WorkingShiftApi with the Supabase client

    test('Initialize Working Shift', () {
      // The WorkingShiftApi should be created with a Supabase instance
      expect(workingShiftApi, isNotNull);
    });

    test('Get Working Shift List by Doctor ID', () async {
      final doctorID = 'D001';
      final workingShiftList =
          await workingShiftApi.getWorkingShiftListByDoctorID(doctorID);
      expect(workingShiftList, isNotEmpty);
    });

    test('Get Working Shift List by Doctor ID and Day of Week', () async {
      final doctorID = 'D001';
      final dateOfWeek = 'Monday';
      final workingShiftList = await workingShiftApi
          .getWorkingShiftListByDoctorID_dayOfWeek(doctorID, dateOfWeek);
      expect(workingShiftList, isNotEmpty);
    });

    test('Get all Working Shift List', () async {
      final workingShiftList = await workingShiftApi.getAllWorkingShiftList();
      expect(workingShiftList, isNotEmpty);
    });

    // // This test may change Database
    // test('Create a WorkingShift', () async {
    //   final workingShift = WorkingShift(
    //     doctorID: 'D001',
    //     startPeriodID: 1,
    //     dayOfWeek: 'Monday',
    //     endPeriodID: 2,
    //   );

    //   await workingShiftApi.createWorkingShift(workingShift);
    //   final createdWorkingShift = await workingShiftApi
    //       .getWorkingShiftByDoctorID_startPeriodID_dayOfWeek(
    //           'D001', 1, 'Monday');
    //   expect(createdWorkingShift, isNotEmpty);
    // });

    // // This test may change Database
    // test('Update WorkingShift Period ID', () async {
    //   final newStartPeriodID = 3;
    //   final newEndPeriodID = 4;

    //   await workingShiftApi.updateWorkingShiftPeriodID(
    //       'D001', 1, 'Monday', newStartPeriodID, newEndPeriodID);
    //   final updatedWorkingShift = await workingShiftApi
    //       .getWorkingShiftByDoctorID_startPeriodID_dayOfWeek(
    //           'D001', newStartPeriodID, 'Monday');
    //   expect(updatedWorkingShift, isNotEmpty);
    //   expect(updatedWorkingShift.startPeriodID, equals(newStartPeriodID));
    //   expect(updatedWorkingShift.endPeriodID, equals(newEndPeriodID));
    // });

    // // This test may change Database
    // test('Delete WorkingShift', () async {
    //   await workingShiftApi.deleteWorkingShift('D001', 1, 'Monday');
    //   final deletedWorkingShift = await workingShiftApi
    //       .getWorkingShiftByDoctorID_startPeriodID_dayOfWeek(
    //           'D001', 1, 'Monday');
    //   expect(deletedWorkingShift, isEmpty);
    // });
  });
}
