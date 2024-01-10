// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';
import 'package:services/src/absent_request/absent_request_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAbsentRequestApiService
    implements AbsentRequestAPIService<AbsentRequest> {
  const SupabaseAbsentRequestApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<AbsentRequest> getAbsentRequest(String doctorID, DateTime date) =>
      supabase
          .from('absentRequest')
          .select<PostgrestList>()
          .eq('doctorID', doctorID)
          .eq('date', date)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'No absentRequest with doctorID = $doctorID and date = $date found')
                : AbsentRequest.fromJson(value.first),
          )
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<AbsentRequest>> getAllAbsentRequestList() => supabase
      .from('absentRequest')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No absentRequest found')
            : value.map(AbsentRequest.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<AbsentRequest>> getAbsentRequestListByDoctorID(String doctorID) =>
      supabase
          .from('absentRequest')
          .select<PostgrestList>()
          .eq('doctorID', doctorID)
          .then(
            (value) => value.isEmpty
                ? throw Exception(
                    'No absentRequest with doctorID = $doctorID found')
                : value.map(AbsentRequest.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<AbsentRequest>> getAbsentRequestListByDate(DateTime date) =>
      supabase
          .from('absentRequest')
          .select<PostgrestList>()
          .eq('date', date)
          .then(
            (value) => value.isEmpty
                ? throw Exception('No absentRequest with date = $date found')
                : value.map(AbsentRequest.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createAbsentRequest(AbsentRequest absentRequest) => supabase
      .from('absentRequest')
      .insert(
        absentRequest.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateAbsentRequest(
          String doctorID, DateTime date, AbsentRequest absentRequest) =>
      supabase
          .from('absentRequest')
          .update({
            'doctorName': absentRequest.doctorName,
            'dateRequest': absentRequest.dateRequest,
            'reason': absentRequest.reason,
            'isApproved': absentRequest.isApproved,
          })
          .eq('doctorID', doctorID)
          .eq('date', date)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateAbsentRequestDoctorName(
          String doctorID, DateTime date, String doctorName) =>
      supabase
          .from('absentRequest')
          .update({
            'doctorName': doctorName,
          })
          .eq('doctorID', doctorID)
          .eq('date', date)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateAbsentRequestDateRequest(
          String doctorID, DateTime date, DateTime dateRequest) =>
      supabase
          .from('absentRequest')
          .update({
            'dateRequest': dateRequest,
          })
          .eq('doctorID', doctorID)
          .eq('date', date)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateAbsentRequestReason(
          String doctorID, DateTime date, String? reason) =>
      supabase
          .from('absentRequest')
          .update({
            'reason': reason,
          })
          .eq('doctorID', doctorID)
          .eq('date', date)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateAbsentRequestIsApproved(
          String doctorID, DateTime date, bool isApproved) =>
      supabase
          .from('absentRequest')
          .update({
            'isApproved': isApproved,
          })
          .eq('doctorID', doctorID)
          .eq('date', date)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> deleteAbsentRequest(String doctorID, DateTime date) => supabase
      .from('absentRequest')
      .delete()
      .eq('doctorID', doctorID)
      .eq('date', date)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single absentRequest
  @override
  Stream<AbsentRequest> streamAbsentRequest(String doctorID, DateTime date) =>
      supabase
          .from('absentRequest')
          .stream(primaryKey: ['doctorID', 'date'])
          .eq('doctorID', doctorID)
          .eq('date', date)
          .map((event) => AbsentRequest.fromJson(event.first));

  @override
  Future<List<AbsentRequest>> getPendingAbsentRequestList() => supabase
      .from('absentRequest')
      .select<PostgrestList>()
      .filter('answered', 'eq', false)
      .then(
        (value) => value.isEmpty
            ? <AbsentRequest>[]
            : value.map(AbsentRequest.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));
}
