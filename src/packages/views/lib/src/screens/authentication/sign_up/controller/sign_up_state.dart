// ignore_for_file: public_member_api_docs

part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  const SignUpState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthday,
    required this.tempBirthday,
    required this.confirmPassword,
    required this.checkedTerm,
    required this.phone,
  });

  final String fullName;

  final String email;

  final String password;

  final DateTime birthday;

  final String tempBirthday;

  final String confirmPassword;

  final bool checkedTerm;

  final String phone;

  @override
  List<Object> get props => [
        fullName,
        email,
        password,
        birthday,
        tempBirthday,
        confirmPassword,
        checkedTerm,
        phone,
      ];

  SignUpState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? confirmPassword,
    bool? checkedTerm,
    String? phone,
  });
}

final class SignUpInitial extends SignUpState {
  SignUpInitial.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          tempBirthday: '',
          confirmPassword: '',
          checkedTerm: false,
          phone: '',
        );

  const SignUpInitial.input({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.confirmPassword,
    required super.checkedTerm,
    required super.phone,
  });

  @override
  SignUpState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? confirmPassword,
    bool? checkedTerm,
    String? phone,
  }) =>
      SignUpInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        confirmPassword: confirmPassword ?? super.confirmPassword,
        checkedTerm: checkedTerm ?? super.checkedTerm,
        phone: phone ?? super.phone,
      );
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.confirmPassword,
    required super.checkedTerm,
    required super.phone,
  });

  factory SignUpLoading.from(SignUpState state) => SignUpLoading(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        confirmPassword: state.confirmPassword,
        checkedTerm: state.checkedTerm,
        phone: state.phone,
      );

  SignUpState toggleBackToInitial() => SignUpInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        tempBirthday: tempBirthday,
        confirmPassword: confirmPassword,
        checkedTerm: checkedTerm,
        phone: phone,
      );

  @override
  SignUpState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? confirmPassword,
    bool? checkedTerm,
    String? phone,
  }) =>
      SignUpLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        confirmPassword: confirmPassword ?? super.confirmPassword,
        checkedTerm: checkedTerm ?? super.checkedTerm,
        phone: phone ?? super.phone,
      );
}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.confirmPassword,
    required super.checkedTerm,
    required super.phone,
  });

  factory SignUpSuccess.from(SignUpState state) => SignUpSuccess(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        confirmPassword: state.confirmPassword,
        checkedTerm: state.checkedTerm,
        phone: state.phone,
      );

  @override
  SignUpState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? confirmPassword,
    bool? checkedTerm,
    String? phone,
  }) =>
      SignUpSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        confirmPassword: confirmPassword ?? super.confirmPassword,
        checkedTerm: checkedTerm ?? super.checkedTerm,
        phone: phone ?? super.phone,
      );
}

final class SignUpFailure extends SignUpState {
  const SignUpFailure({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.confirmPassword,
    required super.checkedTerm,
    required super.phone,
    required this.message,
  });

  factory SignUpFailure.from(SignUpState state, String message) =>
      SignUpFailure(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        confirmPassword: state.confirmPassword,
        checkedTerm: state.checkedTerm,
        phone: state.phone,
        message: message,
      );

  SignUpState toggleBackToInitial() => SignUpInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        tempBirthday: tempBirthday,
        confirmPassword: confirmPassword,
        checkedTerm: checkedTerm,
        phone: phone,
      );

  final String message;

  @override
  SignUpState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? confirmPassword,
    bool? checkedTerm,
    String? phone,
  }) =>
      SignUpFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        confirmPassword: confirmPassword ?? super.confirmPassword,
        checkedTerm: checkedTerm ?? super.checkedTerm,
        phone: phone ?? super.phone,
        message: message,
      );
}
