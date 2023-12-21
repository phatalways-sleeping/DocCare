// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';
import 'package:services/src/prescription/prescription_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePrescriptionApiService
    implements PrescriptionApiService<Prescription> {
  const SupabasePrescriptionApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;
  @override
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

  @override
  Future<List<Prescription>> getAllPrescriptionList() => supabase
      .from('prescription')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No working shift found')
            : value.map(Prescription.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Prescription>> getAllPrescriptionListByCustomerID(
    String customerID,
  ) =>
      supabase
          .from('prescription')
          .select<PostgrestList>()
          .eq('customerID', customerID)
          .then(
            (value) => value.isEmpty
                ? throw Exception('No customer with id = $customerID found')
                : value.map(Prescription.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createPrescription(Prescription prescription) => supabase
      .from('prescription')
      .insert(
        prescription.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));
  @override
  Future<void> updatePrescriptionDone(
    String id,
    bool done,
    DateTime dateDone,
  ) =>
      supabase
          .from('prescription')
          .update({
            'done': done,
            'dateDone': dateDone.toString(),
          })
          .eq('id', id)
          .onError((error, stackTrace) => throw Exception(error));
  @override
  Future<void> deletePrescription(String id) => supabase
      .from('prescription')
      .delete()
      .eq('id', id)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single Working Shift
  @override
  Stream<Prescription> streamPrescription(String id) => supabase
      .from('prescription')
      .stream(primaryKey: ['id'])
      .eq('id', id)
      .map((event) => Prescription.fromJson(event.first));
}
