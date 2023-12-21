// ignore_for_file: doc_directive_missing_closing_tag

part of 'login_bloc.dart';

/// {@template login_event}
/// [LoginEvent] is a [sealed] class that extends [Equatable].
/// It is used to handle the events in the [LoginBloc].
@immutable
sealed class LoginEvent extends Equatable {
  /// Constructor for [LoginEvent].
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// [EmailInputEvent] is a [LoginEvent] that is used to handle the email input
/// in the [DCLoginModalBottomSheet].
final class EmailInputEvent extends LoginEvent {
  /// Constructor for [EmailInputEvent].
  const EmailInputEvent(this.email);

  /// [email] is the email input.
  final String email;

  @override
  List<Object> get props => [email];
}

/// [PasswordInputEvent] is a [LoginEvent] that is used to handle the password
/// input in the [DCLoginModalBottomSheet].
final class PasswordInputEvent extends LoginEvent {
  /// Constructor for [PasswordInputEvent].
  const PasswordInputEvent(this.password);

  /// [password] is the password input.
  final String password;

  @override
  List<Object> get props => [password];
}

/// [LoginButtonPressedEvent] is a [LoginEvent] that is used to handle the
/// login button press in the [DCLoginModalBottomSheet].
final class LoginButtonPressedEvent extends LoginEvent {
  /// Constructor for [LoginButtonPressedEvent].
  const LoginButtonPressedEvent();
}

/// [GoogleLoginButtonPressedEvent] is a [LoginEvent] that is used to handle
/// the Google login button press in the [DCLoginModalBottomSheet].
final class GoogleLoginButtonPressedEvent extends LoginEvent {
  /// Constructor for [GoogleLoginButtonPressedEvent].
  const GoogleLoginButtonPressedEvent();
}

