import 'package:administrator/src/admin_control_staff_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// [SupabaseAdminControlStaffApiService] is the implementation of
/// [AdminControlStaffApiService] for Supabase
class SupabaseAdminControlStaffApiService
    implements AdminControlStaffApiService {
  SupabaseAdminControlStaffApiService._({
    required this.supabase,
  });

  /// [instance] is the static instance of [SupabaseAuthenticationRepository]
  static final SupabaseAdminControlStaffApiService instance =
      SupabaseAdminControlStaffApiService._(supabase: Supabase.instance.client);

  /// [supabase] is the instance of [SupabaseClient]
  final SupabaseClient supabase;
  var uuid = Uuid();
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  /// [errorHandler] is the concrete implementation
  /// of [AuthEmailApiErrorHandler]
  ///
  @override
  Future<void> signUpDoctor(
    String fullName,
    String email,
    String password,
    DateTime birthday,
    String phone,
    String specializationId,
    int startWorkingFrom,
    double rating,
    int numberOfRates,
    Map<String, List<int>> dayOfWeek,
  ) async {
    try {
      var doctorID = uuid.v1();
      await supabase.rpc('sp_add_doctor_record', params: {
        'birthday': birthday.toIso8601String(),
        'email': email,
        'fullname': fullName,
        'id': doctorID,
        'numberofrates': numberOfRates,
        'phone': phone,
        'rating': rating,
        'specializationid': specializationId,
        'startworkingfrom': startWorkingFrom,
      });
      for (final entry in dayOfWeek.entries) {
        print('DAY LEN DATABSE');
        print('startperiodid = ${entry.value[0]}');
        print('dayofweek = ${entry.key}');
        print('endperiodid = ${entry.value[1]}');
        await supabase.rpc(
          'sp_add_workingshift_record',
          params: {
            'doctorid': doctorID,
            'startperiodid': entry.value[0],
            'dayofweek': entry.key,
            'endperiodid': entry.value[1],
          },
        );
      }
      for (var entry in dayOfWeek.entries) {
        if (daysOfWeek.contains(entry.key) &&
            entry.value[0] > 0 &&
            entry.value[1] > 1) {
          // entry.key is the dayofweek
          // entry.value[0] is the endperiodid
          // entry.value[1] is the startperiodid
          await supabase.rpc('sp_add_working_shift', params: {
            'dayofweek': entry.key,
            'doctorid': doctorID,
            'endperiodid': entry.value[0],
            'startperiodid': entry.value[1],
          });
        }
      }
    } on AuthException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signUpReceptionist(
    String fullName,
    String email,
    String password,
    DateTime birthday,
    String phone,
  ) async {
    try {
      var receptionistID = uuid.v1();
      print('Create Receptionist before');
      await supabase.rpc('sp_add_receptionist_record', params: {
        'id': receptionistID,
        'email': email,
        'fullname': fullName,
        'phone': phone,
        'birthday': birthday.toIso8601String(),
      });

      print('Create Receptionist later');
    } on AuthException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteDoctor(
    String email,
  ) async {
    try {
      await supabase.rpc('sp_remove_doctor_using_email', params: {
        'email': email,
      });
    } on AuthException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteReceptionist(
    String email,
  ) async {
    try {
      await supabase.rpc('sp_remove_receptionist_using_email', params: {
        'email': email,
      });
    } on AuthException catch (e) {
      throw Exception(e);
    }
  }
}
