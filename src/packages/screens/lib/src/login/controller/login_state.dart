// ignore_for_file: doc_directive_missing_closing_tag

part of 'login_bloc.dart';

/// {@template login_state}
/// [LoginState] is a [sealed] class that extends [Equatable].
@immutable
sealed class LoginState extends Equatable {
  /// Constructor for [LoginState].
  const LoginState({
    required this.email,
    required this.password,
  });

  /// [email] is the email input. Default value depends on the context.
  final String email;

  /// [password] is the password input. Default value depends on the context.
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];

  /// [copyWith] is a method that returns a copy of the [LoginState].
  /// This acts like the copy constructor of the [LoginState].
  LoginState copyWith({
    String? email,
    String? password,
  });
}

/// [LoginInitial] is a [LoginState] that is used to set the initial state of
/// the [LoginBloc].
final class LoginInitial extends LoginState {
  /// Constructor for [LoginInitial].
  /// It sets the default values of [email] and [password] to empty strings.
  const LoginInitial.empty()
      : super(
          email: '',
          password: '',
        );

  /// [LoginInitial.input] is a named constructor for [LoginInitial].
  /// It sets the default value of [email] to the given [email] and
  /// [password] to the given [password].
  const LoginInitial.input({
    required super.email,
    required super.password,
  });

  @override
  LoginState copyWith({String? email, String? password}) => LoginInitial.input(
        email: email ?? super.email,
        password: password ?? super.password,
      );
}

/// [LoginLoading] is a [LoginState] that is used to set the loading state of
/// the [LoginBloc].
/// Loading state is emitted when the login button is pressed.
/// and the login process is started.
final class LoginLoading extends LoginState {
  /// Constructor for [LoginLoading].
  const LoginLoading({
    required super.email,
    required super.password,
  });

  /// [LoginLoading.from] is a named constructor for [LoginLoading].
  /// It sets the default value of [email] to the given [email] and
  /// [password] to the given [password].
  factory LoginLoading.from(LoginState state) => LoginLoading(
        email: state.email,
        password: state.password,
      );

  /// [LoginLoading.toggleBackToInitial] is a method that returns a copy of the
  /// [LoginInitial] state.
  /// This is useful when the user wants to go back to the initial state.
  LoginState toggleBackToInitial() => LoginInitial.input(
        email: email,
        password: password,
      );

  @override
  LoginState copyWith({String? email, String? password}) => LoginLoading(
        email: email ?? super.email,
        password: password ?? super.password,
      );
}

/// [LoginSuccess] is a [LoginState] that is used to set the success state of
/// the [LoginBloc].
/// Success state is emitted when the login process is successful.
final class LoginSuccess extends LoginState {
  /// Constructor for [LoginSuccess].
  const LoginSuccess({
    required super.email,
    required super.password,
  });

  /// [LoginSuccess.from] is a named constructor for [LoginSuccess].
  /// It sets the default value of [email] to the given [email] and
  /// [password] to the given [password].
  factory LoginSuccess.from(LoginState state) => LoginSuccess(
        email: state.email,
        password: state.password,
      );

  @override
  LoginState copyWith({String? email, String? password}) => LoginSuccess(
        email: email ?? super.email,
        password: password ?? super.password,
      );
}

/// [LoginFailure] is a [LoginState] that is used to set the failure state of
/// the [LoginBloc].
/// Failure state is emitted when the login process is unsuccessful.
/// It contains the [message] of the error.
final class LoginFailure extends LoginState {
  /// Constructor for [LoginFailure].
  const LoginFailure({
    required super.email,
    required super.password,
    required this.message,
  });

  /// [LoginFailure.from] is a named constructor for [LoginFailure].
  /// It sets the default value of [email] to the given [email] and
  /// [password] to the given [password].
  factory LoginFailure.from(LoginState state, String message) => LoginFailure(
        email: state.email,
        password: state.password,
        message: message,
      );

  /// [LoginFailure.toggleBackToInitial] is a method that returns a copy of the
  /// [LoginInitial] state.
  /// This is useful when the user wants to go back to the initial state.
  LoginState toggleBackToInitial() => LoginInitial.input(
        email: email,
        password: password,
      );

  /// [message] is the error message.
  final String message;

  @override
  LoginState copyWith({String? email, String? password}) => LoginFailure(
        email: email ?? super.email,
        password: password ?? super.password,
        message: message,
      );
}
