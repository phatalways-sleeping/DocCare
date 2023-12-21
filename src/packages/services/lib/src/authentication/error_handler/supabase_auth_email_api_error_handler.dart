import 'package:services/src/authentication/error_handler/auth_email_api_error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseAuthEmailApiErrorHandler] is the implementation of
/// [AuthEmailApiErrorHandler] for Supabase
class SupabaseAuthEmailApiErrorHandler
    implements AuthEmailApiErrorHandler<AuthException> {
  /// [SupabaseAuthEmailApiErrorHandler] constructor
  const SupabaseAuthEmailApiErrorHandler();

  @override
  void handleAuthException(AuthException e) {
    // Handle specific platform exceptions and throw custom AuthException
    if (e.message == 'Invalid email or password') {
      throw const AuthException('Invalid email or password. Please type again');
    } else if (e.message == 'User not confirmed') {
      throw const AuthException('User not confirmed. Please try again');
    } else if (e.message == 'User disabled') {
      throw const AuthException('User disabled. Please try again');
    } else if (e.message == 'User not found') {
      throw const AuthException('User not found.');
    } else if (e.message == 'Too many attempts. Please try again later') {
      throw const AuthException('Too many attempts. Please try again later');
    } else if (e.message == 'Password is too weak') {
      throw const AuthException(
        'Password is too weak, please use stronger password',
      );
    } else if (e.message == 'Network error') {
      throw const AuthException('Network error, try again');
    } else {
      throw e;
    }
  }
}
