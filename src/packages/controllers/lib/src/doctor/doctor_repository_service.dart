// ignore_for_file: public_member_api_docs

abstract interface class DoctorRepositoryService {
  void initializeDoctorId(String id);

  void initializeDate(DateTime date);

  void initializeCustomerId(String id);

  void initializeCustomerName(String name);

  String get getCustomerName;

  void initializePeriod(String period);

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

  Future<void> addPrescriptionToDatabase({
    required String prescriptionID,
    required List<String> doctorNote,
    required Map<String, List<String>> medicines,
    required String heartRate,
    required String bloodPressure,
    required String bloodSugar,
    required String choresterol,
  });

  Future<List<String>> getAvailableMedicine();
  
  Future<void> sendAbsentRequest({
    required String reasons,
    required DateTime date,
    required String doctorName,
  });
}
