// ignore_for_file: public_member_api_docs

part of 'staff_removal_bloc.dart';

@immutable
sealed class StaffRemovalState extends Equatable {
  const StaffRemovalState({
    required this.role,
    required this.email,
  });

  final String role;
  final String email;

  @override
  List<Object> get props => [role, email];

  StaffRemovalState copyWith({
    String? role,
    String? email,
  });
}

final class StaffRemovalInitial extends StaffRemovalState {
  const StaffRemovalInitial({
    required super.role,
    required super.email,
  });

  factory StaffRemovalInitial.initial() {
    return const StaffRemovalInitial(
      role: 'Doctor',
      email: '',
    );
  }

  factory StaffRemovalInitial.fromState(StaffRemovalState state) {
    return StaffRemovalInitial(
      role: state.role,
      email: state.email,
    );
  }

  @override
  StaffRemovalState copyWith({
    String? role,
    String? email,
  }) {
    return StaffRemovalInitial(
      role: role ?? super.role,
      email: email ?? super.email,
    );
  }
}

final class StaffRemovalLoading extends StaffRemovalState {
  const StaffRemovalLoading({
    required super.role,
    required super.email,
  });

  factory StaffRemovalLoading.fromState(StaffRemovalState state) {
    return StaffRemovalLoading(
      role: state.role,
      email: state.email,
    );
  }

  @override
  StaffRemovalState copyWith({
    String? role,
    String? email,
  }) {
    return StaffRemovalLoading(
      role: role ?? super.role,
      email: email ?? super.email,
    );
  }
}

final class StaffRemovalSuccess extends StaffRemovalState {
  const StaffRemovalSuccess({
    required super.email,
    required super.role,
  });

  factory StaffRemovalSuccess.fromState(StaffRemovalState state) {
    return StaffRemovalSuccess(
      role: state.role,
      email: state.email,
    );
  }

  @override
  StaffRemovalState copyWith({
    String? role,
    String? email,
  }) {
    return StaffRemovalSuccess(
      role: role ?? super.role,
      email: email ?? super.email,
    );
  }
}

final class StaffRemovalFailure extends StaffRemovalState {
  const StaffRemovalFailure({
    required super.role,
    required super.email,
    required this.errorMessage,
  });

  factory StaffRemovalFailure.fromState({
    required StaffRemovalState state,
    required String errorMessage,
  }) {
    return StaffRemovalFailure(
      role: state.role,
      email: state.email,
      errorMessage: errorMessage,
    );
  }

  final String errorMessage;

  @override
  StaffRemovalState copyWith({
    String? role,
    String? email,
  }) {
    return StaffRemovalFailure(
      role: role ?? super.role,
      email: email ?? super.email,
      errorMessage: errorMessage,
    );
  }
}
