import 'package:models/models.dart';

abstract interface class PrescriptionApiService<T extends Prescription> {
  Future<T> getPrescriptionByID(String id);

  Future<List<T>> getAllPrescriptionList();

  Future<void> createPrescription(Prescription prescription);

  Future<void> updatePrescriptionDone(String id, bool done, DateTime dateDone);

  Future<void> deletePrescription(String id);

  Stream<T> streamPrescription(String id);
}
