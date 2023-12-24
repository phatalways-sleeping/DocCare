import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template auth_domain}
/// Package for authentication repository
/// {@endtemplate}
abstract interface class AuthenticationRepositoryService {
  /// {@macro auth_domain}
  const AuthenticationRepositoryService();

  String get role;

  void setRole(String role);

  /// [login] is the method for login
  Future<List<String>> login(String email, String password);

  /// [signUp] is the method for sign up
  Future<void> signUp(
    String email,
    String password,
    String id,
  );

  Future<void> removeAccount(String email);

  /// [sendCode] is the method for send code
  Future<void> sendCode(String email);

  /// [changePassword] is the method for change password
  Future<void> changePassword(String password);

  /// [logout] is the method for logout
  Future<void> logout();

  /// [fetchUserByEmail] is the method for fetch user by email
  Future<User?> fetchUserByEmail(String email);

  /// [disableAccount] is the method for disable account
  Future<void> disableAccount(String id);
}
