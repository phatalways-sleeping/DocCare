// ignore_for_file: public_member_api_docs

abstract interface class CustomerRepositoryService {
  Future<String> createCustomer(
    String fullName,
    String email,
    String phone,
    DateTime birthday,
  );
  String? getCustomerId();

  void initializeCustomerId(String id);

  Future<bool> isCustomerExist(String email, String phone);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  });

  Future<void> ratePrescription(
    int period,
    String doctorId,
    String date,
    int rating,
  );

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

  Future<void> updateAppointmentDone(bool done, String prescriptionID);
  Future<void> updateMedicineDone(
    bool done,
    String prescriptionID,
    String medicineName,
  );

  Future<List<Map<String, dynamic>>> getAvailableDoctors({
    List<String>? specialities,
    int? rating,
    String? searchName,
    DateTime? date,
  });

  Future<List<Map<String, dynamic>>> getAvailablePeriodWithSpecialization({
    required String specialization,
    required DateTime date,
    required String customerid,
  });

  Future<List<String>> getDoctorSpecialization();
  Future<List<Map<String, dynamic>>> getAvailablePeriod(
    String doctorId,
    DateTime date,
    String customerid,
  );
  Future<List<Map<String, dynamic>>> getDoctorAvailablePeriod(
    String doctorId,
    DateTime date,
  );
  Future<void> bookAppointmentWithDoctor({
    required int period,
    required String customerid,
    required String doctorid,
    required DateTime date,
    required String customername,
    String? customerComment,
  });

  Future<void> bookAppointmentWithoutDoctor({
    required int period,
    required String customerid,
    required DateTime date,
    required String specialization,
    required String customername,
    String? customerComment,
  });

  Future<List<Map<String, dynamic>>> getDoctorWorkingShift({
    required String doctorid,
  });

  Future<bool> checkExistingAppointment({
    required int period,
    required String doctorid,
    required DateTime date,
  });

  Future<String> getHighestRatingDoctor({
    required String speciality,
    required DateTime date,
    required int period,
  });

  Future<Map<String, dynamic>> getStatistics(
    String prescriptionId,
  );

  Future<List<Map<String, dynamic>>> getUpcomingAppointments();

  Future<List<Map<String, dynamic>>> getAppointmentStatusDoctorName();

  Future<void> addOfflineCustomer({
    required String id,
  });
}
