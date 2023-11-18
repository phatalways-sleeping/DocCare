import 'package:auth_api/src/auth_email/error_handler/auth_email_api_error_handler.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseAuthEmailApiErrorHandler] is the implementation of
/// [AuthEmailApiErrorHandler] for Supabase
class SupabaseAuthEmailApiErrorHandler implements AuthEmailApiErrorHandler {
  /// [SupabaseAuthEmailApiErrorHandler] constructor
  const SupabaseAuthEmailApiErrorHandler({
    required this.error,
  });

  final Exception error;

  @override
  void handleAuthException(Exception e) {
    // Handle specific platform exceptions and throw custom AuthException
    if (e is PlatformException) {
      if (e.code == 'MISSING_EMAIL') {
        throw const AuthException('Email is required.');
      } else if (e.code == 'MISSING_PASSWORD') {
        throw const AuthException('Password is required.');
      } else if (e.code == 'INVALID_CREDENTIALS') {
        throw const AuthException('Invalid email or password.');
      } else if (e.code == 'WEAK_PASSWORD') {
        throw const AuthException('Password is too weak.');
      } else if (e.code == 'EMAIL_ALREADY_IN_USE') {
        throw const AuthException('Email is already in use.');
      } else if (e.code == 'USER_NOT_FOUND') {
        throw const AuthException('Email not found.');
      } else {
        throw const AuthException('Authentication failed. Please try again.');
      }
    } else {
      // Handle non-PlatformException errors if needed
      throw const AuthException('Authentication failed. Please try again.');
    }
  }
}
