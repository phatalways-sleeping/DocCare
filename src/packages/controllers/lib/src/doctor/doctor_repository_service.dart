// ignore_for_file: public_member_api_docs

abstract interface class DoctorRepositoryService {
  void initializeDoctorId(String id);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<bool> isDoctorExist(String email);

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  });
}
