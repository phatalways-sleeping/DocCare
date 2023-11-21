import 'package:equatable/equatable.dart';
import 'package:models/src/user/authentication_user/authentication_user_service.dart';

/// [ChangePasswordUser] is the user for change password
final class ChangePasswordUser extends Equatable
    implements ChangePasswordUserService {
  /// Constructor
  const ChangePasswordUser(
    this._email,
    this._password,
    this._newPassword,
  );

  factory ChangePasswordUser.from(
    AuthenticationUserService user, {
    required String withNewPassword,
  }) {
    return ChangePasswordUser(
      user.email,
      user.password,
      withNewPassword,
    );
  }

  final String _email;
  final String _password;
  final String _newPassword;

  @override
  String get email => _email;

  @override
  String get password => _password;

  @override
  String get newPassword => _newPassword;

  @override
  List<Object?> get props => [email, password, newPassword];

  ChangePasswordUser copyWith({
    String? email,
    String? password,
    String? newPassword,
  }) {
    return ChangePasswordUser(
      email ?? this.email,
      password ?? this.password,
      newPassword ?? this.newPassword,
    );
  }
}
