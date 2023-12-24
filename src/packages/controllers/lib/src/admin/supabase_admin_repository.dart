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
    Map<String, List<int>> dayOfWeek,
  ) async {
    final id = const Uuid().v7();
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'enable': true,
        'role': 'doctor',
        'id': id,
      },
    );
    final authUserId = response.user?.id;
    await supabase.rpc(
      'sp_create_doctor',
      params: {
        'p_id': id,
        'p_email': email,
        'p_fullname': fullName,
        'p_phone': phone,
        'p_birthday': birthday.toIso8601String(),
        'p_specialization_id': specializationId,
        'p_working_shift': {
          for (final entry in dayOfWeek.entries)
            entry.key: {
              'startPeriod': entry.value[0],
              'endPeriod': entry.value[1],
            },
        },
      },
    ).onError(
      (error, stackTrace) => throw AuthException(
        authUserId ?? 'User is null',
        statusCode: 'create-error',
      ),
    );
  }

  @override
  Future<void> signUpReceptionist(
    String fullName,
    String email,
    String password,
    DateTime birthday,
    String phone,
  ) async {
    final id = const Uuid().v7();
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'enable': true,
        'role': 'receptionist',
        'id': id,
      },
    );
    final authUserId = response.user?.id;
    await supabase.rpc(
      'sp_create_receptionist',
      params: {
        'p_id': id,
        'p_email': email,
        'p_fullname': fullName,
        'p_phone': phone,
        'p_birthday': birthday.toIso8601String(),
      },
    ).onError(
      (error, stackTrace) => throw AuthException(
        authUserId ?? 'User is null',
        statusCode: 'create-error',
      ),
    );
  }
}
