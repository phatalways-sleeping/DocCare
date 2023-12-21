import 'package:administrator/src/admin_generate_report_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAdminGenerateReportService implements AdminGenerateReportService {
  SupabaseAdminGenerateReportService._({
    required this.supabase,
  });
  static final SupabaseAdminGenerateReportService instance =
      SupabaseAdminGenerateReportService._(supabase: Supabase.instance.client);
  final SupabaseClient supabase;

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
      final response = await supabase.rpc('count_total_absentrequest',
          params: {'p_month': month, 'p_year': year});
      print(response.toString());
      return response as int;
    } catch (e) {
      throw Exception('Error in counting total absent requests: $e');
    }
  }

  @override
  Future<int> averageAppointmentsPerUser(int month, int year) async {
    try {
      final response = await supabase.rpc('average_appointments_per_user',
          params: {'p_month': month, 'p_year': year});

      // to do: split into two functions and change the return type to double
      return response as int;
    } catch (e) {
      throw Exception('Error in calculating average appointments per user: $e');
    }
  }

  @override
  Future<int> busiestDayPerMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('busiest_day_per_month',
          params: {'p_month': month, 'p_year': year});
      if (response == null) return 0;
      return response as int;
    } catch (e) {
      throw Exception('Error in finding the busiest day per month: $e');
    }
  }

  @override
  Future<String> mostBookedSpecializationInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('most_booked_specialization_in_month',
          params: {'p_month': month, 'p_year': year});
      if (response == null) return "No data";
      return response as String;
    } catch (e) {
      throw Exception('Error in finding most booked specialization: $e');
    }
  }

  @override
  Future<int> countFiveStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('count_five_star_in_month',
          params: {'p_month': month, 'p_year': year});

      return response as int;
    } catch (e) {
      throw Exception('Error in counting five-star appointments: $e');
    }
  }

  Future<int> countFourStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('count_four_star_in_month',
          params: {'p_month': month, 'p_year': year});

      return response as int;
    } catch (e) {
      throw Exception('Error in counting four-star appointments: $e');
    }
  }

  Future<int> countThreeStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('count_three_star_in_month',
          params: {'p_month': month, 'p_year': year});

      return response as int;
    } catch (e) {
      throw Exception('Error in counting three-star appointments: $e');
    }
  }

  Future<int> countTwoStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('count_two_star_in_month',
          params: {'p_month': month, 'p_year': year});

      return response as int;
    } catch (e) {
      throw Exception('Error in counting two-star appointments: $e');
    }
  }

  Future<int> countOneStarInMonth(int month, int year) async {
    try {
      final response = await supabase.rpc('count_one_star_in_month',
          params: {'p_month': month, 'p_year': year});

      return response as int;
    } catch (e) {
      throw Exception('Error in counting one-star appointments: $e');
    }
  }

  Future<int> countCustomer() async {
    try {
      final response = await supabase.rpc('count_user');

      return response as int;
    } catch (e) {
      throw Exception('Error in counting total user: $e');
    }
  }
}