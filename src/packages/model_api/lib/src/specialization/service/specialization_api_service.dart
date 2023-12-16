// ignore_for_file: public_member_api_docs

abstract interface class SpecializationApiService<Specialization> {
  const SpecializationApiService();

  Future<List<String>> getAllSpecialization();

  Future<void> createSpecialization(Specialization specialization);

  Future<int> getTotalDoctorsBySpecialization(String specialization);

  Future<void> updateDescription(String specialization, String description);
}
