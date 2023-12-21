
abstract interface class AdminGenerateReportService {
  const AdminGenerateReportService();

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
}