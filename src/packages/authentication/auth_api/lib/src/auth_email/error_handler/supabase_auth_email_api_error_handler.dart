import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_email_api_error_handler.dart';

class SupabaseAuthEmailApiErrorHandler implements AuthEmailApiErrorHandler {
  const SupabaseAuthEmailApiErrorHandler();
  
  @override
  void handleAuthException(dynamic e) {
    // Handle specific platform exceptions and throw custom AuthException
    if (e is PlatformException) {
      if (e.code == 'MISSING_EMAIL') {
        throw AuthException('Email is required.');
      } else if (e.code == 'MISSING_PASSWORD') {
        throw AuthException('Password is required.');
      } else if (e.code == 'INVALID_CREDENTIALS') {
        throw AuthException('Invalid email or password.');
      } else if (e.code == 'WEAK_PASSWORD') {
        throw AuthException('Password is too weak.');
      } else if (e.code == 'EMAIL_ALREADY_IN_USE') {
        throw AuthException('Email is already in use.');
      } else if (e.code == 'USER_NOT_FOUND') {
        throw AuthException('Email not found.');
      } else {
        throw AuthException('Authentication failed. Please try again.');
      }
    } else {
      // Handle non-PlatformException errors if needed
      throw AuthException('Authentication failed. Please try again.');
    }
  }
}
