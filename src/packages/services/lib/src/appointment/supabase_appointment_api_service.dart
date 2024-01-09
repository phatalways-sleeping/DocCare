// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';
import 'package:services/src/appointment/appointment_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAppointmentApiService
    implements AppointmentApiService<Appointment> {
  const SupabaseAppointmentApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<void> createAppointment(Appointment appointment) => supabase
      .from('appointment')
      .insert(
        appointment.toJson(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> deleteAppointmentByDoctorId(String doctorId) => supabase
      .from('appointment')
      .delete()
      .eq('doctorID', doctorId)
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> deleteAppointmentByCustomerId(String customerId) => supabase
      .from('appointment')
      .delete()
      .eq('customerID', customerId)
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Appointment>> getAppointmentsByDoctorId(String doctorId) =>
      supabase
          .from('appointment')
          .select<PostgrestList>()
          .eq('doctorID', doctorId)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'Error from getAppointmentsByDoctorId: No appointments found with doctorId $doctorId',
                  )
                : value.map(Appointment.fromJson).toList(),
          )
          .onError(
            (error, stackTrace)  {return [];},
          );

  @override
  Future<List<Appointment>> getAppointmentsByCustomerId(String customerId) =>
      supabase
          .from('appointment')
          .select<PostgrestList>()
          .eq('customerID', customerId)
          .then((value) => value.isEmpty
              ? throw Exception(
                  'Error from getAppointmentsByCustomerId: No appointments found with customerId $customerId')
              : value.map(Appointment.fromJson).toList())
          .onError(
        (error, stackTrace) {
          throw Exception(error);
        },
      );

  @override
  Future<List<Appointment>> getAppointmentsByDate(DateTime date) => supabase
      .from('appointment')
      .select<PostgrestList>()
      .eq('date', date)
      .then((value) => value.isEmpty
          ? throw Exception(
              'Error from getAppointmentsByDate: No appointments found with date $date')
          : value.map(Appointment.fromJson).toList())
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateAppointment(Appointment appointment) => supabase
      .from('appointment')
      .update(appointment.toJson())
      .eq('customerID', appointment.customerID)
      .eq('doctorID', appointment.doctorID)
      .eq('period', appointment.period)
      .eq('date', appointment.date)
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateRating(
    int period,
    String customerId,
    String doctorId,
    String date,
    int rating,
  ) =>
      supabase.rpc(
        'sp_update_appointment_rating',
        params: {
          'n_period': period,
          'n_customer_id': customerId,
          'n_doctor_id': doctorId,
          'n_date': date,
          'n_rating': rating,
        },
      ).onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateCustomerComment(
          String customerId, String customerComment) =>
      supabase
          .from('appointment')
          .update(
            {
              'customerComment': customerComment,
            },
          )
          .eq('id', customerId)
          .onError(
            (error, stackTrace) => throw Exception(error),
          );
}
