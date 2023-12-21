/// {@template auth_domain}
/// Package for authentication repository
/// {@endtemplate}
abstract interface class AuthenticationRepositoryService {
  /// {@macro auth_domain}
  const AuthenticationRepositoryService();

  /// [login] is the method for login
  Future<List<String>> login(String email, String password);

  /// [signUp] is the method for sign up
  Future<void> signUp(
    String email,
    String password,
    String id,
  );

  /// [sendCode] is the method for send code
  Future<void> sendCode(String email);

  /// [changePassword] is the method for change password
  Future<void> changePassword(String password);

  /// [logout] is the method for logout
  Future<void> logout();
}
