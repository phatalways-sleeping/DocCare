// ignore_for_file: public_member_api_docs

part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

final class EmailInputEvent extends ChangePasswordEvent {
  const EmailInputEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class ValidateEmailEvent extends ChangePasswordEvent {
  const ValidateEmailEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class ChangePasswordButtonPressedEvent extends ChangePasswordEvent {
  const ChangePasswordButtonPressedEvent();
}
