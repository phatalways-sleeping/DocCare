import 'package:administrator/administrator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseAdminControlStaffApiService
    implements AdminControlStaffApiService {
  SupabaseAdminControlStaffApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;
  var uuid = Uuid();

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
      var doctorId = uuid.v1();
      await supabase.rpc('sp_add_doctor_record', params: {
        'birthday': birthday,
        'email': email,
        'fullname': fullName,
        'id': doctorId,
        'numberofrates': numberOfRates,
        'phone': phone,
        'rating': rating,
        'specializationid': specializationId,
        'startworkingfrom': startWorkingFrom,
      });
      await supabase.rpc('sp_add_working_shift', params: {
        'dayofweek': dayOfWeek,
        'doctorid': doctorId,
      });
    } on AuthException catch (e) {
      // Handle the exception appropriately, e.g., log or throw a custom exception.
      print('Error signing up doctor: $e');
      rethrow; // Rethrow the exception after handling/logging.
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
      var receptionistId = uuid.v1();
      await supabase.rpc('sp_add_receptionist_record', params: {
        'birthday': birthday,
        'email': email,
        'fullname': fullName,
        'id': receptionistId,
        'phone': phone,
      });
    } on AuthException catch (e) {
      print('Error signing up receptionist: $e');
      rethrow;
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
      print('Error deleting doctor: $e');
      rethrow;
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
      print('Error deleting receptionist: $e');
      rethrow;
    }
  }
}
