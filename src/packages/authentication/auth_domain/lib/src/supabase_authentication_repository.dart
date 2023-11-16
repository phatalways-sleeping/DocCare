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
  Future<void> login(AuthenticationUserService user) =>
      _authEmailApiService.signInWithEmailPassword(user.email, user.password);

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
