// ignore_for_file: public_member_api_docs, non_constant_identifier_names, prefer_int_literals

part of 'create_staff_bloc.dart';

@immutable
sealed class CreateStaffState extends Equatable {
  const CreateStaffState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthday,
    required this.tempBirthday,
    this.role = 'Doctor',
    required this.phone,
    required this.specializationId,
    required this.startWorkingFrom,
    required this.rating,
    required this.numberOfRates,
    required this.dayOfWeek,
  });

  final String fullName;

  final String email;

  final String password;

  final DateTime birthday;

  final String tempBirthday;

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
        tempBirthday,
        role,
        phone,
        specializationId,
        startWorkingFrom,
        rating,
        numberOfRates,
        dayOfWeek,
      ];

  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? role,
    String? phone,
    String specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
  });
}

final class CreateStaffInitial extends CreateStaffState {
  CreateStaffInitial.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          tempBirthday: '',
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
    required super.tempBirthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
  });

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
  }) =>
      CreateStaffInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
      );
}

final class CreateStaffLater extends CreateStaffState {
  const CreateStaffLater({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
  });
  CreateStaffLater.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          tempBirthday: '',
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
    required super.tempBirthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
  });
  factory CreateStaffLater.from(CreateStaffState state) => CreateStaffLater(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
      );

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
  }) =>
      CreateStaffLater.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
      );
}

final class CreateStaffLoading extends CreateStaffState {
  const CreateStaffLoading({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
  });

  factory CreateStaffLoading.from(CreateStaffState state) => CreateStaffLoading(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
      );

  CreateStaffState toggleBackToInitial() => CreateStaffInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        tempBirthday: tempBirthday,
        role: role,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
        rating: rating,
        numberOfRates: numberOfRates,
        dayOfWeek: dayOfWeek,
      );

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
  }) =>
      CreateStaffLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
      );
}

final class CreateStaffSuccess extends CreateStaffState {
  const CreateStaffSuccess({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
  });

  factory CreateStaffSuccess.from(CreateStaffState state) => CreateStaffSuccess(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
      );

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
  }) =>
      CreateStaffSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
      );
}

final class CreateStaffFailure extends CreateStaffState {
  const CreateStaffFailure({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.tempBirthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required this.message,
  });

  factory CreateStaffFailure.from(CreateStaffState state, String message) =>
      CreateStaffFailure(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        tempBirthday: state.tempBirthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        message: message,
      );

  CreateStaffState toggleBackToInitial() => CreateStaffInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        tempBirthday: tempBirthday,
        role: role,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
        rating: rating,
        numberOfRates: numberOfRates,
        dayOfWeek: dayOfWeek,
      );

  final String message;

  @override
  CreateStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? tempBirthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    Map<String, List<int>>? dayOfWeek,
  }) =>
      CreateStaffFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        message: message,
      );
}
