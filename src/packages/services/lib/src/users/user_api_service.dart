import 'package:models/models.dart';

/// Abstract class for user api service
abstract interface class UserApiService {
  /// Default constructor
  const UserApiService();

  ///Get all users' emails
  Future<List<String>> getAllUserEmail();

  /// Create a user
  Future<void> createUser(BaseUser user);

  /// Delete a user by [id]
  Future<void> deleteUser(String id);

  /// Get a user by [id]
  Future<BaseUser> getUser(String id);

  /// Get a list of users by [ids]
  Future<List<BaseUser>> getUsers(List<String> ids);

  /// Stream of user
  Stream<BaseUser> streamUser(String id);

  /// Update a user by [id]
  Future<void> updateUser(String id, BaseUser user);

  /// Update full name of a user by [id]
  Future<void> updateFullName(String id, String fullName);

  /// Update email of a user by [id]
  Future<void> updateEmail(String id, String email);

  /// Update phone of a user by [id]
  Future<void> updatePhone(String id, String phone);

  /// Update birthday of a user by [id]
  Future<void> updateBirthday(String id, DateTime birthday);
}
