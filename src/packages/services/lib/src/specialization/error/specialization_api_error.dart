/// Error thrown when a user API call fails.
abstract class SpecializationApiError implements Exception {
  /// Default constructor
  const SpecializationApiError({
    required this.message,
  });

  /// Error message
  final String message;

  @override
  String toString() => 'SpecializationApiError: $message';
}
