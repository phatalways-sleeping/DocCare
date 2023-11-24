import 'package:auth_api/src/auth_email/error_handler/auth_email_api_error_handler.dart';
import 'package:auth_api/src/auth_email/error_handler/supabase_auth_email_api_error_handler.dart';
import 'admin_create_staff_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseAdminCreateStaffApiService implements AdminCreateStaffApiService {
  SupabaseAdminCreateStaffApiService({
    required this.supabase,
  });

  /// [supabase] is the instance of [SupabaseClient]
  final SupabaseClient supabase;

  var uuid = Uuid();

  /// [errorHandler] is the concrete implementation
  /// of [AuthEmailApiErrorHandler]
  final AuthEmailApiErrorHandler<AuthException> errorHandler =
      const SupabaseAuthEmailApiErrorHandler();

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
    List<String> dayOfWeek,
    List<int> startPeriodID,
    List<int> endPeriodID,
  ) async {
    try {
      var doctorID = uuid.v1();
      await supabase.rpc('sp_add_doctor_record', params: {
        'birthday': birthday,
        'email': email,
        'fullname': fullName,
        'id': doctorID,
        'numberofrates': numberOfRates,
        'phone': phone,
        'rating': rating,
        'specializationid': specializationId,
        'startworkingfrom': startWorkingFrom,
      });

      await supabase.rpc('sp_add_working_shift', params: {
        'dayofweek': dayOfWeek,
        'doctorid': doctorID,
        'endperiodid': endPeriodID,
        'startperiodid': startPeriodID,
      });
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
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
      await supabase.rpc('sp_add_receptionist_record', params: {
        'birthday': birthday,
        'email': email,
        'fullname': fullName,
        'id': receptionistID,
        'phone': phone,
      });
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
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
      errorHandler.handleAuthException(e);
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
      errorHandler.handleAuthException(e);
    }
  }
}
