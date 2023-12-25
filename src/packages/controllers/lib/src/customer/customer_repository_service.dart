// ignore_for_file: public_member_api_docs

abstract interface class CustomerRepositoryService {
  Future<String> createCustomer(
    String fullName,
    String email,
    String phone,
    DateTime birthday,
  );
  String getCustomerId();

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
  });

  Future<List<String>> getDoctorSpecialization();
  Future<List<Map<String, dynamic>>> getAvailablePeriod(
      String doctorId, DateTime date);
  Future<void> bookAppointmentWithDoctor({
    required int period,
    required String customerid,
    required String doctorid,
    required DateTime date,
    String? customerComment,
  });
}
