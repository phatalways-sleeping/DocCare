import 'package:models/models.dart'
    show
        AuthenticationUserService,
        ChangePasswordUserService,
        RegistrationAuthenticationUserService;

/// {@template auth_domain}
/// Package for authentication repository
/// {@endtemplate}
abstract interface class AuthenticationRepositoryService {
  /// {@macro auth_domain}
  const AuthenticationRepositoryService();

  /// [login] is the method for login
  Future<void> login(AuthenticationUserService user);

  /// [signUp] is the method for sign up
  Future<void> signUp(RegistrationAuthenticationUserService user);

  /// [sendCode] is the method for send code
  Future<void> sendCode(AuthenticationUserService user);

  /// [changePassword] is the method for change password
  Future<void> changePassword(ChangePasswordUserService user);

  /// [logout] is the method for logout
  Future<void> logout();
}
