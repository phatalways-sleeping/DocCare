// ignore_for_file: public_member_api_docs

abstract interface class CustomerRepositoryService {
  Future<String> createCustomer(
    String fullName,
    String email,
    String phone,
    DateTime birthday,
  );

  void initializeCustomerId(String id);

  Future<bool> isCustomerExist(String email);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  });

  Future<void> ratePrescription(String prescriptionId, int rating);

  Future<void> togglePrescription(
    String prescriptionId, {
    required bool isDone,
  });

  Future<void> toggleMedicine(
    String medicine,
    String prescriptionId, {
    required bool isDone,
  });

  Future<List<String>> getNewestPrescriptionID();

  Future<List<Map<String, dynamic>>> getCurrentPrescriptions();

  Future<List<Map<String, dynamic>>> getPastPrescriptions();

  Future<List<Map<String, dynamic>>> getCurrentPrescriptionMedicines(
    String prescriptionId,
  );

  Future<List<Map<String, dynamic>>> getPastPrescriptionMedicines(
    String prescriptionId,
  );

  Future<Map<String, dynamic>> getPrescriptionData(
    String prescriptionId,
  );

  Future<List<Map<String, dynamic>>> getAvailableDoctors({
    List<String>? specialities,
    int? rating,
    String? searchName,
    DateTime? date,
    required int period,
  });

  Future<Map<String, dynamic>> getStatistics(
    String prescriptionId,
  );

  Future<List<Map<String, dynamic>>> getUpcomingAppointments();

  Future<List<Map<String, dynamic>>> getAppointmentStatusDoctorName();
}
