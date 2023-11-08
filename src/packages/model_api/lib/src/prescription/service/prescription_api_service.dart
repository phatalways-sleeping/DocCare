import 'package:models/models.dart';

abstract class PrescriptionApiService {
  Future<Prescription> getPrescriptionByID(String id);

  Future<List<Prescription>> getAllPrescriptionList();

  Future<void> createPrescription(Prescription prescription);

  Future<void> updatePrescriptionDone(String id, bool done, DateTime dateDone);

  Future<void> deletePrescription(String id);

  Stream<Prescription> streamPrescription(String id);
}
