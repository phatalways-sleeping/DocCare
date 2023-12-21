// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';

abstract interface class MedicineAPIService<T extends Medicine> {
  const MedicineAPIService();

  Future<void> createMedicine(T medicine);

  Future<void> deleteMedicine(String name);

  Future<T> getMedicine(String name);

  Future<List<T>> getAllMedicineList();

  Future<List<T>> getMedicineList(List<String> names);

  Future<void> updateMedicineUnit(String name, String unit);

  Stream<T> streamMedicine(String name);
}
