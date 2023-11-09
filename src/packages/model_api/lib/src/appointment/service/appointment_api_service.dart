// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAppointmentApiService {
  const SupabaseAppointmentApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  Future<void> createAppointment(Appointment appointment) => supabase
      .from('appointment')
      .insert(
        appointment.toJson(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  Future<void> deleteAppointment(String id) =>
      supabase.from('appointment').delete().eq('id', id).onError(
            (error, stackTrace) => throw Exception(error),
          );

  Future<Appointment> getAppointment(String id) => supabase
      .from('appointment')
      .select<PostgrestList>()
      .eq('id', id)
      .limit(1)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getAppointment: No appointment found with id $id')
            : Appointment.fromJson(value.first),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  Future<List<Appointment>> getAppointments(List<String> ids) => supabase
      .from('appointment')
      .select<PostgrestList>()
      .in_('id', ids)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getAppointments: No appointments found with ids $ids',
              )
            : value.map(Appointment.fromJson).toList(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  Stream<Appointment> streamAppointment(String id) =>
      supabase.from('appointment').stream(primaryKey: ['id']).eq('id', id).map(
            (event) => Appointment.fromJson(
              event.first,
            ),
          );

  Future<void> updateAppointment(String id, Appointment appointment) => supabase
      .from('appointment')
      .update(
        appointment.toJson(),
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  Future<void> updateRating(String id, Appointment appointment) => supabase
      .from('appointment')
      .update(
        {
          'rating': appointment.rating,
        },
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  Future<void> updateCustomerComment(String id, Appointment appointment) =>
      supabase
          .from('appointment')
          .update(
            {
              'customer_comment': appointment.customerComment,
            },
          )
          .eq('id', id)
          .onError(
            (error, stackTrace) => throw Exception(error),
          );
}
