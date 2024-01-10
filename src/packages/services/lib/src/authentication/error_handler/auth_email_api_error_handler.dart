/// [AuthEmailApiErrorHandler] is an interface for handling exceptions
/// ignore: one_member_abstracts
abstract interface class AuthEmailApiErrorHandler<T extends Exception> {
  /// [handleAuthException] handles the exception
  void handleAuthException(T e);
}
