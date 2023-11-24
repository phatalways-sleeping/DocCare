// ignore_for_file: public_member_api_docs

part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [
        email,
      ];

  ChangePasswordState copyWith({
    String? email,
  });
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial.empty() : super(email: '');

  const ChangePasswordInitial.input({
    required super.email,
  });

  @override
  ChangePasswordState copyWith({
    String? email,
  }) =>
      ChangePasswordInitial.input(
        email: email ?? this.email,
      );
}

final class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading({required super.email});

  factory ChangePasswordLoading.from(ChangePasswordState state) =>
      ChangePasswordLoading(
        email: state.email,
      );

  ChangePasswordState toggleBackToInitial() => ChangePasswordInitial.input(
        email: email,
      );

  @override
  ChangePasswordState copyWith({
    String? email,
  }) =>
      ChangePasswordLoading(
        email: email ?? this.email,
      );
}

final class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess({required super.email});

  factory ChangePasswordSuccess.from(ChangePasswordState state) =>
      ChangePasswordSuccess(
        email: state.email,
      );

  ChangePasswordState toggleBackToInitial() => ChangePasswordInitial.input(
        email: email,
      );

  @override
  ChangePasswordState copyWith({
    String? email,
  }) =>
      ChangePasswordSuccess(
        email: email ?? this.email,
      );
}

final class ChangePasswordFailure extends ChangePasswordState {
  const ChangePasswordFailure({
    required super.email,
    required this.message,
  });

  factory ChangePasswordFailure.from(
    ChangePasswordState state,
    String message,
  ) =>
      ChangePasswordFailure(
        email: state.email,
        message: message,
      );

  ChangePasswordState toggleBackToInitial() => ChangePasswordInitial.input(
        email: email,
      );

  final String message;

  @override
  ChangePasswordState copyWith({
    String? email,
  }) =>
      ChangePasswordFailure(
        email: email ?? this.email,
        message: message,
      );
}

final class ChangePasswordError extends ChangePasswordState {
  const ChangePasswordError({
    required super.email,
    required this.message,
  });

  factory ChangePasswordError.from(
    ChangePasswordState state,
    String message,
  ) =>
      ChangePasswordError(
        email: state.email,
        message: message,
      );

  ChangePasswordState toggleBackToInitial() => ChangePasswordInitial.input(
        email: email,
      );

  final String message;

  @override
  ChangePasswordState copyWith({
    String? email,
  }) =>
      ChangePasswordError(
        email: email ?? this.email,
        message: message,
      );
}

final class ChangePasswordCooldown extends ChangePasswordState {
  const ChangePasswordCooldown({
    required super.email,
    required this.start,
  });

  factory ChangePasswordCooldown.from(
    ChangePasswordState state,
    int start,
  ) =>
      ChangePasswordCooldown(
        email: state.email,
        start: start,
      );

  final int start;

  @override
  ChangePasswordState copyWith({
    String? email,
  }) =>
      ChangePasswordCooldown(
        email: email ?? this.email,
        start: start,
      );
}
