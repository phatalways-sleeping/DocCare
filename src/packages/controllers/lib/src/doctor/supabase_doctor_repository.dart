// ignore_for_file: public_member_api_docs

import 'package:controllers/src/doctor/doctor_repository_service.dart';

class SupabaseDoctorRepository implements DoctorRepositoryService { 
  SupabaseDoctorRepository();

  late String _doctorId;

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
  Future<void> updateProfileData({String? fullname, String? email, String? phone, DateTime? birthday, String? specialization, int? startWorkingFrom}) {
    // TODO: implement updateProfileData
    throw UnimplementedError();
  }
}
