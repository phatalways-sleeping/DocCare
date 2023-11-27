/// Package for Admin control staffs service
abstract interface class AdminControlStaffApiService {
  const AdminControlStaffApiService();

  /// [signUpDoctor] is the method for sign up Doctor
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

  /// [signUpReceptionist] is the method for sign up Receptionist
  Future<void> signUpReceptionist(
    String fullName,
    String email,
    String password,
    DateTime birthday,
    String phone,
  );

  /// [deleteDoctor] is the method for delete Doctor
  Future<void> deleteDoctor(
    String email,
  );

  /// [deleteReceptionist] is the method for delete Receptionist
  Future<void> deleteReceptionist(
    String email,
  );
}
