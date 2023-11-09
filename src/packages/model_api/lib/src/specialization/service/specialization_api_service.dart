// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';

abstract class SpecializationApiService<T extends Specialization> {
  const SpecializationApiService();

  Future<void> createSpecialization(Specialization specialization);

  Future<int> getTotalDoctorsBySpecialization(String specialization);

  Future<void> updateDescription(String specialization, String description);
}
