abstract interface class AdminCreateStaffApiService {
  const AdminCreateStaffApiService();

  Future<void> signUpDoctor(
    String fullName,
    String email,
    String password,
    DateTime birthday,
    String phone,
    String specializationId,
    int startWorkingFrom,
    double rating,
    int numberOfRates,
    List<String> dayOfWeek,
    List<int> startPeriodID,
    List<int> endPeriodID,
  );

  Future<void> signUpReceptionist(
    String fullName,
    String email,
    String password,
    DateTime birthday,
    String phone,
  );

  Future<void> deleteDoctor(
    String email,
  );

  Future<void> deleteReceptionist(
    String email,
  );
}
