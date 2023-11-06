import 'package:models/models.dart';

/// Abstract class for user api service
abstract interface class UserApiService<T extends BaseUser> {
  /// Default constructor
  const UserApiService();

  /// Create a user
  Future<void> createUser(T user);

  /// Delete a user by [id]
  Future<void> deleteUser(String id);

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

/// Service for MedicalStaff: Doctor and Nurse, etc.
abstract interface class MedicalStaffApiService<T extends MedicalStaff>
    extends UserApiService<T> {
  /// Default constructor
  const MedicalStaffApiService();

  /// Update specializationId of a user by [id]
  Future<void> updateSpecialty(String id, String specializationId);

  /// Update startWorkingFrom of a user by [id]
  Future<void> updateStartWorkingFrom(String id, int startWorkingFrom);

  /// Update rating of a user by [id]
  Future<void> updateRating(String id, double rating);

  /// Update numberOfRates of a user by [id]
  Future<void> updateNumberOfRates(String id, int numberOfRates);
}
