import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'prescription_api_service.dart';

class PrescriptionApi implements PrescriptionApiService {
  const PrescriptionApi({
    required this.supabase,
  });

  final SupabaseClient supabase;

  Future<Prescription> getPrescriptionByID(String id) => supabase
      .from('prescription')
      .select<PostgrestList>()
      .eq('id', id)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No prescription with id = $id found')
            : Prescription.fromJson(value.first),
      )
      .onError((error, stackTrace) => throw Exception(error));

  Future<List<Prescription>> getAllPrescriptionList() => supabase
      .from('prescription')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No working shift found')
            : value.map(Prescription.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> createPrescription(Prescription prescription) => supabase
      .from('prescription')
      .insert(
        prescription.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> updatePrescriptionDone(
          String id, bool done, DateTime dateDone) =>
      supabase
          .from('prescription')
          .update({
            'done': done,
            'dateDone': dateDone,
          })
          .eq('id', id)
          .onError((error, stackTrace) => throw Exception(error));

  Future<void> deletePrescription(String id) => supabase
      .from('prescription')
      .delete()
      .eq('id', id)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single Working Shift
  Stream<Prescription> streamPrescription(String id) => supabase
      .from('prescription')
      .stream(primaryKey: ['id'])
      .eq('id', id)
      .map((event) => Prescription.fromJson(event.first));
}
