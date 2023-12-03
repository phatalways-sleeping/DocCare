part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState({
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

  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  });
}

final class ProfileInitial extends ProfileState {
  factory ProfileInitial.empty() {
    return ProfileInitial.input(
      fullName: '',
      email: '',
      tempBirthday: '',
      birthday: DateTime.now(),
      phone: '',
    );
  }

  const ProfileInitial.input({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  }) =>
      ProfileInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}

final class DoctorProfileInitial extends ProfileState {
  factory DoctorProfileInitial.empty() {
    return DoctorProfileInitial.input(
      fullName: '',
      email: '',
      tempBirthday: '',
      birthday: DateTime.now(),
      phone: '',
      specializationId: '',
      startWorkingFrom: 0,
    );
  }

  const DoctorProfileInitial.input({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required this.specializationId,
    required this.startWorkingFrom,
  });

  final String specializationId;
  final int startWorkingFrom;

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  }) =>
      DoctorProfileInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );
}

final class ProfileOnChange extends ProfileInitial {
  //Call parent .input() constructor
  const ProfileOnChange({
    required String fullName,
    required String email,
    required String tempBirthday,
    required DateTime birthday,
    required String phone,
  }) : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
        );

  factory ProfileOnChange.from(
    ProfileInitial profileInitial,
  ) =>
      ProfileOnChange(
        fullName: profileInitial.fullName,
        email: profileInitial.email,
        tempBirthday: profileInitial.tempBirthday,
        birthday: profileInitial.birthday,
        phone: profileInitial.phone,
      );

  @override
  ProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  }) =>
      ProfileOnChange(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );

  ProfileInitial toggleBackToInitial() => ProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
      );
}

final class DoctorProfileOnChange extends DoctorProfileInitial {
  //Call parent .input() constructor
  const DoctorProfileOnChange(
      {required String fullName,
      required String email,
      required String tempBirthday,
      required DateTime birthday,
      required String phone,
      required String specializationId,
      required int startWorkingFrom})
      : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
          specializationId: specializationId,
          startWorkingFrom: startWorkingFrom,
        );

  factory DoctorProfileOnChange.from(
    DoctorProfileInitial doctorProfileInitial,
  ) =>
      DoctorProfileOnChange(
        fullName: doctorProfileInitial.fullName,
        email: doctorProfileInitial.email,
        tempBirthday: doctorProfileInitial.tempBirthday,
        birthday: doctorProfileInitial.birthday,
        phone: doctorProfileInitial.phone,
        specializationId: doctorProfileInitial.specializationId,
        startWorkingFrom: doctorProfileInitial.startWorkingFrom,
      );

  @override
  DoctorProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileOnChange(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );

  DoctorProfileInitial toggleBackToInitial() => DoctorProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );
}

final class ProfileChangeSuccess extends ProfileInitial {
  const ProfileChangeSuccess({
    required String fullName,
    required String email,
    required String tempBirthday,
    required DateTime birthday,
    required String phone,
  }) : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
        );

  factory ProfileChangeSuccess.from(
    ProfileInitial profileInitial,
  ) =>
      ProfileChangeSuccess(
        fullName: profileInitial.fullName,
        email: profileInitial.email,
        tempBirthday: profileInitial.tempBirthday,
        birthday: profileInitial.birthday,
        phone: profileInitial.phone,
      );

  @override
  ProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  }) =>
      ProfileChangeSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}

final class DoctorProfileChangeSuccess extends DoctorProfileInitial {
  const DoctorProfileChangeSuccess(
      {required String fullName,
      required String email,
      required String tempBirthday,
      required DateTime birthday,
      required String phone,
      required String specializationId,
      required int startWorkingFrom})
      : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
          specializationId: specializationId,
          startWorkingFrom: startWorkingFrom,
        );

  factory DoctorProfileChangeSuccess.from(
    DoctorProfileInitial doctorProfileInitial,
  ) =>
      DoctorProfileChangeSuccess(
        fullName: doctorProfileInitial.fullName,
        email: doctorProfileInitial.email,
        tempBirthday: doctorProfileInitial.tempBirthday,
        birthday: doctorProfileInitial.birthday,
        phone: doctorProfileInitial.phone,
        specializationId: doctorProfileInitial.specializationId,
        startWorkingFrom: doctorProfileInitial.startWorkingFrom,
      );

  @override
  DoctorProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileChangeSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class ProfileChangeFailure extends ProfileInitial {
  const ProfileChangeFailure({
    required String fullName,
    required String email,
    required String tempBirthday,
    required DateTime birthday,
    required String phone,
  }) : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
        );

  factory ProfileChangeFailure.from(
    ProfileInitial profileInitial,
  ) =>
      ProfileChangeFailure(
        fullName: profileInitial.fullName,
        email: profileInitial.email,
        tempBirthday: profileInitial.tempBirthday,
        birthday: profileInitial.birthday,
        phone: profileInitial.phone,
      );

  @override
  ProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  }) =>
      ProfileChangeFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
      );
}

final class DoctorProfileChangeFailure extends DoctorProfileInitial {
  const DoctorProfileChangeFailure(
      {required String fullName,
      required String email,
      required String tempBirthday,
      required DateTime birthday,
      required String phone,
      required String specializationId,
      required int startWorkingFrom})
      : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
          specializationId: specializationId,
          startWorkingFrom: startWorkingFrom,
        );

  factory DoctorProfileChangeFailure.from(
          DoctorProfileInitial DoctorProfileState) =>
      DoctorProfileChangeFailure(
        fullName: DoctorProfileState.fullName,
        email: DoctorProfileState.email,
        tempBirthday: DoctorProfileState.tempBirthday,
        birthday: DoctorProfileState.birthday,
        phone: DoctorProfileState.phone,
        specializationId: DoctorProfileState.specializationId,
        startWorkingFrom: DoctorProfileState.startWorkingFrom,
      );

  @override
  DoctorProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileChangeFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class ProfileLoading extends ProfileInitial {
  const ProfileLoading({
    required String fullName,
    required String email,
    required String tempBirthday,
    required DateTime birthday,
    required String phone,
  }) : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
        );

  factory ProfileLoading.from(
    ProfileInitial profileInitial,
  ) =>
      ProfileLoading(
        fullName: profileInitial.fullName,
        email: profileInitial.email,
        tempBirthday: profileInitial.tempBirthday,
        birthday: profileInitial.birthday,
        phone: profileInitial.phone,
      );

  @override
  ProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
  }) =>
      ProfileLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
      );

  ProfileInitial toggleBackToInitial() => ProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
      );
}

final class DoctorProfileLoading extends DoctorProfileInitial {
  const DoctorProfileLoading(
      {required String fullName,
      required String email,
      required String tempBirthday,
      required DateTime birthday,
      required String phone,
      required String specializationId,
      required int startWorkingFrom})
      : super.input(
          fullName: fullName,
          email: email,
          tempBirthday: tempBirthday,
          birthday: birthday,
          phone: phone,
          specializationId: specializationId,
          startWorkingFrom: startWorkingFrom,
        );

  factory DoctorProfileLoading.from(
          DoctorProfileInitial doctorProfileInitial) =>
      DoctorProfileLoading(
        fullName: doctorProfileInitial.fullName,
        email: doctorProfileInitial.email,
        tempBirthday: doctorProfileInitial.tempBirthday,
        birthday: doctorProfileInitial.birthday,
        phone: doctorProfileInitial.phone,
        specializationId: doctorProfileInitial.specializationId,
        startWorkingFrom: doctorProfileInitial.startWorkingFrom,
      );

  DoctorProfileInitial toggleBackToInitial() => DoctorProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );

  @override
  DoctorProfileInitial copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}
