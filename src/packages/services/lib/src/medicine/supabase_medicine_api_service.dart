// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';
import 'package:services/src/medicine/medicine_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMedicineApiService implements MedicineAPIService<Medicine> {
  const SupabaseMedicineApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<Medicine> getMedicine(String name) => supabase
      .from('medicine')
      .select<PostgrestList>()
      .eq('name', name)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No medicine found')
            : Medicine.fromJson(value.first),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Medicine>> getAllMedicineList() => supabase
      .from('medicine')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No medicine found')
            : value.map(Medicine.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Medicine>> getMedicineList(List<String> names) => supabase
      .from('medicine')
      .select<PostgrestList>()
      .in_('name', names)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No medicine found')
            : value.map(Medicine.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createMedicine(Medicine medicine) => supabase
      .from('medicine')
      .insert(
        medicine.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  //For either medicine in solid or liquid form
  @override
  Future<void> updateMedicineUnit(String name, String unit) => supabase
      .from('medicine')
      .update({
        'unit': unit,
      })
      .eq('name', name)
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> deleteMedicine(String name) => supabase
      .from('medicine')
      .delete()
      .eq('name', name)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single medicine
  @override
  Stream<Medicine> streamMedicine(String name) => supabase
      .from('medicine')
      .stream(primaryKey: ['name'])
      .eq('name', name)
      .map((event) => Medicine.fromJson(event.first));
}
