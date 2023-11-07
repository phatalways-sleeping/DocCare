import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicineApi {
  const MedicineApi({
    required this.supabase,
  });

  final SupabaseClient supabase;

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

  Future<List<Medicine>> getAllMedicineList() => supabase
      .from('medicine')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No medicine found')
            : value.map(Medicine.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

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

  Future<void> createMedicine(Medicine medicine) => supabase
      .from('medicine')
      .insert(
        medicine.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  //For either medicine in solid or liquid form
  Future<void> updateMedicineUnit(String name, String unit) => supabase
      .from('medicine')
      .update({
        'unit': unit,
      })
      .eq('name', name)
      .onError((error, stackTrace) => throw Exception(error));

  Future<void> deleteMedicine(String name) => supabase
      .from('medicine')
      .delete()
      .eq('name', name)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single medicine
  Stream<Medicine> streamMedicine(String name) => supabase
      .from('medicine')
      .stream(primaryKey: ['name'])
      .eq('name', name)
      .map((event) => Medicine.fromJson(event.first));
}
