// ignore_for_file: public_member_api_docs

import 'package:controllers/src/doctor/doctor_repository_service.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDoctorRepository implements DoctorRepositoryService {
  SupabaseDoctorRepository();

  late String _doctorId;

  final AbsentRequestAPIService _absentRequestAPIService =
      SupabaseAbsentRequestApiService(
    supabase: Supabase.instance.client,
  );

  @override
  void initializeDoctorId(String id) {
    _doctorId = id;
  }

  @override
  void clear() {
    _doctorId = '';
  }

  @override
  Future<Map<String, dynamic>> getProfileData() {
    // TODO: implement getProfileData
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfileData(
      {String? fullname,
      String? email,
      String? phone,
      DateTime? birthday,
      String? specialization,
      int? startWorkingFrom}) {
    // TODO: implement updateProfileData
    throw UnimplementedError();
  }

  @override
  Future<void> sendAbsentRequest({
    required String reasons,
    required DateTime date,
    required String doctorName,
  }) async {
    await _absentRequestAPIService
        .createAbsentRequest(
          AbsentRequest(
            doctorID: _doctorId,
            date: date,
            doctorName: doctorName,
            dateRequest: DateTime.now(),
            isApproved: false,
          ),
        )
        .timeout(
          const Duration(
            seconds: 15,
          ),
        );
  }
}
