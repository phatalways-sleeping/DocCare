// ignore_for_file: public_member_api_docs

import 'package:controllers/src/admin/administrator_repository_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

List<String> daysOfWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class SupabaseAdminRepository implements AdministratorRepositoryService {
  SupabaseAdminRepository();

  /// [supabase] is the instance of [SupabaseClient]
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<int> countAppointmentsInMonth(int month, int year) async {
    try {
      final response =
          await supabase.rpc('count_appointments_in_month', params: {
        'p_month': month,
        'p_year': year,
      });

      return response as int;
    } catch (e) {
      throw Exception('Error in counting appointments in month: $e');
    }
  }

  @override
  Future<int> countTotalAbsentRequest(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'count_total_absentrequest',
        params: {'p_month': month, 'p_year': year},
      );
      return response as int;
    } catch (e) {
      throw Exception('Error in counting total absent requests: $e');
    }
  }

  @override
  Future<int> averageAppointmentsPerUser(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'average_appointments_per_user',
        params: {'p_month': month, 'p_year': year},
      );

      // to do: split into two functions and change the return type to double
      return response as int;
    } catch (e) {
      throw Exception('Error in calculating average appointments per user: $e');
    }
  }

  @override
  Future<int> busiestDayPerMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'busiest_day_per_month',
        params: {'p_month': month, 'p_year': year},
      );
      if (response == null) return 0;
      return response as int;
    } catch (e) {
      throw Exception('Error in finding the busiest day per month: $e');
    }
  }

  @override
  Future<String> mostBookedSpecializationInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'most_booked_specialization_in_month',
        params: {'p_month': month, 'p_year': year},
      );
      if (response == null) return "No data";
      return response as String;
    } catch (e) {
      throw Exception('Error in finding most booked specialization: $e');
    }
  }

  @override
  Future<int> countFiveStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'count_five_star_in_month',
        params: {'p_month': month, 'p_year': year},
      );

      return response as int;
    } catch (e) {
      throw Exception('Error in counting five-star appointments: $e');
    }
  }

  @override
  Future<int> countFourStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'count_four_star_in_month',
        params: {'p_month': month, 'p_year': year},
      );

      return response as int;
    } catch (e) {
      throw Exception('Error in counting four-star appointments: $e');
    }
  }

  @override
  Future<int> countThreeStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'count_three_star_in_month',
        params: {'p_month': month, 'p_year': year},
      );

      return response as int;
    } catch (e) {
      throw Exception('Error in counting three-star appointments: $e');
    }
  }

  @override
  Future<int> countTwoStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'count_two_star_in_month',
        params: {'p_month': month, 'p_year': year},
      );

      return response as int;
    } catch (e) {
      throw Exception('Error in counting two-star appointments: $e');
    }
  }

  @override
  Future<int> countOneStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc(
        'count_one_star_in_month',
        params: {'p_month': month, 'p_year': year},
      );

      return response as int;
    } catch (e) {
      throw Exception('Error in counting one-star appointments: $e');
    }
  }

  @override
  Future<int> countCustomer() async {
    try {
      final response = await supabase.rpc('count_user');

      return response as int;
    } catch (e) {
      throw Exception('Error in counting total user: $e');
    }
  }

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
      final doctorID = const Uuid().v1();
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
      for (final entry in dayOfWeek.entries) {
        if (daysOfWeek.contains(entry.key) &&
            entry.value[0] > 0 &&
            entry.value[1] > 1) {
          // entry.key is the dayofweek
          // entry.value[0] is the endperiodid
          // entry.value[1] is the startperiodid
          await supabase.rpc(
            'sp_add_working_shift',
            params: {
              'dayofweek': entry.key,
              'doctorid': doctorID,
              'endperiodid': entry.value[0],
              'startperiodid': entry.value[1],
            },
          );
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
      final receptionistID = const Uuid().v1();
      await supabase.rpc(
        'sp_add_receptionist_record',
        params: {
          'id': receptionistID,
          'email': email,
          'fullname': fullName,
          'phone': phone,
          'birthday': birthday.toIso8601String(),
        },
      );
    } on AuthException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteDoctor(
    String email,
  ) async {
    try {
      await supabase.rpc(
        'sp_remove_doctor_using_email',
        params: {
          'email': email,
        },
      );
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
