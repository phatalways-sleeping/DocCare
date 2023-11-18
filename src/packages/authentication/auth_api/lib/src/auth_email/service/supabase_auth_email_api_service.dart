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

  final SupabaseClient supabase;
  @override
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
    } catch (e) {
      throw SupabaseAuthEmailApiErrorHandler(error: Exception(e));
    }
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw SupabaseAuthEmailApiErrorHandler(error: Exception(e));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw SupabaseAuthEmailApiErrorHandler(error: Exception(e));
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw SupabaseAuthEmailApiErrorHandler(error: Exception(e));
    }
  }

  @override
  Future<void> changePassword(
    String email,
    String password,
    String newPassword,
  ) =>
      throw UnimplementedError();
}
