import 'package:models/models.dart';

abstract interface class AbsentRequestAPIService<T extends AbsentRequest> {
  const AbsentRequestAPIService();

  Future<void> createAbsentRequest(T absentRequest);

  Future<void> deleteAbsentRequest(String doctorID, DateTime date);

  Future<T> getAbsentRequest(String doctorID, DateTime date);

  Future<List<AbsentRequest>> getAllAbsentRequestList();

  Future<List<T>> getAbsentRequestListByDoctorID(String doctorID);

  Future<List<T>> getAbsentRequestListByDate(DateTime date);

  Future<void> updateAbsentRequest(String doctorID, DateTime date, String doctorName, DateTime dateRequest, String? reason, bool isApproved);

  Stream<T> streamAbsentRequest(String doctorID, DateTime date);
}