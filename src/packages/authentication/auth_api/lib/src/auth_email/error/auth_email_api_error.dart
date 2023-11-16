/// Error thrown when a Authentication Email API call fails.
abstract class AuthEmailApiError implements Exception {
  /// Default constructor
  const AuthEmailApiError({
    required this.message,
  });

  /// Error message
  final String message;

  @override
  String toString() => 'AuthEmailApiError: $message';
}
