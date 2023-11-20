import 'package:auth_api/src/auth_email/error_handler/auth_email_api_error_handler.dart';
import 'package:auth_api/src/auth_email/error_handler/supabase_auth_email_api_error_handler.dart';
import 'package:auth_api/src/auth_email/service/auth_email_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseAuthEmailApiService] is the implementation
/// of [AuthEmailApiService] using Supabase
class SupabaseAuthEmailApiService implements AuthEmailApiService {
  /// [SupabaseAuthEmailApiService] constructor
  SupabaseAuthEmailApiService({
    required this.supabase,
  });

  /// [supabase] is the instance of [SupabaseClient]
  final SupabaseClient supabase;

  /// [errorHandler] is the concrete implementation
  /// of [AuthEmailApiErrorHandler]
  final AuthEmailApiErrorHandler<AuthException> errorHandler =
      const SupabaseAuthEmailApiErrorHandler();
  
  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
    }
  }
}
