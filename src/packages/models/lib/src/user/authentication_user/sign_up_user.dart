// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:models/src/user/authentication_user/authentication_user_service.dart';

/// [SignUpUser] is the user for registration
final class SignUpUser extends Equatable
    implements RegistrationAuthenticationUserService {
  /// Constructor
  const SignUpUser(
    this._email,
    this._password,
    this._birthday,
    this._fullname,
    this._phone,
  );

  factory SignUpUser.from(RegistrationAuthenticationUserService user) =>
      SignUpUser(
        user.email,
        user.password,
        user.birthday,
        user.fullname,
        user.phone,
      );

  final String _email;
  final String _password;
  final String _birthday;
  final String _fullname;
  final String _phone;

  @override
  String get email => _email;

  @override
  String get password => _password;

  @override
  String get birthday => _birthday;

  @override
  String get fullname => _fullname;

  @override
  String get phone => _phone;

  @override
  List<Object?> get props => [email, password, birthday, fullname, phone];

  SignUpUser copyWith({
    String? email,
    String? password,
    String? birthday,
    String? fullname,
    String? phone,
  }) {
    return SignUpUser(
      email ?? this.email,
      password ?? this.password,
      birthday ?? this.birthday,
      fullname ?? this.fullname,
      phone ?? this.phone,
    );
  }
}
