import 'package:controllers/src/authentication/authentication_repository.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility/utility.dart' show FormValidator;

/// [SupabaseAuthenticationRepository] is the implementation of
/// [AuthenticationRepositoryService] for Supabase
class SupabaseAuthenticationRepository
    implements AuthenticationRepositoryService {
  /// [SupabaseAuthenticationRepository] constructor
  SupabaseAuthenticationRepository();

  /// [Supabase.instance.client] is the static instance of [SupabaseClient]
  /// [_authEmailApiService] is the instance of [AuthEmailApiService]
  final AuthEmailApiService _authEmailApiService = SupabaseAuthEmailApiService(
    supabase: Supabase.instance.client,
  );

  @override
  Future<void> changePassword(String password) async {
    final passwordValidation = FormValidator.validatePassword(password);

    if (!passwordValidation.isValid) {
      throw AuthException(passwordValidation.cause!);
    }

    await _authEmailApiService.changePassword(password);
  }

  @override
  Future<void> login(String email, String password) async {
    final emailValidation = FormValidator.validateEmail(email);
    final passwordValidation = FormValidator.validatePassword(password);

    if (!emailValidation.isValid) {
      throw AuthException(emailValidation.cause!);
    }

    if (!passwordValidation.isValid) {
      throw AuthException(passwordValidation.cause!);
    }

    await _authEmailApiService.signInWithEmailPassword(
      email,
      password,
    );
  }

  @override
  Future<void> logout() => _authEmailApiService.signOut();

  @override
  Future<void> sendCode(String email) =>
      _authEmailApiService.sendPasswordResetEmail(email);

  @override
  Future<void> signUp(String email, String password) =>
      _authEmailApiService.signUpWithEmailPassword(
        email,
        password,
      );
}
