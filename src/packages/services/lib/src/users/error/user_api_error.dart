/// Error thrown when a user API call fails.
abstract class UserApiError implements Exception {
  /// Default constructor
  const UserApiError({
    required this.message,
  });

  /// Error message
  final String message;
  

  @override
  String toString() => 'UserApiError: $message';
}
