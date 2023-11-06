import 'package:models/models.dart';

/// Abstract class for user api service
abstract class UserApiService<T extends BaseUser> {
  /// Default constructor
  const UserApiService();

  /// Get a user by [id]
  Future<T> getUser(String id);

  /// Get a list of users by [ids]
  Future<List<T>> getUsers(List<String> ids);

  /// Stream of user
  Stream<T> streamUser(String id);

  /// Update a user by [id]
  Future<void> updateUser(String id, T user);

  /// Update full name of a user by [id]
  Future<void> updateFullName(String id, String fullName);

  /// Update email of a user by [id]
  Future<void> updateEmail(String id, String email);

  /// Update phone of a user by [id]
  Future<void> updatePhone(String id, String phone);

  /// Update birthday of a user by [id]
  Future<void> updateBirthday(String id, DateTime birthday);
}
