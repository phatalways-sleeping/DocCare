import 'package:model_api/src/users/user_api_service.dart';
import 'package:models/models.dart';


/// Implementation of [UserApiService] for [Receptionist]
class ReceptionistApiService implements UserApiService<Receptionist> {
  /// Default constructor
  const ReceptionistApiService();
  
  @override
  Future<Receptionist> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
  
  @override
  Future<List<Receptionist>> getUsers(List<String> ids) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
  
  @override
  Stream<Receptionist> streamUser(String id) {
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
  Future<void> updateUser(String id, user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
