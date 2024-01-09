import 'package:controllers/src/authentication/authentication_repository.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility/utility.dart' show FormValidator;

/// [SupabaseAuthenticationRepository] is the implementation of
/// [AuthenticationRepositoryService] for Supabase
class SupabaseAuthenticationRepository
    implements AuthenticationRepositoryService {
  /// [SupabaseAuthenticationRepository] constructor
  SupabaseAuthenticationRepository(
    this._supabaseUrl,
    this._serviceRoleKey,
  );

  /// [Supabase.instance.client] is the static instance of [SupabaseClient]
  /// [_authEmailApiService] is the instance of [AuthEmailApiService]
  final AuthEmailApiService _authEmailApiService = SupabaseAuthEmailApiService(
    supabase: Supabase.instance.client,
  );

  late String _role;

  final String _serviceRoleKey;
  final String _supabaseUrl;

  @override
  Future<void> changePassword(String password) async {
    // final passwordValidation = FormValidator.validatePassword(password);

    // if (!passwordValidation.isValid) {
    //   throw AuthException(passwordValidation.cause!);
    // }
    await _authEmailApiService.changePassword(password);
  }

  @override
  Future<List<String>> login(String email, String password) async {
    final emailValidation = FormValidator.validateEmail(email);
    // final passwordValidation = FormValidator.validatePassword(password);

    if (!emailValidation.isValid) {
      throw AuthException(emailValidation.cause!);
    }

    // if (!passwordValidation.isValid) {
    //   throw AuthException(passwordValidation.cause!);
    // }

    final user = await _authEmailApiService
        .signInWithEmailPassword(
          email,
          password,
        )
        .timeout(
          const Duration(
            seconds: 10,
          ),
        );
    final role = user.userMetadata!['role']! as String;
    return [
      role,
      if (role == 'admin') '' else user.userMetadata!['id']! as String,
    ];
  }

  @override
  Future<void> logout() => _authEmailApiService.signOut();

  @override
  Future<void> sendCode(String email) =>
      _authEmailApiService.sendPasswordResetEmail(email);

  @override
  Future<void> signUp(
    String email,
    String password,
    String id,
  ) =>
      _authEmailApiService
          .signUpWithEmailPassword(
            email,
            password,
            id,
          )
          .timeout(
            const Duration(
              seconds: 10,
            ),
          );

  @override
  String get role => _role;

  @override
  void setRole(String role) {
    _role = role;
  }

  @override
  Future<User?> fetchUserByEmail(String email) async {
    if (email.isEmpty) {
      throw Exception('Email is empty');
    }
    if (!FormValidator.validateEmail(email).isValid) {
      throw Exception('Email is invalid');
    }
    final auth = SupabaseClient(_supabaseUrl, _serviceRoleKey).auth;
    final defaultUser = User(
      id: '@default.id',
      email: 'admin@doccare.io',
      aud: '',
      appMetadata: {},
      createdAt: DateTime.now().toIso8601String(),
      lastSignInAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      userMetadata: {},
    );
    final user = await auth.admin.listUsers().then(
          (value) => value.firstWhere(
            (element) => element.email == email,
            orElse: () => defaultUser,
          ),
        );
    return user == defaultUser ? null : user;
  }

  @override
  Future<void> disableAccount(String id) {
    final auth = SupabaseClient(_supabaseUrl, _serviceRoleKey).auth;
    return auth.admin.updateUserById(
      id,
      attributes: AdminUserAttributes(
        userMetadata: {'enable': false},
      ),
    );
  }

  @override
  Future<void> removeAccount(String id) {
    final auth = SupabaseClient(_supabaseUrl, _serviceRoleKey).auth;
    return auth.admin.deleteUser(id);
  }
}
