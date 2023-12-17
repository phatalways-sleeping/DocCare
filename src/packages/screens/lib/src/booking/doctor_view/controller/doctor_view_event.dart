// ignore_for_file: public_member_api_docs

part of 'doctor_view_bloc.dart';

@immutable
sealed class DoctorViewEvent extends Equatable {
  const DoctorViewEvent();

  @override
  List<Object?> get props => [];
}

final class DoctorViewInitialEvent extends DoctorViewEvent {
  const DoctorViewInitialEvent();
}

final class DoctorViewFilterEvent extends DoctorViewEvent {
  const DoctorViewFilterEvent();
}

final class DoctorViewStartSearchForNameEvent extends DoctorViewEvent {
  const DoctorViewStartSearchForNameEvent();
}

final class DoctorViewSearchForNameEvent extends DoctorViewEvent {
  const DoctorViewSearchForNameEvent({
    required this.searchedName,
  });

  final String searchedName;

  @override
  List<Object?> get props => [
        searchedName,
      ];
}

final class DoctorViewFilterSpecialtyEvent extends DoctorViewEvent {
  const DoctorViewFilterSpecialtyEvent({
    required this.specialty,
  });

  final String specialty;

  @override
  List<Object?> get props => [
        specialty,
      ];
}

final class DoctorViewFilterRatingEvent extends DoctorViewEvent {
  const DoctorViewFilterRatingEvent({
    required this.rating,
  });

  final String rating;

  @override
  List<Object?> get props => [
        rating,
      ];
}

final class DoctorViewResetFiltersEvent extends DoctorViewEvent {
  const DoctorViewResetFiltersEvent();
}

final class DoctorViewApplyFiltersEvent extends DoctorViewEvent {
  const DoctorViewApplyFiltersEvent();
}

final class DoctorViewChooseDoctorEvent extends DoctorViewEvent {
  const DoctorViewChooseDoctorEvent({
    required this.doctor,
  });

  final Map<String, dynamic> doctor;

  @override
  List<Object?> get props => [
        doctor,
      ];
}
