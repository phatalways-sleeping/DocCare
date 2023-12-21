// ignore_for_file: public_member_api_docs

abstract interface class AdministratorRepositoryService {
  Future<int> countAppointmentsInMonth(int month, int year);

  Future<int> countTotalAbsentRequest(int month, int year);

  Future<int> averageAppointmentsPerUser(int month, int year);

  Future<int> busiestDayPerMonth(int month, int year);

  Future<String> mostBookedSpecializationInMonth(int month, int year);

  Future<int> countFiveStarInMonth(int month, int year);

  Future<int> countFourStarInMonth(int month, int year);

  Future<int> countThreeStarInMonth(int month, int year);

  Future<int> countTwoStarInMonth(int month, int year);

  Future<int> countOneStarInMonth(int month, int year);

  Future<int> countCustomer();

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
    Map<String, List<int>> dayOfWeek,
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