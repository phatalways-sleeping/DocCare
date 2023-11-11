import 'auth_email_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:auth_api/src/auth_email/error_handler/auth_email_api_error_handler.dart';

class SupabaseAuthEmailApiService implements AuthEmailApiService {
  const SupabaseAuthEmailApiService({
    required this.supabase,
    required this.errorHandler,
  });

  final SupabaseClient supabase;
  final AuthEmailApiErrorHandler errorHandler;

  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      errorHandler.handleAuthException(e);
    }
  }
}
