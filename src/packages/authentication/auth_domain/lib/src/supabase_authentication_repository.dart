import 'package:auth_api/auth_api.dart';
import 'package:auth_domain/auth_domain.dart';
import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// [SupabaseAuthenticationRepository] is the implementation of
/// [AuthenticationRepositoryService] for Supabase
class SupabaseAuthenticationRepository
    implements AuthenticationRepositoryService {
  /// [SupabaseAuthenticationRepository] constructor
  SupabaseAuthenticationRepository._();

  /// [Supabase.instance.client] is the static instance of [SupabaseClient]
  /// [_authEmailApiService] is the instance of [AuthEmailApiService]
  final AuthEmailApiService _authEmailApiService = SupabaseAuthEmailApiService(
    supabase: Supabase.instance.client,
  );

  /// [instance] is the static instance of [SupabaseAuthenticationRepository]
  static final SupabaseAuthenticationRepository instance =
      SupabaseAuthenticationRepository._();

  @override
  Future<void> changePassword(ChangePasswordUserService user) =>
      _authEmailApiService.changePassword(
        user.email,
        user.password,
        user.newPassword,
      );

  @override
  Future<void> login(AuthenticationUserService user) async {
    /////////////////////////////////////////////////////////////////
    // TODO: extract these steps of validation to a separate class and use it in all authentication repositories. 
    // It could use the idea of Chain of Responsibility pattern.
    /////////////////////////////////////////////////////////////////
    /// Check if email and password is empty
    if (user.email.isEmpty) {
      throw const AuthException('Email cannot be empty');
    }

    if (user.password.isEmpty) {
      throw const AuthException('Password cannot be empty');
    }

    /// Format verification
    final invalidCharacters = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!invalidCharacters.hasMatch(user.email)) {
      throw const AuthException('Email is invalid');
    }

    /// Password length verification
    if (user.password.length < 8) {
      throw const AuthException('Password must be at least 8 characters');
    }
    /////////////////////////////////////////////////////////////////

    await _authEmailApiService.signInWithEmailPassword(
      user.email,
      user.password,
    );
  }

  @override
  Future<void> logout() => _authEmailApiService.signOut();

  @override
  Future<void> sendCode(AuthenticationUserService user) =>
      _authEmailApiService.sendPasswordResetEmail(user.email);

  @override
  Future<void> signUp(RegistrationAuthenticationUserService user) =>
      _authEmailApiService.signUpWithEmailPassword(
        user.email,
        user.password,
      );
}
