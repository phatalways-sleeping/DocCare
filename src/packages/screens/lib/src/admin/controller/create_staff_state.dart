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
    required this.specializationList,
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

  final List<String> specializationList;

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
        specializationList,
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
    List<String> specializationList,
  });
}

final class CreateStaffInitial extends CreateStaffState {
  const CreateStaffInitial({
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
    required super.specializationList,
  });
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
          specializationList: [],
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
    required super.specializationList,
  });
  factory CreateStaffInitial.from(CreateStaffState state) => CreateStaffInitial(
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
        specializationList: state.specializationList,
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
    List<String>? specializationList,
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
        specializationList: specializationList ?? super.specializationList,
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
    required super.specializationList,
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
          specializationList: [],
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
    required super.specializationList,
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
        specializationList: state.specializationList,
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
    List<String>? specializationList,
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
        specializationList: specializationList ?? super.specializationList,
      );
}

final class CreateStaffLoading extends CreateStaffState {
  CreateStaffLoading.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          tempBirthday: '',
          role: 'Doctor',
          phone: '',
          specializationId: '',
          startWorkingFrom: 1,
          rating: 0.0,
          numberOfRates: 0,
          dayOfWeek: {
            'first': [1, 2]
          },
          specializationList: [],
        );
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
    required super.specializationList,
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
        specializationList: state.specializationList,
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
        specializationList: specializationList,
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
    List<String>? specializationList,
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
        specializationList: specializationList ?? super.specializationList,
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
    required super.specializationList,
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
        specializationList: state.specializationList,
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
    List<String>? specializationList,
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
        specializationList: specializationList ?? super.specializationList,
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
    required super.specializationList,
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
        specializationList: state.specializationList,
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
        specializationList: specializationList,
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
    List<String>? specializationList,
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
        specializationList: specializationList ?? super.specializationList,
        message: message,
      );
}
