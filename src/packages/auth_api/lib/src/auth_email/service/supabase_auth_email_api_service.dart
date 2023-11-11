import 'auth_email_api_service.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthEmailApiService implements AuthEmailApiService {
  const SupabaseAuthEmailApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } on PlatformException catch (e) {
      handleAuthException(e);
    } catch (e) {
      throw AuthException('Sign-up failed. Please try again.');
    }
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } on PlatformException catch (e) {
      handleAuthException(e);
    } catch (e) {
      throw AuthException('Sign-in failed. Please try again.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw AuthException('Sign-out failed. Please try again.');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } on PlatformException catch (e) {
      handleAuthException(e);
    } catch (e) {
      throw AuthException('Password reset failed. Please try again.');
    }
  }

  void handleAuthException(PlatformException e) {
    // Handle specific platform exceptions and throw custom AuthException
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
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}
