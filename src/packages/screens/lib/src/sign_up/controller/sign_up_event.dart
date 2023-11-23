// ignore_for_file: public_member_api_docs

part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends SignUpEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class EmailInputEvent extends SignUpEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordInputEvent extends SignUpEvent {
  const PasswordInputEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class BirthdayInputEvent extends SignUpEvent {
  const BirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class PhoneInputEvent extends SignUpEvent {
  const PhoneInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class ConfirmPasswordInputEvent extends SignUpEvent {
  const ConfirmPasswordInputEvent(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

final class TermsAndConditionsCheckboxChangedEvent extends SignUpEvent {
  const TermsAndConditionsCheckboxChangedEvent(this.checkedTerm);

  final bool checkedTerm;

  @override
  List<Object> get props => [checkedTerm];
}

final class ValidateBirthdayInputEvent extends SignUpEvent {
  const ValidateBirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class SignUpButtonPressedEvent extends SignUpEvent {
  const SignUpButtonPressedEvent();
}
