import 'package:equatable/equatable.dart';
import 'package:models/src/user/authentication_user/authentication_user_service.dart';

final class LoginUser extends Equatable implements AuthenticationUserService {
  const LoginUser(
    this._email,
    this._password,
  );

  factory LoginUser.from(AuthenticationUserService user) => LoginUser(
        user.email,
        user.password,
      );

  final String _email;
  final String _password;

  @override
  String get email => _email;

  @override
  String get password => _password;

  @override
  List<Object?> get props => [email, password];

  LoginUser copyWith({
    String? email,
    String? password,
  }) {
    return LoginUser(
      email ?? this.email,
      password ?? this.password,
    );
  }
}
