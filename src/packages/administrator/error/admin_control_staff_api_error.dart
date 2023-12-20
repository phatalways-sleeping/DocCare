/// Error thrown when a user API call fails.
abstract class AdministratorApiError implements Exception {
  /// Default constructor
  const AdministratorApiError({
    required this.message,
  });

  /// Error message
  final String message;

  @override
  String toString() => 'UserApiError: $message';
}
