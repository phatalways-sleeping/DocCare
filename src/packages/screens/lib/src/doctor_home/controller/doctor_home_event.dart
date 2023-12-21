part of 'doctor_home_bloc.dart';

@immutable
sealed class DoctorHomeEvent extends Equatable {
  const DoctorHomeEvent();

  @override
  List<Object?> get props => [];
}

final class DoctorHomeInitialEvent extends DoctorHomeEvent {
  const DoctorHomeInitialEvent();

  @override
  List<Object?> get props => [];
}

// final class DoctorHomeReviewEvent extends DoctorHomeEvent {
//   const DoctorHomeReviewEvent(this.rating, this.index);

//   final int rating;
//   final int index;

//   @override
//   List<Object?> get props => [rating];
//  }

// final class DoctorSelectDateEvent extends DoctorHomeEvent {
//   const DoctorSelectDateEvent(this.date);

//   final DateTime date;

//   @override
//   List<Object?> get props => [date];
// }
final class DoctorSelectDateEvent extends DoctorHomeEvent {
  const DoctorSelectDateEvent({
    required this.selectedDate,
  });

  final DateTime selectedDate;

  @override
  List<Object?> get props => [
        selectedDate,
      ];
}





final class DoctorScheduleBackEvent extends DoctorHomeEvent {
  const DoctorScheduleBackEvent();

  @override
  List<Object?> get props => [];
}

// final class PrescriptionOnTickEvent extends DoctorHomeEvent {
//   const PrescriptionOnTickEvent(this.index);

//   final int index;

//   @override
//   List<Object?> get props => [index];
// }