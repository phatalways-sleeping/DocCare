// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';

abstract interface class ReceptionistRepositoryService {
  void initializeReceptionistId(String id);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  });

  Future<List<Map<String, dynamic>>> getAbsentRequests();

  Future<void> responseAbsentRequest(
    String id, {
    required DateTime date,
    required bool isAccepted,
  });
}
