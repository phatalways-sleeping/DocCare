abstract interface class AuthEmailApiErrorHandler<T extends Exception> {
  void handleAuthException(T e);
}
