/// Service for MedicalStaff: Doctor and Nurse, etc.
abstract interface class MedicalStaffApiService {
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
