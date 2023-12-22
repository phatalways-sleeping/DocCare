import 'package:services/src/authentication/auth_email_api_service.dart';
import 'package:services/src/authentication/error_handler/auth_email_api_error_handler.dart';
import 'package:services/src/authentication/error_handler/supabase_auth_email_api_error_handler.dart';
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
  Future<void> signUpWithEmailPassword(
    String email,
    String password,
    String id,
  ) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'role': 'customer',
          'id': id,
        },
      );
    } on AuthException catch (e) {
      errorHandler.handleAuthException(e);
    }
  }

  @override
  Future<User> signInWithEmailPassword(String email, String password) async {
    final response = await supabase.auth
        .signInWithPassword(email: email, password: password);
    if (response.user == null) {
      throw const AuthException('User is null');
    }
    return response.user!;
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
