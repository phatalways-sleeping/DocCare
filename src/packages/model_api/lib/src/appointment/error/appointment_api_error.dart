/// Error thrown when a user API call fails.
abstract class AppointmentApiError implements Exception {
  /// Default constructor
  const AppointmentApiError({
    required this.message,
  });

  /// Error message
  final String message;

  @override
  String toString() => 'AppointmentApiError: $message';
}
