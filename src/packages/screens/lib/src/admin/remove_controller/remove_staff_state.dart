// ignore_for_file: public_member_api_docs, non_constant_identifier_names, prefer_int_literals

part of 'remove_staff_bloc.dart';

@immutable
sealed class RemoveStaffState extends Equatable {
  const RemoveStaffState({
    required this.email,
    this.role = 'Doctor',
  });
  final String email;

  final String role;

  @override
  List<Object> get props => [
        email,
        role,
      ];

  RemoveStaffState copyWith({
    String? email,
    String? role,
  });
}

final class RemoveStaffInitial extends RemoveStaffState {
  RemoveStaffInitial.empty()
      : super(
          email: '',
          role: '',
        );

  const RemoveStaffInitial.input({
    required super.email,
    required super.role,
  });

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
  }) =>
      RemoveStaffInitial.input(
        email: email ?? super.email,
        role: role ?? super.role,
      );
}

final class RemoveStaffLoading extends RemoveStaffState {
  const RemoveStaffLoading({
    required super.email,
    required super.role,
  });

  factory RemoveStaffLoading.from(RemoveStaffState state) => RemoveStaffLoading(
        email: state.email,
        role: state.role,
      );

  RemoveStaffState toggleBackToInitial() => RemoveStaffInitial.input(
        email: email,
        role: role,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
  }) =>
      RemoveStaffLoading(
        email: email ?? super.email,
        role: role ?? super.role,
      );
}

final class RemoveStaffSuccess extends RemoveStaffState {
  const RemoveStaffSuccess({
    required super.email,
    required super.role,
  });

  factory RemoveStaffSuccess.from(RemoveStaffState state) => RemoveStaffSuccess(
        email: state.email,
        role: state.role,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
  }) =>
      RemoveStaffSuccess(
        email: email ?? super.email,
        role: role ?? super.role,
      );
}

final class RemoveStaffFailure extends RemoveStaffState {
  const RemoveStaffFailure({
    required super.email,
    required super.role,
  });

  factory RemoveStaffFailure.from(RemoveStaffState state, String message) =>
      RemoveStaffFailure(
        email: state.email,
        role: state.role,
      );

  RemoveStaffState toggleBackToInitial() => RemoveStaffInitial.input(
        email: email,
        role: role,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
  }) =>
      RemoveStaffFailure(
        email: email ?? super.email,
        role: role ?? super.role,
      );
}
