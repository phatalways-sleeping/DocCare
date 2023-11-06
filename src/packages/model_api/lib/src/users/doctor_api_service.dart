import 'package:model_api/src/users/user_api_service.dart';
import 'package:models/models.dart';

/// Implementation of [UserApiService] for [Doctor]
class DoctorApiService implements MedicalStaffApiService<Doctor> {
  /// Default constructor
  const DoctorApiService();
  
  @override
  Future<Doctor> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
  @override
  Future<List<Doctor>> getUsers(List<String> ids) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
  
  @override
  Stream<Doctor> streamUser(String id) {
    // TODO: implement streamUser
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateBirthday(String id, DateTime birthday) {
    // TODO: implement updateBirthday
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateEmail(String id, String email) {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateFullName(String id, String fullName) {
    // TODO: implement updateFullName
    throw UnimplementedError();
  }
  
  @override
  Future<void> updatePhone(String id, String phone) {
    // TODO: implement updatePhone
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateUser(String id, Doctor user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateNumberOfRates(String id, int numberOfRates) {
    // TODO: implement updateNumberOfRates
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateRating(String id, double rating) {
    // TODO: implement updateRating
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateSpecialty(String id, String specializationId) {
    // TODO: implement updateSpecialty
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateStartWorkingFrom(String id, int startWorkingFrom) {
    // TODO: implement updateStartWorkingFrom
    throw UnimplementedError();
  }
}
