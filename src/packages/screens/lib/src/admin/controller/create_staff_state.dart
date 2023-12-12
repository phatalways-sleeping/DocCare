// ignore_for_file: public_member_api_docs, non_constant_identifier_names, prefer_int_literals

part of 'create_staff_bloc.dart';

@immutable
sealed class CreateStaffState extends Equatable {
  const CreateStaffState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthday,
    required this.role,
    required this.phone,
    required this.specializationId,
    required this.startWorkingFrom,
    required this.rating,
    required this.numberOfRates,
    required this.dayOfWeek,
    this.roleSelected = 'Doctor',
  });

  final String roleSelected;

  final String fullName;

  final String email;

  final String password;

  final DateTime birthday;

  final String role;

  final String phone;

  final String specializationId;

  final int startWorkingFrom;

  final double rating;

  final int numberOfRates;

  final Map<String, List<int>> dayOfWeek;

  @override
  List<Object> get props => [
        fullName,
        email,
        password,
        birthday,
        role,
        phone,
        specializationId,
        startWorkingFrom,
        rating,
        numberOfRates,
        dayOfWeek,
        roleSelected,
      ];

  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
    String? roleSelected,
  });
}

final class CreateStaffInitial extends CreateStaffState {
  CreateStaffInitial.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          role: '',
          phone: '',
          specializationId: '',
          startWorkingFrom: 1,
          rating: 0.0,
          numberOfRates: 0,
          dayOfWeek: {
            'first': [1, 2]
          },
        );

  const CreateStaffInitial.input({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.roleSelected,
  });

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
    String? roleSelected,
  }) =>
      CreateStaffInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        roleSelected: roleSelected ?? super.roleSelected,
      );
}

final class CreateStaffLater extends CreateStaffState {
  CreateStaffLater.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          role: '',
          phone: '',
          specializationId: '',
          startWorkingFrom: 1,
          rating: 0.0,
          numberOfRates: 0,
          dayOfWeek: {
            'first': [1, 2]
          },
        );

  const CreateStaffLater.input({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.roleSelected,
  });

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
    String? roleSelected,
  }) =>
      CreateStaffLater.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        roleSelected: roleSelected ?? super.roleSelected,
      );
}

final class CreateStaffLoading extends CreateStaffState {
  const CreateStaffLoading({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.roleSelected,
  });

  factory CreateStaffLoading.from(CreateStaffState state) => CreateStaffLoading(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        roleSelected: state.roleSelected,
      );

  CreateStaffState toggleBackToInitial() => CreateStaffInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        role: role,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
        rating: rating,
        numberOfRates: numberOfRates,
        dayOfWeek: dayOfWeek,
        roleSelected: roleSelected,
      );

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
    String? roleSelected,
  }) =>
      CreateStaffLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        roleSelected: roleSelected ?? super.roleSelected,
      );
}

final class CreateStaffSuccess extends CreateStaffState {
  const CreateStaffSuccess({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.roleSelected,
  });

  factory CreateStaffSuccess.from(CreateStaffState state) => CreateStaffSuccess(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        roleSelected: state.roleSelected,
      );

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
    String? roleSelected,
  }) =>
      CreateStaffSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        roleSelected: roleSelected ?? super.roleSelected,
      );
}

final class CreateStaffFailure extends CreateStaffState {
  const CreateStaffFailure({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required this.message,
    required super.roleSelected,
  });

  factory CreateStaffFailure.from(CreateStaffState state, String message) =>
      CreateStaffFailure(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        message: message,
        roleSelected: state.roleSelected,
      );

  CreateStaffState toggleBackToInitial() => CreateStaffInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        role: role,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
        rating: rating,
        numberOfRates: numberOfRates,
        dayOfWeek: dayOfWeek,
        roleSelected: roleSelected,
      );

  final String message;

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
    String? roleSelected,
  }) =>
      CreateStaffFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        message: message,
        roleSelected: roleSelected ?? super.roleSelected,
      );
}
