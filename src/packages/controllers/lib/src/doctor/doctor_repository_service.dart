// ignore_for_file: public_member_api_docs

abstract interface class DoctorRepositoryService {
  void initializeDoctorId(String id);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  });

  Future<void> sendAbsentRequest({
    required String reasons,
    required DateTime date,
    required String doctorName,
  });
}
