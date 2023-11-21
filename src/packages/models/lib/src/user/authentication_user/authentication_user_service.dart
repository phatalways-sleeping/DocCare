/// [AuthenticationUserService] is the interface for the user
/// service of authentication for login and forgot password
abstract interface class AuthenticationUserService {
  /// Constructor
  const AuthenticationUserService();

  /// [email] is the email of the user
  String get email;

  /// [password] is the password of the user
  String get password;
}

/// [ChangePasswordUserService] is the interface for the user
/// service of authentication for sign up
abstract interface class ChangePasswordUserService
    extends AuthenticationUserService {
  /// Constructor
  const ChangePasswordUserService();

  /// [newPassword] is the new password of the user
  String get newPassword;
}

/// [RegistrationAuthenticationUserService] is the interface for the user
/// service of authentication for registration
abstract interface class RegistrationAuthenticationUserService
    extends AuthenticationUserService {
  /// {@macro auth_domain}
  const RegistrationAuthenticationUserService();

  /// [birthday] is the birthday of the user
  DateTime get birthday;

  /// [fullname] is the fullname of the user
  String get fullname;

  /// [phone] is the phone of the user
  String get phone;
}
