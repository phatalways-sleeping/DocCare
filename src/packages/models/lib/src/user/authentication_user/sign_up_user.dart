import 'package:equatable/equatable.dart';
import 'package:models/src/user/authentication_user/authentication_user_service.dart';

/// [SignupUser] is the user for registration
final class SignupUser extends Equatable
    implements RegistrationAuthenticationUserService {
  /// Constructor
  const SignupUser(
    this._email,
    this._password,
    this._birthday,
    this._fullname,
    this._phone,
  );

  factory SignupUser.from(RegistrationAuthenticationUserService user) =>
      SignupUser(
        user.email,
        user.password,
        user.birthday,
        user.fullname,
        user.phone,
      );

  final String _email;
  final String _password;
  final DateTime _birthday;
  final String _fullname;
  final String _phone;

  @override
  String get email => _email;

  @override
  String get password => _password;

  @override
  DateTime get birthday => _birthday;

  @override
  String get fullname => _fullname;

  @override
  String get phone => _phone;

  @override
  List<Object?> get props => [email, password, birthday, fullname, phone];

  SignupUser copyWith({
    String? email,
    String? password,
    DateTime? birthday,
    String? fullname,
    String? phone,
  }) {
    return SignupUser(
      email ?? this.email,
      password ?? this.password,
      birthday ?? this.birthday,
      fullname ?? this.fullname,
      phone ?? this.phone,
    );
  }
}
