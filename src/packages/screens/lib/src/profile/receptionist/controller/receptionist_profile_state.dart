part of 'receptionist_profile_bloc.dart';

@immutable
sealed class ReceptionistProfileState extends Equatable {
  const ReceptionistProfileState({
    required this.fullName,
    required this.email,
    required this.tempBirthday,
    required this.birthday,
    required this.phone,
  });

  final String fullName;
  final String email;
  final String tempBirthday;
  final DateTime birthday;
  final String phone;

  @override
  List<Object?> get props => [
        fullName,
        email,
        tempBirthday,
        birthday,
        phone,
      ];

  ReceptionistProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  });
}

final class ReceptionistProfileInitial extends ReceptionistProfileState {
  ReceptionistProfileInitial.empty()
      : super(
          fullName: '',
          email: '',
          tempBirthday: '',
          birthday: DateTime.now(),
          phone: '',
        );

  const ReceptionistProfileInitial.input({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  @override
  ReceptionistProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ReceptionistProfileInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}

final class ReceptionistProfileOnChange extends ReceptionistProfileState {
  const ReceptionistProfileOnChange({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory ReceptionistProfileOnChange.from(
          ReceptionistProfileState ReceptionistProfileState) =>
      ReceptionistProfileOnChange(
        fullName: ReceptionistProfileState.fullName,
        email: ReceptionistProfileState.email,
        tempBirthday: ReceptionistProfileState.tempBirthday,
        birthday: ReceptionistProfileState.birthday,
        phone: ReceptionistProfileState.phone,
      );

  @override
  ReceptionistProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ReceptionistProfileOnChange(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );

  ReceptionistProfileState toggleBackToInitial() =>
      ReceptionistProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
      );
}

final class ReceptionistProfileChangeSuccess extends ReceptionistProfileState {
  const ReceptionistProfileChangeSuccess({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory ReceptionistProfileChangeSuccess.from(
          ReceptionistProfileState ReceptionistProfileState) =>
      ReceptionistProfileChangeSuccess(
        fullName: ReceptionistProfileState.fullName,
        email: ReceptionistProfileState.email,
        tempBirthday: ReceptionistProfileState.tempBirthday,
        birthday: ReceptionistProfileState.birthday,
        phone: ReceptionistProfileState.phone,
      );

  @override
  ReceptionistProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ReceptionistProfileChangeSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
      );
}

final class ReceptionistProfileChangeFailure extends ReceptionistProfileState {
  const ReceptionistProfileChangeFailure({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory ReceptionistProfileChangeFailure.from(
          ReceptionistProfileState ReceptionistProfileState) =>
      ReceptionistProfileChangeFailure(
        fullName: ReceptionistProfileState.fullName,
        email: ReceptionistProfileState.email,
        tempBirthday: ReceptionistProfileState.tempBirthday,
        birthday: ReceptionistProfileState.birthday,
        phone: ReceptionistProfileState.phone,
      );

  @override
  ReceptionistProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ReceptionistProfileChangeFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}

final class ReceptionistProfileLoading extends ReceptionistProfileState {
  const ReceptionistProfileLoading({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory ReceptionistProfileLoading.from(
          ReceptionistProfileState ReceptionistProfileState) =>
      ReceptionistProfileLoading(
        fullName: ReceptionistProfileState.fullName,
        email: ReceptionistProfileState.email,
        tempBirthday: ReceptionistProfileState.tempBirthday,
        birthday: ReceptionistProfileState.birthday,
        phone: ReceptionistProfileState.phone,
      );

  ReceptionistProfileState toggleBackToInitial() =>
      ReceptionistProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
      );

  @override
  ReceptionistProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ReceptionistProfileLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}
