import 'package:equatable/equatable.dart';

final class LoginUser extends Equatable {
  const LoginUser({
    required this.email,
    required this.password,
  });

  factory LoginUser.from({
    required String email,
    required String password,
  }) {
    return LoginUser(
      email: email,
      password: password,
    );
  }

  factory LoginUser.forgetPassword({
    required String email,
  }) {
    return LoginUser(
      email: email,
      password: '',
    );
  }

  final String email;
  final String password;
  
  @override
  List<Object?> get props => [email, password];

  LoginUser copyWith({
    String? email,
    String? password,
  }) {
    return LoginUser(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
