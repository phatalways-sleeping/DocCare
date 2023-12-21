// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';

abstract interface class AbsentRequestAPIService<T extends AbsentRequest> {
  const AbsentRequestAPIService();

  Future<void> createAbsentRequest(T absentRequest);

  Future<void> deleteAbsentRequest(String doctorID, DateTime date);

  Future<T> getAbsentRequest(String doctorID, DateTime date);

  Future<List<T>> getAllAbsentRequestList();

  Future<List<T>> getAbsentRequestListByDoctorID(String doctorID);

  Future<List<T>> getAbsentRequestListByDate(DateTime date);

  Future<void> updateAbsentRequest(String doctorID, DateTime date, AbsentRequest absentRequest);
  
  Future<void> updateAbsentRequestDoctorName(String doctorID, DateTime date, String doctorName);

  Future<void> updateAbsentRequestDateRequest(String doctorID, DateTime date, DateTime dateRequest);

  Future<void> updateAbsentRequestReason(String doctorID, DateTime date, String? reason);

  Future<void> updateAbsentRequestIsApproved(String doctorID, DateTime date, bool isApproved);

  Stream<T> streamAbsentRequest(String doctorID, DateTime date);
}