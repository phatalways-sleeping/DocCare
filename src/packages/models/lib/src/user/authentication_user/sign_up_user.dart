import 'package:equatable/equatable.dart';

final class SignupUser extends Equatable {
  const SignupUser({
    required this.email,
    required this.password,
    required this.birthday,
    required this.fullname,
    required this.phone,
  });

  factory SignupUser.from({
    required String email,
    required String password,
    required DateTime birthday,
    required String fullname,
    required String phone,
  }) {
    return SignupUser(
      email: email,
      password: password,
      birthday: birthday,
      fullname: fullname,
      phone: phone,
    );
  }

  final String email;
  final String password;
  final DateTime birthday;
  final String fullname;
  final String phone;
  
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
      email: email ?? this.email,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      fullname: fullname ?? this.fullname,
      phone: phone ?? this.phone,
    );
  }
}
