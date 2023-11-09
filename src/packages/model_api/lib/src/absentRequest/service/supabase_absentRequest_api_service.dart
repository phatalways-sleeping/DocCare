import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:model_api/src/absentRequest/service/absentRequest_api_service.dart';

class SupabaseAbsentRequestApiService implements AbsentRequestAPIService<AbsentRequest> {
  const SupabaseAbsentRequestApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

 @override
  Future<AbsentRequest> getAbsentRequest(String doctorID, DateTime date) => supabase
      .from('absentRequest')
      .select<PostgrestList>()
      .eq('doctorID', doctorID)
      .eq('date', date)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No absentRequest with doctorID = $doctorID and date = $date found')
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
  Future<List<AbsentRequest>> getAbsentRequestListByDoctorID(String doctorID) => supabase
      .from('absentRequest')
      .select<PostgrestList>()
      .eq('doctorID', doctorID)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No absentRequest with doctorID = $doctorID found')
            : value.map(AbsentRequest.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<AbsentRequest>> getAbsentRequestListByDate(DateTime date) => supabase
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
  Future<void> updateAbsentRequest(String doctorID, DateTime date, String doctorName, DateTime dateRequest, String? reason, bool isApproved) => supabase
      .from('absentRequest')
      .update({
        'doctorName': doctorName,
        'dateRequest': dateRequest,
        'reason': reason,
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
  Stream<AbsentRequest> streamAbsentRequest(String doctorID, DateTime date) => supabase
      .from('absentRequest')
      .stream(primaryKey: ['doctorID', 'date'])
      .eq('doctorID', doctorID)
      .eq('date', date)
      .map((event) => AbsentRequest.fromJson(event.first));
}