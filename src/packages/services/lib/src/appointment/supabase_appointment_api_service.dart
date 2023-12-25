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
      .eq('doctorId', doctorId)
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> deleteAppointmentByCustomerId(String customerId) => supabase
      .from('appointment')
      .delete()
      .eq('customerId', customerId)
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Appointment>> getAppointmentsByDoctorId(String doctorId) =>
      supabase
          .from('appointment')
          .select<PostgrestList>()
          .eq('doctorId', doctorId)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'Error from getAppointmentsByDoctorId: No appointments found with doctorId $doctorId',
                  )
                : value.map(Appointment.fromJson).toList(),
          )
          .onError(
            (error, stackTrace) => throw Exception(error),
          );

  @override
  Future<List<Appointment>> getAppointmentsByCustomerId(String customerId) =>
      supabase
          .from('appointment')
          .select<PostgrestList>()
          .eq('customerId', customerId)
          .then((value) => value.isEmpty
              ? throw Exception(
                  'Error from getAppointmentsByCustomerId: No appointments found with customerId $customerId')
              : value.map(Appointment.fromJson).toList())
          .onError(
            (error, stackTrace) => throw Exception(error),
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
  Future<void> updateRating(String customerId, int rating) => supabase
      .from('appointment')
      .update(
        {
          'rating': rating,
        },
      )
      .eq('id', customerId)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

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
