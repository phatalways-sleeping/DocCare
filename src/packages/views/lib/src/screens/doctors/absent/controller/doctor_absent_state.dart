// ignore_for_file: public_member_api_docs

part of 'doctor_absent_bloc.dart';

@immutable
sealed class DoctorAbsentState extends Equatable {
  const DoctorAbsentState({
    this.date = '',
    this.reasons = '',
    this.agreeTerms = false,
    this.profileData = const {},
  });

  final String date;
  final String reasons;
  final bool agreeTerms;

  final Map<String, dynamic> profileData;

  @override
  List<Object?> get props => [
        date,
        reasons,
        agreeTerms,
        profileData,
      ];

  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    Map<String, dynamic>? profileData,
  });
}

final class DoctorAbsentInitial extends DoctorAbsentState {
  const DoctorAbsentInitial({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.profileData = const {},
  });

  factory DoctorAbsentInitial.fromState({
    required DoctorAbsentState state,
  }) =>
      DoctorAbsentInitial(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        profileData: state.profileData,
      );

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    Map<String, dynamic>? profileData,
    
  }) {
    return DoctorAbsentInitial(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      profileData: profileData ?? this.profileData,
    );
  }
}

final class DoctorAbsentLoading extends DoctorAbsentState {
  const DoctorAbsentLoading({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.profileData = const {},
  });

  factory DoctorAbsentLoading.fromState({
    required DoctorAbsentState state,
  }) =>
      DoctorAbsentLoading(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        profileData: state.profileData,
      );

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    Map<String, dynamic>? profileData,
  }) {
    return DoctorAbsentLoading(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      profileData: profileData ?? this.profileData,
    );
  }
}

final class DoctorAbsentSuccess extends DoctorAbsentState {
  const DoctorAbsentSuccess({
    super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.profileData = const {},
  });

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    bool? agreeTerms,
    Map<String, dynamic>? profileData,
  }) {
    return DoctorAbsentSuccess(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      profileData: profileData ?? this.profileData,
    );
  }
}

final class DoctorAbsentError extends DoctorAbsentState {
  const DoctorAbsentError({
    required this.errorMessage, super.date = '',
    super.reasons = '',
    super.agreeTerms = false,
    super.profileData = const {},
  });

  factory DoctorAbsentError.fromState({
    required DoctorAbsentState state,
    required String errorMessage,
  }) =>
      DoctorAbsentError(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        errorMessage: errorMessage,
        profileData: state.profileData,
      );

  final String errorMessage;

  @override
  DoctorAbsentState copyWith({
    String? date,
    String? reasons,
    String? errorMessage,
    bool? agreeTerms,
    Map<String, dynamic>? profileData,
  }) {
    return DoctorAbsentError(
      date: date ?? this.date,
      reasons: reasons ?? this.reasons,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      errorMessage: errorMessage ?? this.errorMessage,
      profileData: profileData ?? this.profileData,
    );
  }
}
