// ignore_for_file: public_member_api_docs

part of 'create_staff_bloc.dart';

@immutable
sealed class CreateStaffState extends Equatable {
  const CreateStaffState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthdate,
    required this.phoneNumber,
    required this.role,
    required this.specialization,
    required this.workingShifts,
  });

  final String fullName;
  final String email;
  final String password;
  final String birthdate;
  final String phoneNumber;
  final String role;
  final String specialization;
  final List<Map<String, dynamic>> workingShifts;

  @override
  List<Object> get props => [
        fullName,
        email,
        password,
        birthdate,
        phoneNumber,
        role,
        specialization,
        workingShifts,
      ];

  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? birthdate,
    String? phoneNumber,
    String? role,
    String? specialization,
    List<Map<String, dynamic>>? workingShifts,
  });
}

final class CreateStaffInitial extends CreateStaffState {
  const CreateStaffInitial({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthdate,
    required super.phoneNumber,
    required super.role,
    required super.specialization,
    required super.workingShifts,
  });

  factory CreateStaffInitial.fromState(CreateStaffState state) {
    return CreateStaffInitial(
      fullName: state.fullName,
      email: state.email,
      password: state.password,
      birthdate: state.birthdate,
      phoneNumber: state.phoneNumber,
      role: state.role,
      specialization: state.specialization,
      workingShifts: state.workingShifts,
    );
  }

  factory CreateStaffInitial.initial() {
    return const CreateStaffInitial(
      fullName: '',
      email: '',
      password: '',
      birthdate: '',
      phoneNumber: '',
      role: 'Receptionist',
      specialization: '',
      workingShifts: [],
    );
  }

  @override
  CreateStaffInitial copyWith({
    String? fullName,
    String? email,
    String? password,
    String? birthdate,
    String? phoneNumber,
    String? role,
    String? specialization,
    List<Map<String, dynamic>>? workingShifts,
  }) {
    return CreateStaffInitial(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthdate: birthdate ?? this.birthdate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      specialization: specialization ?? this.specialization,
      workingShifts: workingShifts ?? this.workingShifts,
    );
  }
}

final class CreateStaffLoading extends CreateStaffState {
  const CreateStaffLoading({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthdate,
    required super.phoneNumber,
    required super.role,
    required super.specialization,
    required super.workingShifts,
  });

  factory CreateStaffLoading.fromState(CreateStaffState state) {
    return CreateStaffLoading(
      fullName: state.fullName,
      email: state.email,
      password: state.password,
      birthdate: state.birthdate,
      phoneNumber: state.phoneNumber,
      role: state.role,
      specialization: state.specialization,
      workingShifts: state.workingShifts,
    );
  }

  @override
  CreateStaffLoading copyWith({
    String? fullName,
    String? email,
    String? password,
    String? birthdate,
    String? phoneNumber,
    String? role,
    String? specialization,
    List<Map<String, dynamic>>? workingShifts,
  }) {
    return CreateStaffLoading(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthdate: birthdate ?? this.birthdate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      specialization: specialization ?? this.specialization,
      workingShifts: workingShifts ?? this.workingShifts,
    );
  }
}

final class CreateStaffSuccess extends CreateStaffState {
  const CreateStaffSuccess(String role)
      : super(
          fullName: '',
          email: '',
          password: '',
          birthdate: '',
          phoneNumber: '',
          role: role,
          specialization: '',
          workingShifts: const [],
        );

  factory CreateStaffSuccess.fromState(CreateStaffState state) {
    return CreateStaffSuccess(
      state.role,
    );
  }

  @override
  CreateStaffSuccess copyWith({
    String? fullName,
    String? email,
    String? password,
    String? birthdate,
    String? phoneNumber,
    String? role,
    String? specialization,
    List<Map<String, dynamic>>? workingShifts,
  }) {
    return CreateStaffSuccess(
      role ?? this.role,
    );
  }
}

final class CreateStaffFailure extends CreateStaffState {
  const CreateStaffFailure({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthdate,
    required super.phoneNumber,
    required super.role,
    required super.specialization,
    required super.workingShifts,
    required this.errorMessage,
  });

  factory CreateStaffFailure.fromState({
    required CreateStaffState state,
    required String errorMessage,
  }) {
    return CreateStaffFailure(
      fullName: state.fullName,
      email: state.email,
      password: state.password,
      birthdate: state.birthdate,
      phoneNumber: state.phoneNumber,
      role: state.role,
      specialization: state.specialization,
      workingShifts: state.workingShifts,
      errorMessage: errorMessage,
    );
  }

  final String errorMessage;

  @override
  CreateStaffFailure copyWith({
    String? fullName,
    String? email,
    String? password,
    String? birthdate,
    String? phoneNumber,
    String? role,
    String? specialization,
    List<Map<String, dynamic>>? workingShifts,
    String? errorMessage,
  }) {
    return CreateStaffFailure(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      birthdate: birthdate ?? this.birthdate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      specialization: specialization ?? this.specialization,
      workingShifts: workingShifts ?? this.workingShifts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
